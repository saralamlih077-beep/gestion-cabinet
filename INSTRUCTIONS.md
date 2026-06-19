# تعليمات التشغيل - Instructions

## 📋 المتطلبات الأساسية

### 1. Python 3.11+
تأكد من تثبيت Python 3.11 أو أحدث:
```bash
python3 --version
```

### 2. MySQL Server
تأكد من تثبيت MySQL Server:
```bash
sudo apt-get update
sudo apt-get install mysql-server
sudo service mysql start
```

### 3. المكتبات المطلوبة
قم بتثبيت المكتبات المطلوبة:
```bash
pip install customtkinter mysql-connector-python tkcalendar reportlab
```

أو باستخدام sudo:
```bash
sudo pip install customtkinter mysql-connector-python tkcalendar reportlab
```

### 4. tkinter
تأكد من تثبيت tkinter:
```bash
sudo apt-get install python3-tk
```

## 🚀 كيفية تشغيل النظام

### الخطوة 1: إعداد قاعدة البيانات

```bash
# تشغيل خدمة MySQL
sudo service mysql start

# إنشاء قاعدة البيانات والجداول
sudo mysql < database_setup.sql
```

### الخطوة 2: تشغيل التطبيق

```bash
python3 main.py
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

## 📁 هيكل الملفات

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
│   └── export_utils.py        # أدوات التصدير
└── README.md                  # الوثائق الكاملة
```

## 🎯 المميزات

### السكرتيرة
1. إدارة المرضى (إضافة، تعديل، حذف، بحث)
2. إدارة المواعيد (إضافة، تعديل، حذف، تغيير الحالة)
3. الإحصائيات (عدد المرضى، المواعيد، الإشعارات)
4. تصدير بيانات المرضى إلى CSV

### الطبيب
1. عرض قائمة المرضى
2. فتح Dossier Médical لكل مريض
3. إدارة التشخيصات (عرض، إضافة، حفظ)
4. تصدير التشخيصات إلى PDF
5. الإحصائيات (عدد المرضى، التشخيصات)

## 📊 قاعدة البيانات

### الجداول
1. **users**: إدارة المستخدمين
2. **patients**: إدارة المرضى
3. **rendezvous**: إدارة المواعيد
4. **diagnostics**: إدارة التشخيصات

### الاتصال بقاعدة البيانات
- الافتراضي: localhost, root, بدون كلمة مرور
- يمكن تغييرها في ملف `config/db_config.py`

## 🎨 التصميم

### الألوان
- **Primary**: Blue (#1E88E5)
- **Secondary**: Turquoise (#00ACC1)
- **Neutral**: White, Grey

### العناصر
- CustomTkinter theme احترافي
- أزرار مسطحة
- مربعات نصوص rounded
- نوافذ منبثقة (Modal windows)

## 🐛 استكشاف الأخطاء

### خطأ: ModuleNotFoundError: No module named 'customtkinter'
```bash
pip install customtkinter
```

### خطأ: No module named 'tkinter'
```bash
sudo apt-get install python3-tk
```

### خطأ: Unable to connect to MySQL
تأكد من تشغيل خدمة MySQL:
```bash
sudo service mysql start
```

### خطأ: Table 'medical_cabinet.users' doesn't exist
تأكد من تشغيل ملف database_setup.sql:
```bash
sudo mysql < database_setup.sql
```

## 📝 ملاحظات مهمة

1. **لا يتم تشفير كلمات المرور** في هذا الإصدار
2. قاعدة البيانات تستخدم root بدون كلمة مرور (يجب تغييرها في الإنتاج)
3. يمكن تحسين النظام بإضافة:
   - تشفير كلمات المرور
   - إشعارات بريد إلكتروني
   - رسوم بيانية إحصائية
   - نسخ احتياطي تلقائي

## 🎯 نصائح للتطوير

### إضافة تشفير كلمات المرور
```python
import hashlib

# تشفير كلمة المرور
password = "password123"
hashed_password = hashlib.sha256(password.encode()).hexdigest()
```

### تغيير بيانات الاتصال بقاعدة البيانات
في ملف `config/db_config.py`:
```python
DB_CONFIG = {
    'host': 'localhost',
    'database': 'medical_cabinet',
    'user': 'your_username',
    'password': 'your_password'
}
```

### إضافة ميزات جديدة
- إضافة ملفات جديدة في مجلدات `patients`, `appointments`, `diagnostics`
- تحديث قاعدة البيانات في `database_setup.sql`
- إضافة وظائف جديدة في `dashboard/secretaire_dashboard.py` أو `dashboard/doctor_dashboard.py`

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
