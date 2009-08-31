From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] ide: convert to ->proc_fops
Date: Tue, 1 Sep 2009 02:27:13 +0400
Message-ID: <20090831222713.GA9834@x200.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:39191 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbZHaW1Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Aug 2009 18:27:16 -0400
Received: by ewy2 with SMTP id 2so737969ewy.17
        for <linux-ide@vger.kernel.org>; Mon, 31 Aug 2009 15:27:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org

->read_proc, ->write_proc are going away, ->proc_fops should be used instead.

The only tricky place is IDENTIFY handling: if for some reason
taskfile_lib_get_identify() fails, buffer _is_ changed and at least
first byte is overwritten. Emulate old behaviour with returning
that first byte to userspace and reporting length=1 despite overall -E.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/ide/ide-cd.c          |   28 ++-
 drivers/ide/ide-disk_proc.c   |  129 ++++++++++------
 drivers/ide/ide-floppy_proc.c |   30 ++-
 drivers/ide/ide-proc.c        |  330 +++++++++++++++++++++++++++---------------
 drivers/ide/ide-tape.c        |   31 ++-
 include/linux/ide.h           |   24 ---
 6 files changed, 365 insertions(+), 207 deletions(-)

--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -30,6 +30,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/errno.h>
@@ -1389,19 +1390,30 @@ static sector_t ide_cdrom_capacity(ide_drive_t *drive)
 	return capacity * sectors_per_frame;
 }
 
-static int proc_idecd_read_capacity(char *page, char **start, off_t off,
-					int count, int *eof, void *data)
+static int idecd_capacity_proc_show(struct seq_file *m, void *v)
 {
-	ide_drive_t *drive = data;
-	int len;
+	ide_drive_t *drive = m->private;
 
-	len = sprintf(page, "%llu\n", (long long)ide_cdrom_capacity(drive));
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+	seq_printf(m, "%llu\n", (long long)ide_cdrom_capacity(drive));
+	return 0;
+}
+
+static int idecd_capacity_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, idecd_capacity_proc_show, PDE(inode)->data);
 }
 
+static const struct file_operations idecd_capacity_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= idecd_capacity_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static ide_proc_entry_t idecd_proc[] = {
-	{ "capacity", S_IFREG|S_IRUGO, proc_idecd_read_capacity, NULL },
-	{ NULL, 0, NULL, NULL }
+	{ "capacity", S_IFREG|S_IRUGO, &idecd_capacity_proc_fops },
+	{}
 };
 
 static ide_proc_entry_t *ide_cd_proc_entries(ide_drive_t *drive)
--- a/drivers/ide/ide-disk_proc.c
+++ b/drivers/ide/ide-disk_proc.c
@@ -1,5 +1,6 @@
 #include <linux/kernel.h>
 #include <linux/ide.h>
+#include <linux/seq_file.h>
 
 #include "ide-disk.h"
 
@@ -37,77 +38,117 @@ static int get_smart_data(ide_drive_t *drive, u8 *buf, u8 sub_cmd)
 	return ide_raw_taskfile(drive, &cmd, buf, 1);
 }
 
-static int proc_idedisk_read_cache
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static int idedisk_cache_proc_show(struct seq_file *m, void *v)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
-	char		*out = page;
-	int		len;
+	ide_drive_t	*drive = (ide_drive_t *) m->private;
 
 	if (drive->dev_flags & IDE_DFLAG_ID_READ)
-		len = sprintf(out, "%i\n", drive->id[ATA_ID_BUF_SIZE] / 2);
+		seq_printf(m, "%i\n", drive->id[ATA_ID_BUF_SIZE] / 2);
 	else
-		len = sprintf(out, "(none)\n");
+		seq_printf(m, "(none)\n");
+	return 0;
+}
 
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+static int idedisk_cache_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, idedisk_cache_proc_show, PDE(inode)->data);
 }
 
