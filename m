From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] dmi: extend dmi_get_year() to dmi_get_date()
Date: Sun, 16 Aug 2009 21:02:36 +0900
Message-ID: <4A87F55C.3020103@gmail.com>
References: <4A87F512.3080802@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:34595 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbZHPMC4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Aug 2009 08:02:56 -0400
Received: by pxi34 with SMTP id 34so843021pxi.4
        for <linux-ide@vger.kernel.org>; Sun, 16 Aug 2009 05:02:57 -0700 (PDT)
In-Reply-To: <4A87F512.3080802@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sandor Bodo-Merle <sbodomerle@gmail.com>, "Huang, Shane" <Shane.Huang@amd.com>, Jeff Garzik <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

There are cases where full date information is required instead of
just the year.  Add month and day parsing to dmi_get_year() and rename
it to dmi_get_date().

As the original function only required '/' followed by any number of
parseable characters at the end of the string, keep that behavior to
avoid upsetting existing users.

The new function takes dates of format [mm[/dd]]/yy[yy].  Year, month
and date are checked to be in the ranges of [1-9999], [1-12] and
[1-31] respectively and any invalid or out-of-range component is
returned as zero.

The dummy implementation is updated accordingly but the return value
is updated to indicate field not found which is consistent with how
other dummy functions behave.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 arch/x86/pci/direct.c       |    5 +-
 drivers/acpi/blacklist.c    |    5 +-
 drivers/ata/ahci.c          |    2 -
 drivers/firmware/dmi_scan.c |   78 +++++++++++++++++++++++++++++++++-----------
 include/linux/dmi.h         |   13 ++++++-
 5 files changed, 77 insertions(+), 26 deletions(-)

Index: ata/drivers/firmware/dmi_scan.c
===================================================================
--- ata.orig/drivers/firmware/dmi_scan.c
+++ ata/drivers/firmware/dmi_scan.c
@@ -568,36 +568,76 @@ const struct dmi_device * dmi_find_devic
 EXPORT_SYMBOL(dmi_find_device);
 
 /**
- *	dmi_get_year - Return year of a DMI date
- *	@field:	data index (like dmi_get_system_info)
+ *	dmi_get_date - parse a DMI date
+ *	@field:	data index (see enum dmi_field)
+ *	@yearp: optional out parameter for the year
+ *	@monthp: optional out parameter for the month
+ *	@dayp: optional out parameter for the day
  *
- *	Returns -1 when the field doesn't exist. 0 when it is broken.
+ *	The date field is assumed to be in the form resembling
+ *	[mm[/dd]]/yy[yy] and the result is stored in the out
+ *	parameters any or all of which can be omitted.
+ *
+ *	If the field doesn't exist, all out parameters are set to zero
+ *	and false is returned.  Otherwise, true is returned with any
+ *	invalid part of date set to zero.
+ *
+ *	On return, year, month and day are guaranteed to be in the
+ *	range of [0,9999], [0,12] and [0,31] respectively.
  */
