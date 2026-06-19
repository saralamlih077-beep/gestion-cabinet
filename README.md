# نظام تدبير عيادة طبية - Gestion Cabinet Médical

نظام احترافي لإدارة عيادة طبية باستخدام Python و CustomTkinter و MySQL مع واجهات عصرية وألوان احترافية.

## 📋 الميزات الرئيسية

### 1. نظام تسجيل الدخول (Login System)
- واجهة دخول احترافية بألوان هادئة
- حقول: Username, Password, Role (Secrétaire / Doctor)
- فتح Dashboard مناسبة للدور بعد تسجيل الدخول

### 2. قاعدة بيانات MySQL
- جدول `users`: إدارة المستخدمين
- جدول `patients`: إدارة المرضى
- جدول `rendezvous`: إدارة المواعيد
- جدول `diagnostics`: إدارة التشخيصات
- روابط Foreign Keys بين الجداول

### 3. واجهة السكرتيرة (Secrétaire Dashboard)
- قائمة المرضى في جدول أنيق (Treeview)
- زر إضافة / تعديل / حذف مريض
- شريط بحث للبحث عن المرضى
- إدارة المواعيد (Ajouter / Modifier / Supprimer)
- Calendar اختيار التاريخ (tkcalendar)
- منطقة Notifications للمواعيد القريبة
- تصميم: Sidebar جانبية بأيقونات + Header modern
- ألوان: Blue + White + Light grey

### 4. واجهة الطبيب (Doctor Dashboard)
- عرض قائمة المرضى
- عند اختيار مريض → فتح Dossier Médical
- عرض التشخيصات القديمة في جدول
- Textbox كبيرة لإضافة التشخيص الجديد
- زر حفظ "Enregistrer Diagnostic"
- التاريخ يتم إضافته أوتوماتيكياً
- زر طباعة PDF للتشخيص
- تصميم: Card UI style (إطارات ناعمة)
- ألوان: Turquoise + White

### 5. ميزات إضافية
- Export PDF للـ Diagnostic باستعمال ReportLab
- Export CSV للمرضى
- إحصائيات صغيرة في Dashboard (عدد المرضى، عدد RDV اليوم)

## 🎨 التصميم والواجهة