-static int proc_idedisk_read_capacity
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static const struct file_operations idedisk_cache_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= idedisk_cache_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int idedisk_capacity_proc_show(struct seq_file *m, void *v)
 {
-	ide_drive_t*drive = (ide_drive_t *)data;
-	int len;
+	ide_drive_t*drive = (ide_drive_t *)m->private;
 
-	len = sprintf(page, "%llu\n", (long long)ide_gd_capacity(drive));
+	seq_printf(m, "%llu\n", (long long)ide_gd_capacity(drive));
+	return 0;
+}
 
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+static int idedisk_capacity_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, idedisk_capacity_proc_show, PDE(inode)->data);
 }
 
-static int proc_idedisk_read_smart(char *page, char **start, off_t off,
-				   int count, int *eof, void *data, u8 sub_cmd)
+static const struct file_operations idedisk_capacity_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= idedisk_capacity_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __idedisk_proc_show(struct seq_file *m, ide_drive_t *drive, u8 sub_cmd)
 {
-	ide_drive_t	*drive = (ide_drive_t *)data;
-	int		len = 0, i = 0;
+	u8 *buf;
+
+	buf = kmalloc(SECTOR_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
 	(void)smart_enable(drive);
 
-	if (get_smart_data(drive, page, sub_cmd) == 0) {
-		unsigned short *val = (unsigned short *) page;
-		char *out = (char *)val + SECTOR_SIZE;
-
-		page = out;
-		do {
-			out += sprintf(out, "%04x%c", le16_to_cpu(*val),
-				       (++i & 7) ? ' ' : '\n');
-			val += 1;
-		} while (i < SECTOR_SIZE / 2);
-		len = out - page;
+	if (get_smart_data(drive, buf, sub_cmd) == 0) {
+		__le16 *val = (__le16 *)buf;
+		int i;
+
+		for (i = 0; i < SECTOR_SIZE / 2; i++) {
+			seq_printf(m, "%04x%c", le16_to_cpu(val[i]),
+					(i % 8) == 7 ? '\n' : ' ');
+		}
 	}
+	kfree(buf);
+	return 0;
+}
 
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+static int idedisk_sv_proc_show(struct seq_file *m, void *v)
+{
+	return __idedisk_proc_show(m, m->private, ATA_SMART_READ_VALUES);
 }
 
-static int proc_idedisk_read_sv
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static int idedisk_sv_proc_open(struct inode *inode, struct file *file)
 {
-	return proc_idedisk_read_smart(page, start, off, count, eof, data,
-				       ATA_SMART_READ_VALUES);
+	return single_open(file, idedisk_sv_proc_show, PDE(inode)->data);
 }
 
-static int proc_idedisk_read_st
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static const struct file_operations idedisk_sv_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= idedisk_sv_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int idedisk_st_proc_show(struct seq_file *m, void *v)
 {
-	return proc_idedisk_read_smart(page, start, off, count, eof, data,
-				       ATA_SMART_READ_THRESHOLDS);
+	return __idedisk_proc_show(m, m->private, ATA_SMART_READ_THRESHOLDS);
 }
 
+static int idedisk_st_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, idedisk_st_proc_show, PDE(inode)->data);
+}
+
+static const struct file_operations idedisk_st_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= idedisk_st_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 ide_proc_entry_t ide_disk_proc[] = {
-	{ "cache",	  S_IFREG|S_IRUGO, proc_idedisk_read_cache,    NULL },
-	{ "capacity",	  S_IFREG|S_IRUGO, proc_idedisk_read_capacity, NULL },
-	{ "geometry",	  S_IFREG|S_IRUGO, proc_ide_read_geometry,     NULL },
-	{ "smart_values", S_IFREG|S_IRUSR, proc_idedisk_read_sv,       NULL },
-	{ "smart_thresholds", S_IFREG|S_IRUSR, proc_idedisk_read_st,   NULL },
-	{ NULL, 0, NULL, NULL }
+	{ "cache",	  S_IFREG|S_IRUGO, &idedisk_cache_proc_fops	},
+	{ "capacity",	  S_IFREG|S_IRUGO, &idedisk_capacity_proc_fops	},
+	{ "geometry",	  S_IFREG|S_IRUGO, &ide_geometry_proc_fops	},
+	{ "smart_values", S_IFREG|S_IRUSR, &idedisk_sv_proc_fops	},
+	{ "smart_thresholds", S_IFREG|S_IRUSR, &idedisk_st_proc_fops	},
+	{}
 };
 
 ide_devset_rw_field(bios_cyl, bios_cyl);
