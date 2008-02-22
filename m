From: Mark Lord <liml@rtr.ca>
Subject: new ata_port_operations for .pmp_{read,write} ?
Date: Thu, 21 Feb 2008 23:22:22 -0500
Message-ID: <47BE4DFE.2030407@rtr.ca>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1142 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387AbYBVEWY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Feb 2008 23:22:24 -0500
In-Reply-To: <47BE4701.2030104@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Tejun,

Here's a first cut at this for discussion.

You may prefer different names for the invoking functions
inside libata-pmp.c, rather than simply pmp_read() and pmp_write(),
but I've been up too long and couldn't think of a better name.

An alternative to all this, might be to expose the "select_pmp()"
function shown in the sample code, and have libata-pmp.c call that,
instead of having the new new .pmp_{read,write} functions.

What do you think?

* * *

SATA host controllers which are not purely FIS-based require setup
of a special register to select the active pmp for taskfile accesses.

This can be done in the low-level driver for regular command issue
on a link.  But commands directed at a port-multiplier cause problems,
because they leave the original link pmp de-selected afterwards.

To fix this in a sane fashion, without tons of code duplication
from libata into the low-level driver, it is necessary to be able
to wrap the sata_pmp_read() and sata_pmp_write() functions.

This patch provides two new struct ata_port_operations methods for this,
and modifies the code in libata-pmp to use them if provided.

In practice, the low-level driver might implement them like this:

	static int pmp_read(struct ata_link *link, unsigned int reg, u32 *val)
	{
	        int old = select_pmp(link->ap, SATA_PMP_CTRL_PORT);
	        int rc  = sata_pmp_read(link, reg, val);
	        select_pmp(link->ap, old);
	        return rc;
	}
	
	static int pmp_write(struct ata_link *link, unsigned int reg, u32 val)
	{
	        int old = select_pmp(link->ap, link->pmp);
	        int rc  = sata_pmp_write(link, reg, val);
	        select_pmp(link->ap, old);
	        return rc;
	}

Note that "select_pmp" is local to the low-level driver,
and is where the chipset pmp-selection register is read/written
(the return value is the previous pmp, before writing the new one).

Something like this patch is needed for PMP support in sata_mv,
and possibly other drivers.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

 drivers/ata/libata-core.c |    2 ++
 drivers/ata/libata-pmp.c  |   36 ++++++++++++++++++++++++++----------
 include/linux/libata.h    |    5 +++++
 3 files changed, 33 insertions(+), 10 deletions(-)

diff -u --recursive --new-file --exclude-from=old/Documentation/dontdiff --exclude='*.lds' --exclude-from=old/.gitignore old/drivers/ata/libata-core.c new/drivers/ata/libata-core.c
--- old/drivers/ata/libata-core.c	2008-02-21 22:45:38.000000000 -0500
+++ new/drivers/ata/libata-core.c	2008-02-21 22:59:13.000000000 -0500
@@ -7856,6 +7856,8 @@
 EXPORT_SYMBOL_GPL(sata_pmp_std_hardreset);
 EXPORT_SYMBOL_GPL(sata_pmp_std_postreset);
 EXPORT_SYMBOL_GPL(sata_pmp_do_eh);
+EXPORT_SYMBOL_GPL(sata_pmp_read);
+EXPORT_SYMBOL_GPL(sata_pmp_write);
 
 EXPORT_SYMBOL_GPL(__ata_ehi_push_desc);
 EXPORT_SYMBOL_GPL(ata_ehi_push_desc);
diff -u --recursive --new-file --exclude-from=old/Documentation/dontdiff --exclude='*.lds' --exclude-from=old/.gitignore old/drivers/ata/libata-pmp.c new/drivers/ata/libata-pmp.c
--- old/drivers/ata/libata-pmp.c	2008-02-21 22:47:32.000000000 -0500
+++ new/drivers/ata/libata-pmp.c	2008-02-21 22:57:43.000000000 -0500
@@ -25,7 +25,7 @@
  *	RETURNS:
  *	0 on success, AC_ERR_* mask on failure.
  */
-static unsigned int sata_pmp_read(struct ata_link *link, int reg, u32 *r_val)
+unsigned int sata_pmp_read(struct ata_link *link, int reg, u32 *r_val)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_device *pmp_dev = ap->link.device;
@@ -48,6 +48,14 @@
 	return 0;
 }
 
+static unsigned int pmp_read(struct ata_link *link, int reg, u32 *r_val)
+{
+	if (link->ap->ops->pmp_read)
+		return link->ap->ops->pmp_read(link,reg,r_val);
+	else
+		return sata_pmp_read(link, reg, r_val);
+}
+
 /**
  *	sata_pmp_write - write PMP register
  *	@link: link to write PMP register for
@@ -62,7 +70,7 @@
  *	RETURNS:
  *	0 on success, AC_ERR_* mask on failure.
  */
-static unsigned int sata_pmp_write(struct ata_link *link, int reg, u32 val)
+unsigned int sata_pmp_write(struct ata_link *link, int reg, u32 val)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_device *pmp_dev = ap->link.device;
@@ -83,6 +91,14 @@
 				 SATA_PMP_SCR_TIMEOUT);
 }
 
