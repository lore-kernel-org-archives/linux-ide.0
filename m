From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] sata_sil: clean up and add errata/workaround documentation
Date: Sat, 25 Feb 2006 13:52:30 +0900
Message-ID: <11408431501105-git-send-email-htejun@gmail.com>
References: <11408431492856-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:48764 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932677AbWBYEvY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Feb 2006 23:51:24 -0500
Received: by zproxy.gmail.com with SMTP id r28so529271nza
        for <linux-ide@vger.kernel.org>; Fri, 24 Feb 2006 20:51:23 -0800 (PST)
In-Reply-To: <11408431492856-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, hellan@acm.org, Carlos.Pardo@siliconimage.com, Raymond.Liu@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

This patch collects into one place/update errata documentattion and
adds description of 3114 R_ERR on DMA activate FIS errata.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   97 ++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 75 insertions(+), 22 deletions(-)

6b1cc9dff33ae20157946ae8b06f1a11079b4af6
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 9face3c..75784cd 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -30,8 +30,79 @@
  *  Documentation for SiI 3112:
  *  http://gkernel.sourceforge.net/specs/sii/3112A_SiI-DS-0095-B2.pdf.bz2
  *
+ *  Documentation for SiI 3114:
+ *  http://gkernel.sourceforge.net/specs/sii/sii-0680a-v1.31.pdf.bz2
+ *
  *  Other errata and documentation available under NDA.
  *
+ *  Currently implemented workarounds are...
+ *
+ *  1. Mod15Write errata workaround
+ *
+ *  Errata:
+ *    The Mod15Write bug is caused by the SiI3112 controller splitting
+ *    data FIS in the middle of a 512 byte block when transferring
+ *    data equal to or larger than 8k (not prohibited by the standard
+ *    but still a bit peculiar) and some Seagate drives locking up on
+ *    receiving such data FIS.
+ *
+ *  Workaround:
+ *    This is worked around by limiting max_sectors to 15 such that
+ *    write data is always smaller than 8k.  This slows down IO
+ *    severely.
+ *
+ *    This workaround is applied during sil_dev_config() and the
+ *    affected drives are marked with SIL_QUIRK_MOD15WRITE in
+ *    sil_blacklist.
+ *
+ *    The workaround slows down everything considerably and tends to
+ *    hide other problems when applied.  Due to lack of information,
+ *    this workaround had been applied when some drives show similar
+ *    symptoms (e.g. errata #3).  It seems that the blacklist
+ *    currently contains some number of unaffected drives.
+ *
+ *    As we don't know exactly which drives are affected, slow_down
+ *    module parameter is implemented which turns on this workaround
+ *    manually.
+ *
+ *  2. Maxtor udma5 max errata
+ *
+ *  Errata:
+ *    For certain Maxtor devices, we must not program the drive be
+ *    beyond udma5.
+ *
+ *  Workaround:
+ *    Limit max transfer mode to udma5.
+ *
+ *    This workaround is applied during sli_dev_config() and the
+ *    affected drives are marked with SIL_QUIRK_UDMA5MAX in
+ *    sil_blacklist.
+ *
+ *    Note that udma5 is 100Mbytes/s which is more than sufficient, so
+ *    this workaround doesn't really affect performance.
+ *
+ *  3. SiI 3512/3114 R_ERR on DMA activate FIS errta workaround
+ *
+ *  Errata:
+ *    During DMA write operations with a data length greater than 8
+ *    Kbytes, a PRD entry fetch that occurs at the same time that a
+ *    DMA Activate FIS is received may cause the controller to falsely
+ *    indicate that the DMA Activate FIS has an illegal FIS Type.
+ *    This may cause the controller to send an R_EER in response to
+ *    the DMA Active FIS.
+ *
+ *  Workaround:
+ *    By configuring bit[1:0] of the SFISCfg register to accept FIS
+ *    types other than the standard SATA defined FIS types, the
+ *    controller is prevented from falsely setting the illegal FIS
+ *    Type indicator, thus preventing the improper RERR response.  The
+ *    default value of the SFISCfg register is 0x1040_1555.  To
+ *    implement this workaround, the SFISCfg register should be set to
+ *    a value of 0x1040_1554.
+ *
+ *    This workaround is applied during controller initialization in
+ *    sil_init_one().
+ *
  */
 
 #include <linux/kernel.h>
@@ -328,28 +399,10 @@ static void sil_scr_write (struct ata_po
  *	@dev: Device to be examined
  *
  *	After the IDENTIFY [PACKET] DEVICE step is complete, and a
- *	device is known to be present, this function is called.
- *	We apply two errata fixups which are specific to Silicon Image,
- *	a Seagate and a Maxtor fixup.
- *
- *	For certain Seagate devices, we must limit the maximum sectors
- *	to under 8K.
- *
- *	For certain Maxtor devices, we must not program the drive
- *	beyond udma5.
- *
- *	Both fixups are unfairly pessimistic.  As soon as I get more
- *	information on these errata, I will create a more exhaustive
- *	list, and apply the fixups to only the specific
- *	devices/hosts/firmwares that need it.
- *
- *	20040111 - Seagate drives affected by the Mod15Write bug are blacklisted
- *	The Maxtor quirk is in the blacklist, but I'm keeping the original
- *	pessimistic fix for the following reasons...
- *	- There seems to be less info on it, only one device gleaned off the
- *	Windows	driver, maybe only one is affected.  More info would be greatly
- *	appreciated.
- *	- But then again UDMA5 is hardly anything to complain about
+ *	device is known to be present, this function is called.  This
+ *	function also applies controller/device specific erratas,
+ *	please see the comment at the top of this file for more
+ *	information.
  */
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev)
 {
-- 
1.2.1


