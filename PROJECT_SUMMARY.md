# ملخص مشروع نظام تدبير عيادة طبية

## 📋 نظرة عامة

تم تطوير نظام احترافي كامل لإدارة عيادة طبية باستخدام **Python** و **CustomTkinter** و **MySQL** مع واجهات عصرية وألوان احترافية.

## 🎯 الميزات الرئيسية

### 1. نظام تسجيل الدخول
- واجهة دخول احترافية بألوان هادئة
- دعم دورين: **Secrétaire** و **Doctor**
- فتح Dashboard مناسبة للدور بعد تسجيل الدخول

### 2. قاعدة بيانات MySQL
- **4 جداول رئيسية**:
  - `users`: إدارة المستخدمين
  - `patients`: إدارة المرضى
  - `rendezvous`: إدارة المواعيد
  - `diagnostics`: إدارة التشخيصات
- روابط Foreign Keys للحفاظ على سلامة البيانات
- Indexes لتحسين الأداء

### 3. واجهة السكرتيرة
- قائمة المرضى في جدول أنيق (Treeview)
- إدارة كاملة للمرضى (إضافة، تعديل، حذف، بحث)
- إدارة المواعيد (إضافة، تعديل، حذف، تغيير الحالة)
- Calendar اختيار التاريخ (tkcalendar)
- منطقة إشعارات للمواعيد القريبة
- تصدير بيانات المرضى إلى CSV

### 4. واجهة الطبيب
- عرض قائمة المرضى
- فتح Dossier Médical لكل مريض
- عرض التشخيصات القديمة
- إضافة تشخيص جديد مع حفظ تلقائي للتاريخ
- تصدير التشخيصات إلى PDF

## 🎨 التصميم

### الألوان المستخدمة
- **Primary Colors**: Blue tones (#1E88E5, #1565C0, #42A5F5)
- **Secondary Colors**: Turquoise (#00ACC1, #00838F, #26C6DA)
- **Neutral Colors**: White, Grey tones
- **Success/Error/Warning**: Green, Red, Yellow

### العناصر التصميمية
- CustomTkinter theme احترافي
- أزرار مسطحة
- مربعات نصوص rounded
- نوافذ منبثقة (Modal windows)
- Responsive Design

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
├── utils/
│   └── export_utils.py        # أدوات التصدير (CSV, PDF)
├── README.md                  # الوثائق الكاملة
└── requirements.txt           # المكتبات المطلوبة
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

## 🚀 كيفية التشغيل

### المتطلبات الأساسية
```bash
# تثبيت المكتبات
pip install customtkinter mysql-connector-python tkcalendar reportlab

# تثبيت tkinter
sudo apt-get install python3-tk

# تشغيل MySQL
sudo service mysql start

# إنشاء قاعدة البيانات
sudo mysql < database_setup.sql

# تشغيل التطبيق
python3 main.py
```

## 📊 قاعدة البيانات

### الجداول
1. **users**: id, username, password, role
2. **patients**: id, nom, prenom, cin, age, telephone, adresse
3. **rendezvous**: id, patient_id, date, heure, type, status
4. **diagnostics**: id, patient_id, doctor_id, diagnostic, date_diagnostic

### الاتصال
- الافتراضي: localhost, root, بدون كلمة مرور
- يمكن تغييرها في `config/db_config.py`

## 🎯 المميزات الفنية

### قاعدة البيانات
- MySQL 8.0+
- Foreign Keys
- Indexes
- Transactions

### الواجهة
- CustomTkinter
- Responsive Design
- Dark/Light Mode
- Modal Windows

### الأمان
- Validation للبيانات
- Error Handling
- SQL Injection Prevention

## 📝 ملاحظات مهمة

1. **لا يتم تشفير كلمات المرور** في هذا الإصدار (Password Hash)
2. قاعدة البيانات تستخدم root بدون كلمة مرور (يجب تغييرها في الإنتاج)
3. يمكن تحسين النظام بإضافة:
   - تشفير كلمات المرور
   - إشعارات بريد إلكتروني
   - رسوم بيانية إحصائية
   - نسخ احتياطي تلقائي

## 📁 الملفات المرفقة

1. **medical_cabinet_project.zip** - ملف مضغوط يحتوي على جميع ملفات المشروع
2. **README.md** - الوثائق الكاملة للمشروع
3. **INSTRUCTIONS.md** - تعليمات التشغيل بالتفصيل
4. **PROJECT_SUMMARY.md** - ملخص المشروع

## ✅ حالة المشروع

- ✅ قاعدة البيانات جاهزة
- ✅ نظام تسجيل الدخول يعمل
- ✅ واجهة السكرتيرة كاملة
- ✅ واجهة الطبيب كاملة
- ✅ أدوات التصدير تعمل
- ✅ جميع الأخطاء البرمجية مصححة
- ✅ المشروع جاهز للتشغيل

## 📞 الدعم

للاستفسارات والدعم الفني:
- البريد الإلكتروني
- الواتساب
- البريد التقني

---

**تم تطوير هذا النظام باستخدام Python و CustomTkinter و MySQL**

**تاريخ الإصدار**: ديسمبر 2025  
**الإصدار**: 1.0  
**المطور**: فريق التطوير  
**اللغة**: Python 3.11+