--- a/drivers/ide/ide-floppy_proc.c
+++ b/drivers/ide/ide-floppy_proc.c
@@ -1,22 +1,34 @@
 #include <linux/kernel.h>
 #include <linux/ide.h>
+#include <linux/seq_file.h>
 
 #include "ide-floppy.h"
 
-static int proc_idefloppy_read_capacity(char *page, char **start, off_t off,
-		int count, int *eof, void *data)
+static int idefloppy_capacity_proc_show(struct seq_file *m, void *v)
 {
-	ide_drive_t*drive = (ide_drive_t *)data;
-	int len;
+	ide_drive_t*drive = (ide_drive_t *)m->private;
 
-	len = sprintf(page, "%llu\n", (long long)ide_gd_capacity(drive));
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+	seq_printf(m, "%llu\n", (long long)ide_gd_capacity(drive));
+	return 0;
 }
 
+static int idefloppy_capacity_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, idefloppy_capacity_proc_show, PDE(inode)->data);
+}
+
+static const struct file_operations idefloppy_capacity_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= idefloppy_capacity_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 ide_proc_entry_t ide_floppy_proc[] = {
-	{ "capacity",	S_IFREG|S_IRUGO, proc_idefloppy_read_capacity,	NULL },
-	{ "geometry",	S_IFREG|S_IRUGO, proc_ide_read_geometry,	NULL },
-	{ NULL, 0, NULL, NULL }
+	{ "capacity",	S_IFREG|S_IRUGO, &idefloppy_capacity_proc_fops	},
+	{ "geometry",	S_IFREG|S_IRUGO, &ide_geometry_proc_fops	},
+	{}
 };
 
 ide_devset_rw_field(bios_cyl, bios_cyl);
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -30,11 +30,9 @@
 
 static struct proc_dir_entry *proc_ide_root;
 
-static int proc_ide_read_imodel
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static int ide_imodel_proc_show(struct seq_file *m, void *v)
 {
-	ide_hwif_t	*hwif = (ide_hwif_t *) data;
-	int		len;
+	ide_hwif_t	*hwif = (ide_hwif_t *) m->private;
 	const char	*name;
 
 	switch (hwif->chipset) {
@@ -53,63 +51,108 @@ static int proc_ide_read_imodel
 	case ide_acorn:		name = "acorn";		break;
 	default:		name = "(unknown)";	break;
 	}
-	len = sprintf(page, "%s\n", name);
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+	seq_printf(m, "%s\n", name);
+	return 0;
 }
 
-static int proc_ide_read_mate
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static int ide_imodel_proc_open(struct inode *inode, struct file *file)
 {
-	ide_hwif_t	*hwif = (ide_hwif_t *) data;
-	int		len;
+	return single_open(file, ide_imodel_proc_show, PDE(inode)->data);
+}
+
+static const struct file_operations ide_imodel_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ide_imodel_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int ide_mate_proc_show(struct seq_file *m, void *v)
+{
+	ide_hwif_t	*hwif = (ide_hwif_t *) m->private;
 
 	if (hwif && hwif->mate)
-		len = sprintf(page, "%s\n", hwif->mate->name);
+		seq_printf(m, "%s\n", hwif->mate->name);
 	else
-		len = sprintf(page, "(none)\n");
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+		seq_printf(m, "(none)\n");
+	return 0;
+}
+
+static int ide_mate_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ide_mate_proc_show, PDE(inode)->data);
 }
 
-static int proc_ide_read_channel
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static const struct file_operations ide_mate_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ide_mate_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int ide_channel_proc_show(struct seq_file *m, void *v)
 {
-	ide_hwif_t	*hwif = (ide_hwif_t *) data;
-	int		len;
+	ide_hwif_t	*hwif = (ide_hwif_t *) m->private;
 
-	page[0] = hwif->channel ? '1' : '0';
-	page[1] = '\n';
-	len = 2;
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+	seq_printf(m, "%c\n", hwif->channel ? '1' : '0');
+	return 0;
 }
 
