From: Mark Lord <lkml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Tue, 14 Feb 2006 13:00:36 -0500
Message-ID: <200602141300.37118.lkml@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422732AbWBNSAm@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0602141211350.10793@p34>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: David Greaves <david@dgreaves.com>, Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tuesday 14 February 2006 12:12, Justin Piszcz wrote:
> I would like to try the patch too, if available.

Something like this:  (for 2.6.16-rc3-git2, but should be okay on 2.6.15 also).

Untested:  include the original SCSI opcode in printk's for libata SCSI errors,
to help understand where the errors are coming from.

Signed-Off-By:  Mark Lord <mlord@pobox.com>

--- linux/drivers/scsi/libata-scsi.c.orig	2006-02-12 19:27:25.000000000 -0500
+++ linux/drivers/scsi/libata-scsi.c	2006-02-14 12:54:17.000000000 -0500
@@ -420,6 +420,7 @@
  *	@sk: the sense key we'll fill out
  *	@asc: the additional sense code we'll fill out
  *	@ascq: the additional sense code qualifier we'll fill out
+ *	@opcode: the original SCSI command opcode byte
  *
  *	Converts an ATA error into a SCSI error.  Fill out pointers to
  *	SK, ASC, and ASCQ bytes for later use in fixed or descriptor
@@ -429,7 +430,7 @@
  *	spin_lock_irqsave(host_set lock)
  */
 void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc, 
-			u8 *ascq)
+			u8 *ascq, u8 opcode)
 {
 	int i;
 
@@ -508,8 +509,8 @@
 		}
 	}
 	/* No error?  Undecoded? */
-	printk(KERN_WARNING "ata%u: no sense translation for status: 0x%02x\n", 
-	       id, drv_stat);
+	printk(KERN_WARNING "ata%u: no sense translation for op=0x%02x status: 0x%02x\n", 
+	       id, opcode, drv_stat);
 
 	/* For our last chance pick, use medium read error because
 	 * it's much more common than an ATA drive telling you a write
@@ -520,8 +521,8 @@
 	*ascq = 0x04; /*  "auto-reallocation failed" */
 
  translate_done:
-	printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
-	       "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, drv_stat, drv_err,
+	printk(KERN_ERR "ata%u: translated op=0x%02x ATA stat/err 0x%02x/%02x to "
+	       "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, opcode, drv_stat, drv_err,
 	       *sk, *asc, *ascq);
 	return;
 }
@@ -562,7 +563,7 @@
 	 */
 	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
-				   &sb[1], &sb[2], &sb[3]);
+				   &sb[1], &sb[2], &sb[3], cmd->cmnd[0]);
 		sb[1] &= 0x0f;
 	}
 
@@ -637,7 +638,7 @@
 	 */
 	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
-				   &sb[2], &sb[12], &sb[13]);
+				   &sb[2], &sb[12], &sb[13], cmd->cmnd[0]);
 		sb[2] &= 0x0f;
 	}
 