### الألوان المستخدمة
- **Primary Colors**: Blue tones (#1E88E5, #1565C0, #42A5F5)
- **Secondary Colors**: Turquoise (#00ACC1, #00838F, #26C6DA)
- **Neutral Colors**: White, Grey tones
- **Success/Error/Warning**: Green, Red, Yellow

### العناصر التصميمية
- CustomTkinter theme احترافي ومظهر عصري
- ألوان متناسقة (Blue gradients / Turquoise / Grey)
- أزرار مسطحة (Flat buttons)
- مربعات نصوص rounded
- نوافذ منبثقة (Modal windows) لإضافة أو تعديل المرضى
- Responsive resizing قدر الإمكان

## 📂 هيكل المشروع

```
medical_cabinet/
├── main.py                    # نقطة الدخول الرئيسية
├── database_setup.sql         # ملف إنشاء قاعدة البيانات
├── login.py                   # نظام تسجيل الدخول
├── config/
│   ├── db_config.py           # تكوين قاعدة البيانات
│   └── theme.py               # ألوان وثيمات الواجهة
├── dashboard/
│   ├── secretaire_dashboard.py # واجهة السكرتيرة
│   └── doctor_dashboard.py    # واجهة الطبيب
├── patients/
│   └── patient_form.py        # نموذج إضافة/تعديل المريض
├── appointments/
│   └── appointment_form.py    # نموذج إضافة/تعديل الموعد
├── diagnostics/
│   └── (ملفات إدارة التشخيصات)
├── utils/
│   └── export_utils.py        # أدوات التصدير (CSV, PDF)
└── assets/
    └── (ملفات الأصول)
```

## 🚀 كيفية التشغيل

### المتطلبات الأساسية
- Python 3.11+
- MySQL Server
- CustomTkinter
- mysql-connector-python
- tkcalendar
- reportlab

### التثبيت

```bash
# تثبيت المكتبات المطلوبة
pip install customtkinter mysql-connector-python tkcalendar reportlab

# أو باستخدام sudo
sudo pip install customtkinter mysql-connector-python tkcalendar reportlab
```

### إعداد قاعدة البيانات

```bash
# تشغيل خدمة MySQL
sudo service mysql start

# إنشاء قاعدة البيانات والجداول
sudo mysql < database_setup.sql
```

### تشغيل التطبيق

```bash
python main.py
```

## 🔐 بيانات الاعتماد الافتراضية

### السكرتيرة
- **Username**: admin
- **Password**: admin123
- **Role**: secretaire

### الطبيب
- **Username**: dr_smith
- **Password**: doc123
- **Role**: doctor

## 📊 وظائف النظام

### السكرتيرة
1. **إدارة المرضى**
   - إضافة مريض جديد
   - تعديل معلومات المريض
   - حذف مريض
   - البحث عن مريض

2. **إدارة المواعيد**
   - إضافة موعد جديد
   - تعديل موعد
   - حذف موعد
   - تغيير حالة الموعد (Pending, Confirmed, Completed, Cancelled)

3. **الإحصائيات**
   - عدد المرضى الكلي
   - عدد المواعيد اليوم
   - عدد المواعيد في انتظار التأكيد
   - إشعارات بالمواعيد القادمة

4. **التصدير**
   - تصدير بيانات المرضى إلى CSV

### الطبيب
1. **عرض المرضى**
   - قائمة بجميع المرضى
   - البحث عن مريض

2. **إدارة التشخيصات**
   - فتح Dossier Médical لكل مريض
   - عرض التشخيصات القديمة
   - إضافة تشخيص جديد
   - حفظ التشخيص مع التاريخ التلقائي
   - تصدير التشخيص إلى PDF

3. **الإحصائيات**
   - عدد المرضى الكلي
   - عدد التشخيصات الكلي
   - عدد التشخيصات اليوم

4. **التصدير**
   - تصدير جميع التشخيصات إلى PDF

## 🎯 المميزات الفنية

### قاعدة البيانات
- MySQL 8.0+
- Foreign Keys للحفاظ على سلامة البيانات
- Indexes لتحسين الأداء
- Transactions لضمان سلامة البيانات

### الواجهة
- CustomTkinter لتصميم عصري
- Responsive Design
- Dark/Light Mode
- Animation Effects
- Modal Windows

### الأمان
- Validation للبيانات المدخلة
- Error Handling شامل
- Database Connection Management
- SQL Injection Prevention

## 📝 ملاحظات مهمة

1. **لا يتم تشفير كلمات المرور** في هذا الإصدار (Password Hash)
2. يمكن إضافة تشفير كلمات المرور لاحقاً باستخدام bcrypt أو hashlib
3. قاعدة البيانات تستخدم root بدون كلمة مرور (يجب تغييرها في الإنتاج)
4. يمكن تحسين النظام بإضافة:
   - نظام حجز مواعيد عبر الإنترنت
   - إشعارات بريد إلكتروني أو SMS
   - تقارير مفصلة
   - رسوم بيانية إحصائية
   - نسخ احتياطي تلقائي

## 🤝 المساهمة

يمكنك المساهمة في تحسين هذا المشروع بإضافة:
- ميزات جديدة
- تحسينات في التصميم
- تحسينات في الأداء
- دعم لغات إضافية
- وثائق أكثر تفصيلاً

## 📄 الترخيص

هذا المشروع مفتوح المصدر ومجاني للاستخدام.

## 📞 الدعم

للاستفسارات والدعم الفني، يمكنك التواصل عبر:
- البريد الإلكتروني
- الواتساب
- البريد التقني

---

**تم تطوير هذا النظام باستخدام Python و CustomTkinter و MySQL**

**تاريخ الإصدار**: ديسمبر 2025  
**الإصدار**: 1.0  
**المطور**: فريق التطوير  
**اللغة**: Python 3.11+