-static int proc_ide_read_identify
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static int ide_channel_proc_open(struct inode *inode, struct file *file)
 {
-	ide_drive_t	*drive = (ide_drive_t *)data;
-	int		len = 0, i = 0;
-	int		err = 0;
+	return single_open(file, ide_channel_proc_show, PDE(inode)->data);
+}
 
-	len = sprintf(page, "\n");
+static const struct file_operations ide_channel_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ide_channel_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 
-	if (drive) {
-		__le16 *val = (__le16 *)page;
+static int ide_identify_proc_show(struct seq_file *m, void *v)
+{
+	ide_drive_t *drive = (ide_drive_t *)m->private;
+	u8 *buf;
 
-		err = taskfile_lib_get_identify(drive, page);
-		if (!err) {
-			char *out = (char *)page + SECTOR_SIZE;
+	if (!drive) {
+		seq_putc(m, '\n');
+		return 0;
+	}
 
-			page = out;
-			do {
-				out += sprintf(out, "%04x%c",
-					le16_to_cpup(val), (++i & 7) ? ' ' : '\n');
-				val += 1;
-			} while (i < SECTOR_SIZE / 2);
-			len = out - page;
+	buf = kmalloc(SECTOR_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	if (taskfile_lib_get_identify(drive, buf) == 0) {
+		__le16 *val = (__le16 *)buf;
+		int i;
+
+		for (i = 0; i < SECTOR_SIZE / 2; i++) {
+			seq_printf(m, "%04x%c", le16_to_cpu(val[i]),
+					(i % 8) == 7 ? '\n' : ' ');
 		}
-	}
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+	} else
+		seq_putc(m, buf[0]);
+	kfree(buf);
+	return 0;
+}
+
+static int ide_identify_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ide_identify_proc_show, PDE(inode)->data);
 }
 
+static const struct file_operations ide_identify_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ide_identify_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 /**
  *	ide_find_setting	-	find a specific setting
  *	@st: setting table pointer
@@ -246,22 +289,20 @@ static void proc_ide_settings_warn(void)
 	warned = 1;
 }
 
-static int proc_ide_read_settings
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static int ide_settings_proc_show(struct seq_file *m, void *v)
 {
 	const struct ide_proc_devset *setting, *g, *d;
 	const struct ide_devset *ds;
-	ide_drive_t	*drive = (ide_drive_t *) data;
-	char		*out = page;
-	int		len, rc, mul_factor, div_factor;
+	ide_drive_t	*drive = (ide_drive_t *) m->private;
+	int		rc, mul_factor, div_factor;
 
 	proc_ide_settings_warn();
 
 	mutex_lock(&ide_setting_mtx);
 	g = ide_generic_settings;
 	d = drive->settings;
-	out += sprintf(out, "name\t\t\tvalue\t\tmin\t\tmax\t\tmode\n");
-	out += sprintf(out, "----\t\t\t-----\t\t---\t\t---\t\t----\n");
+	seq_printf(m, "name\t\t\tvalue\t\tmin\t\tmax\t\tmode\n");
+	seq_printf(m, "----\t\t\t-----\t\t---\t\t---\t\t----\n");
 	while (g->name || (d && d->name)) {
 		/* read settings in the alphabetical order */
 		if (g->name && d && d->name) {
@@ -275,31 +316,35 @@ static int proc_ide_read_settings
 			setting = g++;
 		mul_factor = setting->mulf ? setting->mulf(drive) : 1;
 		div_factor = setting->divf ? setting->divf(drive) : 1;
-		out += sprintf(out, "%-24s", setting->name);
+		seq_printf(m, "%-24s", setting->name);
 		rc = ide_read_setting(drive, setting);
 		if (rc >= 0)
-			out += sprintf(out, "%-16d", rc * mul_factor / div_factor);
+			seq_printf(m, "%-16d", rc * mul_factor / div_factor);
 		else
-			out += sprintf(out, "%-16s", "write-only");
-		out += sprintf(out, "%-16d%-16d", (setting->min * mul_factor + div_factor - 1) / div_factor, setting->max * mul_factor / div_factor);
+			seq_printf(m, "%-16s", "write-only");
+		seq_printf(m, "%-16d%-16d", (setting->min * mul_factor + div_factor - 1) / div_factor, setting->max * mul_factor / div_factor);
 		ds = setting->setting;
 		if (ds->get)
-			out += sprintf(out, "r");
+			seq_printf(m, "r");
 		if (ds->set)
-			out += sprintf(out, "w");
-		out += sprintf(out, "\n");
+			seq_printf(m, "w");
+		seq_printf(m, "\n");
 	}