+static unsigned int pmp_write(struct ata_link *link, int reg, u32 val)
+{
+	if (link->ap->ops->pmp_write)
+		return link->ap->ops->pmp_write(link,reg,val);
+	else
+		return sata_pmp_write(link, reg, val);
+}
+
 /**
  *	sata_pmp_qc_defer_cmd_switch - qc_defer for command switching PMP
  *	@qc: ATA command in question
@@ -135,7 +151,7 @@
 	if (reg > SATA_PMP_PSCR_CONTROL)
 		return -EINVAL;
 
-	err_mask = sata_pmp_read(link, reg, r_val);
+	err_mask = pmp_read(link, reg, r_val);
 	if (err_mask) {
 		ata_link_printk(link, KERN_WARNING, "failed to read SCR %d "
 				"(Emask=0x%x)\n", reg, err_mask);
@@ -166,7 +182,7 @@
 	if (reg > SATA_PMP_PSCR_CONTROL)
 		return -EINVAL;
 
-	err_mask = sata_pmp_write(link, reg, val);
+	err_mask = pmp_write(link, reg, val);
 	if (err_mask) {
 		ata_link_printk(link, KERN_WARNING, "failed to write SCR %d "
 				"(Emask=0x%x)\n", reg, err_mask);
@@ -332,7 +348,7 @@
 		int reg = gscr_to_read[i];
 		unsigned int err_mask;
 
-		err_mask = sata_pmp_read(dev->link, reg, &gscr[reg]);
+		err_mask = pmp_read(dev->link, reg, &gscr[reg]);
 		if (err_mask) {
 			ata_dev_printk(dev, KERN_ERR, "failed to read PMP "
 				"GSCR[%d] (Emask=0x%x)\n", reg, err_mask);
@@ -375,7 +391,7 @@
 		dev->flags |= ATA_DFLAG_AN;
 
 	/* monitor SERR_PHYRDY_CHG on fan-out ports */
-	err_mask = sata_pmp_write(dev->link, SATA_PMP_GSCR_ERROR_EN,
+	err_mask = pmp_write(dev->link, SATA_PMP_GSCR_ERROR_EN,
 				  SERR_PHYRDY_CHG);
 	if (err_mask) {
 		rc = -EIO;
@@ -387,7 +403,7 @@
 	if (gscr[SATA_PMP_GSCR_FEAT_EN] & SATA_PMP_FEAT_NOTIFY) {
 		gscr[SATA_PMP_GSCR_FEAT_EN] &= ~SATA_PMP_FEAT_NOTIFY;
 
-		err_mask = sata_pmp_write(dev->link, SATA_PMP_GSCR_FEAT_EN,
+		err_mask = pmp_write(dev->link, SATA_PMP_GSCR_FEAT_EN,
 					  gscr[SATA_PMP_GSCR_FEAT_EN]);
 		if (err_mask) {
 			rc = -EIO;
@@ -792,7 +808,7 @@
 	unsigned int err_mask;
 	u32 prod_id;
 
-	err_mask = sata_pmp_read(dev->link, SATA_PMP_GSCR_PROD_ID, &prod_id);
+	err_mask = pmp_read(dev->link, SATA_PMP_GSCR_PROD_ID, &prod_id);
 	if (err_mask) {
 		ata_dev_printk(dev, KERN_ERR, "failed to read PMP product ID "
 			       "(Emask=0x%x)\n", err_mask);
@@ -1086,7 +1102,7 @@
 	if (pmp_dev->flags & ATA_DFLAG_AN) {
 		pmp_dev->gscr[SATA_PMP_GSCR_FEAT_EN] |= SATA_PMP_FEAT_NOTIFY;
 
-		err_mask = sata_pmp_write(pmp_dev->link, SATA_PMP_GSCR_FEAT_EN,
+		err_mask = pmp_write(pmp_dev->link, SATA_PMP_GSCR_FEAT_EN,
 					  pmp_dev->gscr[SATA_PMP_GSCR_FEAT_EN]);
 		if (err_mask) {
 			ata_dev_printk(pmp_dev, KERN_ERR, "failed to write "
@@ -1097,7 +1113,7 @@
 	}
 
 	/* check GSCR_ERROR */
-	err_mask = sata_pmp_read(pmp_link, SATA_PMP_GSCR_ERROR, &gscr_error);
+	err_mask = pmp_read(pmp_link, SATA_PMP_GSCR_ERROR, &gscr_error);
 	if (err_mask) {
 		ata_dev_printk(pmp_dev, KERN_ERR, "failed to read "
 			       "PMP_GSCR_ERROR (Emask=0x%x)\n", err_mask);
diff -u --recursive --new-file --exclude-from=old/Documentation/dontdiff --exclude='*.lds' --exclude-from=old/.gitignore old/include/linux/libata.h new/include/linux/libata.h
--- old/include/linux/libata.h	2008-02-21 22:45:39.000000000 -0500
+++ new/include/linux/libata.h	2008-02-21 23:01:14.000000000 -0500
@@ -717,6 +717,9 @@
 	int (*scr_read) (struct ata_port *ap, unsigned int sc_reg, u32 *val);
 	int (*scr_write) (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
+	int (*pmp_read) (struct ata_link *link, unsigned int sc_reg, u32 *val);
+	int (*pmp_write) (struct ata_link *link, unsigned int sc_reg, u32 val);
+
 	int (*port_suspend) (struct ata_port *ap, pm_message_t mesg);
 	int (*port_resume) (struct ata_port *ap);
 	int (*enable_pm) (struct ata_port *ap, enum link_pm policy);
@@ -1043,6 +1046,8 @@
 		ata_reset_fn_t hardreset, ata_postreset_fn_t postreset,
 		ata_prereset_fn_t pmp_prereset, ata_reset_fn_t pmp_softreset,
 		ata_reset_fn_t pmp_hardreset, ata_postreset_fn_t pmp_postreset);
+extern unsigned int sata_pmp_read(struct ata_link *link, int reg, u32 *val);
+extern unsigned int sata_pmp_write(struct ata_link *link, int reg, u32 val);
 
 /*
  * EH
