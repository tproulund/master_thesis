#ifndef UIFUNCTIONS_H_INCLUDED
#define UIFUNCTIONS_H_INCLUDED

#include <QObject>
#include <QString>

#include "Proxy.h"
#include "widgets/all.h"

class UIFunctions : public QObject
{
    Q_OBJECT

public:
    virtual ~UIFunctions();

    static UIFunctions * getInstance(QObject *parent = 0);
    static void destroyInstance();

private:
    UIFunctions(QObject *parent = 0);

    static UIFunctions *instance;

public slots:

private slots:
    void onButtonClick(Widget *widget);
    void onValueChange(Widget *widget, int value);
    void onValueChange(Widget *widget, double value);
    void onValueChange(Widget *widget, QString value);
    void onEditingFinished(Edit *edit, QString value);
    void onWindowClose(Window *window);
    void onLoadImageFromFile(Image *image, const char *filename, int w, int h);

signals:
    void create(Proxy *proxy);
    void destroy(Proxy *proxy);
    void showWindow(Window *window);
    void hideWindow(Window *window);
    void setPosition(Window *window, int x, int y);
    void setImage(Image *image, const char *data, int w, int h);
    void sceneChange(Window *window, int oldSceneID, int newSceneID);
    void setEnabled(Widget *widget, bool enabled);
    void setEditValue(Edit *edit, std::string value, bool suppressSignals);
    void setSpinboxValue(Spinbox *spinbox, double value, bool suppressSignals);
    void setLabelText(Label *label, std::string text, bool suppressSignals);
    void setSliderValue(Slider *slider, int value, bool suppressSignals);
    void setCheckboxValue(Checkbox *checkbox, int value, bool suppressSignals);
    void setRadiobuttonValue(Radiobutton *radiobutton, int value, bool suppressSignals);
    void insertComboboxItem(Combobox *combobox, int index, std::string text, bool suppressSignals);
    void removeComboboxItem(Combobox *combobox, int index, bool suppressSignals);
};

#endif // UIFUNCTIONS_H_INCLUDED