-	len = out - page;
 	mutex_unlock(&ide_setting_mtx);
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+	return 0;
+}
+
+static int ide_settings_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ide_settings_proc_show, PDE(inode)->data);
 }
 
 #define MAX_LEN	30
 
-static int proc_ide_write_settings(struct file *file, const char __user *buffer,
-				   unsigned long count, void *data)
+static ssize_t ide_settings_proc_write(struct file *file, const char __user *buffer,
+				       size_t count, loff_t *pos)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = (ide_drive_t *) PDE(file->f_path.dentry->d_inode)->data;
 	char		name[MAX_LEN + 1];
 	int		for_real = 0, mul_factor, div_factor;
 	unsigned long	n;
@@ -394,63 +439,104 @@ static int proc_ide_write_settings(struct file *file, const char __user *buffer,
 	return count;
 parse_error:
 	free_page((unsigned long)buf);
-	printk("proc_ide_write_settings(): parse error\n");
+	printk("%s(): parse error\n", __func__);
 	return -EINVAL;
 }
 
-int proc_ide_read_capacity
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static const struct file_operations ide_settings_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ide_settings_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= ide_settings_proc_write,
+};
+
+static int ide_capacity_proc_show(struct seq_file *m, void *v)
 {
-	int len = sprintf(page, "%llu\n", (long long)0x7fffffff);
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+	seq_printf(m, "%llu\n", (long long)0x7fffffff);
+	return 0;
 }
 
-EXPORT_SYMBOL_GPL(proc_ide_read_capacity);
+static int ide_capacity_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ide_capacity_proc_show, NULL);
+}
 
-int proc_ide_read_geometry
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+const struct file_operations ide_capacity_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ide_capacity_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+EXPORT_SYMBOL_GPL(ide_capacity_proc_fops);
+
+static int ide_geometry_proc_show(struct seq_file *m, void *v)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
-	char		*out = page;
-	int		len;
+	ide_drive_t	*drive = (ide_drive_t *) m->private;
 
-	out += sprintf(out, "physical     %d/%d/%d\n",
+	seq_printf(m, "physical     %d/%d/%d\n",
 			drive->cyl, drive->head, drive->sect);
-	out += sprintf(out, "logical      %d/%d/%d\n",
+	seq_printf(m, "logical      %d/%d/%d\n",
 			drive->bios_cyl, drive->bios_head, drive->bios_sect);
+	return 0;
+}
 
-	len = out - page;
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+static int ide_geometry_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ide_geometry_proc_show, PDE(inode)->data);
 }
 
-EXPORT_SYMBOL(proc_ide_read_geometry);
+const struct file_operations ide_geometry_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ide_geometry_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+EXPORT_SYMBOL(ide_geometry_proc_fops);
 
-static int proc_ide_read_dmodel
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static int ide_dmodel_proc_show(struct seq_file *seq, void *v)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = (ide_drive_t *) seq->private;
 	char		*m = (char *)&drive->id[ATA_ID_PROD];
-	int		len;
 
-	len = sprintf(page, "%.40s\n", m[0] ? m : "(none)");
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+	seq_printf(seq, "%.40s\n", m[0] ? m : "(none)");
+	return 0;
+}
+
+static int ide_dmodel_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ide_dmodel_proc_show, PDE(inode)->data);
 }
 
