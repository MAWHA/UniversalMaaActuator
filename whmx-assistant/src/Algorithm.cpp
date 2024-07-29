/* Copyright 2024 周上行Ryer

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

#include "Algorithm.h"

#include <vector>
#include <algorithm>

int min_edit_distance(const QString &src, const QString &dst) {
    const int m = dst.length() + 1;
    const int n = src.length() + 1;

    std::vector<int> dp(m * n);

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            const int k = i * n + j;
            if (i == 0 || j == 0) {
                dp[k] = 0;
            } else if (dst.at(i - 1) == src.at(j - 1)) {
                dp[k] = dp[k - n - 1];
            } else {
                dp[k] = std::min(std::min(dp[k - 1], dp[k - n]), dp[k - n - 1]) + 1;
            }
        }
    }

    return dp.back();
}
