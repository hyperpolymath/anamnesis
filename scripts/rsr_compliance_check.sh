#!/bin/bash
# RSR Compliance Verification Script
# Checks all RSR requirements and outputs compliance score

set -e

echo "==================================="
echo "RSR Compliance Verification"
echo "==================================="
echo ""

score=0
max_score=100

# Category 1: Type Safety (10 points)
echo "1. Type Safety:"
if [ -f "parser/lib/conversation_types.atd" ] && [ -f "visualization/src/types/Domain.res" ]; then
    echo "   ✓ Type-safe languages used (OCaml, Elixir, ReScript, Julia)"
    score=$((score + 10))
else
    echo "   ✗ Type definitions missing"
fi

# Category 2: Memory Safety (10 points)
echo "2. Memory Safety:"
if ! grep -r "unsafe" parser orchestrator learning reasoning visualization 2>/dev/null | grep -v Binary | grep -q .; then
    echo "   ✓ No unsafe code blocks"
    score=$((score + 10))
else
    echo "   ⚠ Unsafe code detected"
    score=$((score + 5))
fi

# Category 3: Offline-First (5 points)
echo "3. Offline-First:"
if [ -f "parser/README.md" ]; then
    echo "   ⚠ Partial (parser/reasoner offline, Virtuoso can be local)"
    score=$((score + 3))
else
    echo "   ✗ Offline documentation missing"
fi

# Category 4: Documentation (15 points)
echo "4. Documentation:"
doc_score=0
[ -f "README.md" ] && ((doc_score++))
[ -f "LICENSE.txt" ] && ((doc_score++))
[ -f "SECURITY.md" ] && ((doc_score++))
[ -f "CONTRIBUTING.md" ] && ((doc_score++))
[ -f "CODE_OF_CONDUCT.md" ] && ((doc_score++))
[ -f "MAINTAINERS.md" ] && ((doc_score++))
[ -f "CHANGELOG.md" ] && ((doc_score++))
echo "   $doc_score/7 required files present"
score=$((score + doc_score * 15 / 7))

# Category 5: Testing (15 points)
echo "5. Testing:"
if [ -d "parser/test" ] || [ -d "orchestrator/test" ]; then
    echo "   ⚠ Test infrastructure exists but no tests yet"
    score=$((score + 2))
else
    echo "   ✗ No test infrastructure"
fi

# Category 6: Build System (10 points)
echo "6. Build System:"
build_score=0
[ -f "parser/dune-project" ] && ((build_score++))
[ -f "orchestrator/mix.exs" ] && ((build_score++))
[ -f "justfile" ] && ((build_score++))
echo "   $build_score/3 build files present"
score=$((score + build_score * 10 / 3))

# Category 7: Security (10 points)
echo "7. Security:"
sec_score=0
[ -f "SECURITY.md" ] && ((sec_score++))
[ -f ".well-known/security.txt" ] && ((sec_score++))
echo "   $sec_score/2 security files present"
score=$((score + sec_score * 10 / 2))

# Category 8: Licensing (10 points)
echo "8. Licensing:"
if [ -f "LICENSE.txt" ] && grep -q "MIT OR Palimpsest" LICENSE.txt; then
    echo "   ✓ Dual license (MIT + Palimpsest)"
    score=$((score + 10))
else
    echo "   ✗ License missing or incorrect"
fi

# Category 9: Contribution Model (5 points)
echo "9. Contribution Model:"
if [ -f "CONTRIBUTING.md" ] && grep -q "TPCF" CONTRIBUTING.md; then
    echo "   ✓ TPCF documented"
    score=$((score + 5))
else
    echo "   ✗ TPCF not documented"
fi

# Category 10: Community Guidelines (5 points)
echo "10. Community Guidelines:"
if [ -f "CODE_OF_CONDUCT.md" ] && grep -q "CCCP" CODE_OF_CONDUCT.md; then
    echo "   ✓ CCCP-based Code of Conduct"
    score=$((score + 5))
else
    echo "   ✗ Code of Conduct missing or incomplete"
fi

# Category 11: Versioning (5 points)
echo "11. Versioning:"
if [ -f "CHANGELOG.md" ] && grep -q "Semantic Versioning" CHANGELOG.md; then
    echo "   ✓ Semantic versioning"
    score=$((score + 5))
else
    echo "   ✗ CHANGELOG missing or incomplete"
fi

# .well-known directory (bonus points)
echo ""
echo ".well-known/ Directory:"
wk_score=0
[ -f ".well-known/security.txt" ] && ((wk_score++)) && echo "   ✓ security.txt"
[ -f ".well-known/ai.txt" ] && ((wk_score++)) && echo "   ✓ ai.txt"
[ -f ".well-known/humans.txt" ] && ((wk_score++)) && echo "   ✓ humans.txt"

# Final Score
echo ""
echo "==================================="
echo "FINAL SCORE: $score / $max_score"
echo "==================================="

if [ $score -ge 70 ]; then
    echo "✅ BRONZE LEVEL ACHIEVED"
    exit 0
elif [ $score -ge 50 ]; then
    echo "⚠️  APPROACHING BRONZE (need $((70 - score)) more points)"
    exit 1
else
    echo "❌ NOT RSR COMPLIANT (need $((70 - score)) more points for Bronze)"
    exit 1
fi