-static int proc_ide_read_driver
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static const struct file_operations ide_dmodel_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ide_dmodel_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int ide_driver_proc_show(struct seq_file *m, void *v)
 {
-	ide_drive_t		*drive = (ide_drive_t *)data;
+	ide_drive_t		*drive = (ide_drive_t *)m->private;
 	struct device		*dev = &drive->gendev;
 	struct ide_driver	*ide_drv;
-	int			len;
 
 	if (dev->driver) {
 		ide_drv = to_ide_driver(dev->driver);
-		len = sprintf(page, "%s version %s\n",
+		seq_printf(m, "%s version %s\n",
 				dev->driver->name, ide_drv->version);
 	} else
-		len = sprintf(page, "ide-default version 0.9.newide\n");
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+		seq_printf(m, "ide-default version 0.9.newide\n");
+	return 0;
+}
+
+static int ide_driver_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ide_driver_proc_show, PDE(inode)->data);
 }
 
 static int ide_replace_subdriver(ide_drive_t *drive, const char *driver)
@@ -480,10 +566,10 @@ static int ide_replace_subdriver(ide_drive_t *drive, const char *driver)
 	return ret;
 }
 
-static int proc_ide_write_driver
-	(struct file *file, const char __user *buffer, unsigned long count, void *data)
+static ssize_t ide_driver_proc_write(struct file *file, const char __user *buffer,
+				     size_t count, loff_t *pos)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = (ide_drive_t *) PDE(file->f_path.dentry->d_inode)->data;
 	char name[32];
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -498,12 +584,19 @@ static int proc_ide_write_driver
 	return count;
 }
 
-static int proc_ide_read_media
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static const struct file_operations ide_driver_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ide_driver_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= ide_driver_proc_write,
+};
+
+static int ide_media_proc_show(struct seq_file *m, void *v)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = (ide_drive_t *) m->private;
 	const char	*media;
-	int		len;
 
 	switch (drive->media) {
 	case ide_disk:		media = "disk\n";	break;
@@ -513,20 +606,30 @@ static int proc_ide_read_media
 	case ide_optical:	media = "optical\n";	break;
 	default:		media = "UNKNOWN\n";	break;
 	}
-	strcpy(page, media);
-	len = strlen(media);
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+	seq_puts(m, media);
+	return 0;
+}
+
+static int ide_media_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ide_media_proc_show, PDE(inode)->data);
 }
 
+static const struct file_operations ide_media_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ide_media_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static ide_proc_entry_t generic_drive_entries[] = {
-	{ "driver",	S_IFREG|S_IRUGO,	 proc_ide_read_driver,
-						 proc_ide_write_driver },
-	{ "identify",	S_IFREG|S_IRUSR,	 proc_ide_read_identify, NULL },
-	{ "media",	S_IFREG|S_IRUGO,	 proc_ide_read_media,    NULL },
-	{ "model",	S_IFREG|S_IRUGO,	 proc_ide_read_dmodel,   NULL },
-	{ "settings",	S_IFREG|S_IRUSR|S_IWUSR, proc_ide_read_settings,
-						 proc_ide_write_settings },
-	{ NULL,	0, NULL, NULL }
+	{ "driver",	S_IFREG|S_IRUGO,	 &ide_driver_proc_fops	},
+	{ "identify",	S_IFREG|S_IRUSR,	 &ide_identify_proc_fops},
+	{ "media",	S_IFREG|S_IRUGO,	 &ide_media_proc_fops	},
+	{ "model",	S_IFREG|S_IRUGO,	 &ide_dmodel_proc_fops	},
+	{ "settings",	S_IFREG|S_IRUSR|S_IWUSR, &ide_settings_proc_fops},
+	{}
 };
 
 static void ide_add_proc_entries(struct proc_dir_entry *dir, ide_proc_entry_t *p, void *data)
@@ -536,11 +639,8 @@ static void ide_add_proc_entries(struct proc_dir_entry *dir, ide_proc_entry_t *p
 	if (!dir || !p)
 		return;
 	while (p->name != NULL) {
-		ent = create_proc_entry(p->name, p->mode, dir);
+		ent = proc_create_data(p->name, p->mode, dir, p->proc_fops, data);
 		if (!ent) return;
-		ent->data = data;
-		ent->read_proc = p->read_proc;
-		ent->write_proc = p->write_proc;
 		p++;
 	}
 }
