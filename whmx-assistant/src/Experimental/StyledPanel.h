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

#pragma once

#include <QtWidgets/QWidget>
#include <gsl/gsl>

namespace Experimental {

class StyledPanel : public QWidget {
    Q_OBJECT

public:
    void set_shadow_width(int width);

public:
    StyledPanel(gsl::not_null<gsl::owner<QWidget *>> widget);

protected:
    void paintEvent(QPaintEvent *event) override;

private:
    gsl::strict_not_null<gsl::owner<QWidget *>> widget_;
    int                                         shadow_width_;
};

} // namespace Experimental