-int dmi_get_year(int field)
+bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp)
 {
-	int year;
-	const char *s = dmi_get_system_info(field);
+	int year = 0, month = 0, day = 0;
+	bool exists;
+	const char *s, *y;
 	char *e;
 
-	if (!s)
-		return -1;
-	if (*s == '\0')
-		return 0;
-	s = strrchr(s, '/');
-	if (!s)
-		return 0;
-
-	s += 1;
-	year = simple_strtoul(s, &e, 10);
-	if (s != e && year < 100) {	/* 2-digit year */
+	s = dmi_get_system_info(field);
+	exists = s;
+	if (!exists)
+		goto out;
+
+	/*
+	 * Determine year first.  We assume the date string resembles
+	 * mm/dd/yy[yy] but the original code extracted only the year
+	 * from the end.  Keep the behavior in the spirit of no
+	 * surprises.
+	 */
+	y = strrchr(s, '/');
+	if (!y)
+		goto out;
+
+	y++;
+	year = simple_strtoul(y, &e, 10);
+	if (y != e && year < 100) {	/* 2-digit year */
 		year += 1900;
 		if (year < 1996)	/* no dates < spec 1.0 */
 			year += 100;
 	}
+	if (year > 9999)		/* year should fit in %04d */
+		year = 0;
+
+	/* parse the mm and dd */
+	month = simple_strtoul(s, &e, 10);
+	if (s == e || *e != '/' || !month || month > 12) {
+		month = 0;
+		goto out;
+	}
 
-	return year;
+	s = e + 1;
+	day = simple_strtoul(s, &e, 10);
+	if (s == y || s == e || *e != '/' || day > 31)
+		day = 0;
+out:
+	if (yearp)
+		*yearp = year;
+	if (monthp)
+		*monthp = month;
+	if (dayp)
+		*dayp = day;
+	return exists;
 }
-EXPORT_SYMBOL(dmi_get_year);
+EXPORT_SYMBOL(dmi_get_date);
 
 /**
  *	dmi_walk - Walk the DMI table and get called back for every record
Index: ata/include/linux/dmi.h
===================================================================
--- ata.orig/include/linux/dmi.h
+++ ata/include/linux/dmi.h
@@ -43,7 +43,7 @@ extern const char * dmi_get_system_info(
 extern const struct dmi_device * dmi_find_device(int type, const char *name,
 	const struct dmi_device *from);
 extern void dmi_scan_machine(void);
-extern int dmi_get_year(int field);
+extern bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp);
 extern int dmi_name_in_vendors(const char *str);
 extern int dmi_name_in_serial(const char *str);
 extern int dmi_available;
@@ -58,7 +58,16 @@ static inline const char * dmi_get_syste
 static inline const struct dmi_device * dmi_find_device(int type, const char *name,
 	const struct dmi_device *from) { return NULL; }
 static inline void dmi_scan_machine(void) { return; }
-static inline int dmi_get_year(int year) { return 0; }
+static inline bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp)
+{
+	if (yearp)
+		*yearp = 0;
+	if (monthp)
+		*monthp = 0;
+	if (dayp)
+		*dayp = 0;
+	return false;
+}
 static inline int dmi_name_in_vendors(const char *s) { return 0; }
 static inline int dmi_name_in_serial(const char *s) { return 0; }
 #define dmi_available 0
Index: ata/arch/x86/pci/direct.c
===================================================================
--- ata.orig/arch/x86/pci/direct.c
+++ ata/arch/x86/pci/direct.c
@@ -192,13 +192,14 @@ struct pci_raw_ops pci_direct_conf2 = {
 static int __init pci_sanity_check(struct pci_raw_ops *o)
 {
 	u32 x = 0;
-	int devfn;
+	int year, devfn;
 
 	if (pci_probe & PCI_NO_CHECKS)
 		return 1;
 	/* Assume Type 1 works for newer systems.
 	   This handles machines that don't have anything on PCI Bus 0. */
-	if (dmi_get_year(DMI_BIOS_DATE) >= 2001)
+	dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
+	if (year >= 2001)
 		return 1;
 
 	for (devfn = 0; devfn < 0x100; devfn++) {
Index: ata/drivers/acpi/blacklist.c
===================================================================
--- ata.orig/drivers/acpi/blacklist.c
+++ ata/drivers/acpi/blacklist.c
@@ -78,9 +78,10 @@ static struct acpi_blacklist_item acpi_b
 
 static int __init blacklist_by_year(void)
 {
-	int year = dmi_get_year(DMI_BIOS_DATE);
+	int year;
+
 	/* Doesn't exist? Likely an old system */
-	if (year == -1) {
+	if (!dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL)) {
 		printk(KERN_ERR PREFIX "no DMI BIOS year, "
 			"acpi=force is required to enable ACPI\n" );
 		return 1;
Index: ata/drivers/ata/ahci.c
===================================================================
--- ata.orig/drivers/ata/ahci.c
+++ ata/drivers/ata/ahci.c
@@ -2635,7 +2635,7 @@ static bool ahci_asus_m2a_vm_32bit_only(
 	 * different versions.
 	 */
 	date = dmi_get_system_info(DMI_BIOS_DATE);
-	year = dmi_get_year(DMI_BIOS_DATE);
+	dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
 	if (date && strlen(date) >= 10 && date[2] == '/' && date[5] == '/' &&
 	    (year > 2007 ||
 	     (year == 2007 && strncmp(date, cutoff_mmdd, 5) >= 0)))