@@ -623,10 +723,10 @@ void ide_proc_unregister_device(ide_drive_t *drive)
 }
 
 static ide_proc_entry_t hwif_entries[] = {
-	{ "channel",	S_IFREG|S_IRUGO,	proc_ide_read_channel,	NULL },
-	{ "mate",	S_IFREG|S_IRUGO,	proc_ide_read_mate,	NULL },
-	{ "model",	S_IFREG|S_IRUGO,	proc_ide_read_imodel,	NULL },
-	{ NULL,	0, NULL, NULL }
+	{ "channel",	S_IFREG|S_IRUGO,	&ide_channel_proc_fops	},
+	{ "mate",	S_IFREG|S_IRUGO,	&ide_mate_proc_fops	},
+	{ "model",	S_IFREG|S_IRUGO,	&ide_imodel_proc_fops	},
+	{}
 };
 
 void ide_proc_register_port(ide_hwif_t *hwif)
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -31,6 +31,7 @@
 #include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/genhd.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/ide.h>
@@ -1833,22 +1834,32 @@ static void ide_tape_release(struct device *dev)
 }
 
 #ifdef CONFIG_IDE_PROC_FS
-static int proc_idetape_read_name
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static int idetape_name_proc_show(struct seq_file *m, void *v)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = (ide_drive_t *) m->private;
 	idetape_tape_t	*tape = drive->driver_data;
-	char		*out = page;
-	int		len;
 
-	len = sprintf(out, "%s\n", tape->name);
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+	seq_printf(m, "%s\n", tape->name);
+	return 0;
+}
+
+static int idetape_name_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, idetape_name_proc_show, PDE(inode)->data);
 }
 
+static const struct file_operations idetape_name_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= idetape_name_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static ide_proc_entry_t idetape_proc[] = {
-	{ "capacity",	S_IFREG|S_IRUGO,	proc_ide_read_capacity, NULL },
-	{ "name",	S_IFREG|S_IRUGO,	proc_idetape_read_name,	NULL },
-	{ NULL, 0, NULL, NULL }
+	{ "capacity",	S_IFREG|S_IRUGO,	&ide_capacity_proc_fops	},
+	{ "name",	S_IFREG|S_IRUGO,	&idetape_name_proc_fops	},
+	{}
 };
 
 static ide_proc_entry_t *ide_tape_proc_entries(ide_drive_t *drive)
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -918,8 +918,7 @@ __IDE_PROC_DEVSET(_name, _min, _max, NULL, NULL)
 typedef struct {
 	const char	*name;
 	mode_t		mode;
-	read_proc_t	*read_proc;
-	write_proc_t	*write_proc;
+	const struct file_operations *proc_fops;
 } ide_proc_entry_t;
 
 void proc_ide_create(void);
@@ -931,24 +930,8 @@ void ide_proc_unregister_port(ide_hwif_t *);
 void ide_proc_register_driver(ide_drive_t *, struct ide_driver *);
 void ide_proc_unregister_driver(ide_drive_t *, struct ide_driver *);
 
-read_proc_t proc_ide_read_capacity;
-read_proc_t proc_ide_read_geometry;
-
-/*
- * Standard exit stuff:
- */
-#define PROC_IDE_READ_RETURN(page,start,off,count,eof,len) \
-{					\
-	len -= off;			\
-	if (len < count) {		\
-		*eof = 1;		\
-		if (len <= 0)		\
-			return 0;	\
-	} else				\
-		len = count;		\
-	*start = page + off;		\
-	return len;			\
-}
+extern const struct file_operations ide_capacity_proc_fops;
+extern const struct file_operations ide_geometry_proc_fops;
 #else
 static inline void proc_ide_create(void) { ; }
 static inline void proc_ide_destroy(void) { ; }
@@ -960,7 +943,6 @@ static inline void ide_proc_register_driver(ide_drive_t *drive,
 					    struct ide_driver *driver) { ; }
 static inline void ide_proc_unregister_driver(ide_drive_t *drive,
 					      struct ide_driver *driver) { ; }
-#define PROC_IDE_READ_RETURN(page,start,off,count,eof,len) return 0;
 #endif
 
 enum {
