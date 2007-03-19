From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Mon, 19 Mar 2007 11:31:35 +0800
Message-ID: <45FE0417.8040200@tw.ibm.com>
References: <45F873AC.6010204@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FD5927.7080104@gmail.com> <200703181654.00829.bzolnier@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:45369 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933805AbXCSDbq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 23:31:46 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2J3VkJx020633
	for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 23:31:46 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2J3VkFJ059800
	for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 21:31:46 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2J3VjXC005100
	for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 21:31:45 -0600
In-Reply-To: <200703181654.00829.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: YUP <yupadmin@gmail.com>, albertl@mail.com, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sunday 18 March 2007, YUP wrote:
> 
>>Hello Bartek,
>>
>> >
>> > Thanks, does reading from CD/DVD media also work fine now?
>>
>>Yes, drives can read all media cd and dvd I have.
> 
> 
> OK, thanks for testing.
> 
> The conclusion here is that the problem experienced by Yarema
> is clearly some libata regression wrt drivers/ide.
> 

Hi Bart,

Agreed. Given both IDE and windows can read the AOpen drive without problem,
this clearly is libata regression.

I will try to find out the root cause of this libata regression.
Currently I suspect one of the INQUIRY commands sent by sr.c caused trouble:

[   62.013082] ata2.01: qc timeout (cmd 0xa0)
[   62.013098] ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   62.013160] ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 254 in
[   62.013163]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 0x5 (timeout)
[   69.002638] ata2: port is slow to respond, please be patient (Status 0xd8)
[   91.984233] ata2: port failed to respond (30 secs, Status 0xd8)
[   91.984292] ata2: soft resetting port
[   92.151391] ATA: abnormal status 0x7F on port 0xE08515DF
[   92.162767] ATA: abnormal status 0x7F on port 0xE08515DF

> 
>>>It seems that the drive works just fine in PIO mode with pdc202xx_new
>>>IDE driver (it doesn't support ATAPI DMA at the moment) and fails
>>>with pata_pdc2027x libata (even with DMA blacklist patch from Albert).
>>
>>Does it mean that I have to recompile all the time kernels from ubuntu 
>>repositories? Is there any possibility to blacklist pata_pdc2027x 
>>module and enable pdc202xx_new (just to compile one and add to the list 
>>of modules) ?
> 
> 
> Adding "blacklist pata_pdc2027xx" line to /etc/modprobe.conf should do this.
> You may also want to bring up this problem with Ubuntu developers.
> 

Hi Yurema,

Before doing "blacklist pata_pdc2027xx" and happily use all your drives with
the IDE driver, could you please hold a moment and help me to find out the 
root cause of the libata + pata_pdc2027xx + AOpen 56X/AKH problem?

If ok, could you please:
1. Keep the HP drive connected to the on-board Intel controller, the primary port.
   (Don't use the on-board secondary port.)
   Keep the hard drives connected to where they are.
   Make sure the AOpen drive is connected to the Promise adapter.

2. Reconfigure the kernel.
   Remove the IDE pdc202xx_new and add the libata pata_pdc2027x driver for debugging.

3. Apply the attached patch to the kernel (2.6.20.3) to gather more debugging info.
   Rebuild/reboot the kernel. Something like below should be logged:
   "ata2: protocol 6 task_state 4
    ata2: protocol 6 task_state 4 (dev_stat 0x58)
    ata2: protocol 6 task_state 2
    ata2: protocol 6 task_state 2 (dev_stat 0x51)
    ata2.01: qc timeout (cmd 0xa0)
    ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
    ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 254 in
             res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 0x5 (timeout)"

4. Collect the full dmesg with the first "qc timeout".

--
Thanks for your patience,

Albert

diff -Nrup linux-2.6.20.3/drivers/ata/libata-core.c linux-2.6.20.3-debug/drivers/ata/libata-core.c
--- linux-2.6.20.3/drivers/ata/libata-core.c	2007-03-14 02:27:08.000000000 +0800
+++ linux-2.6.20.3-debug/drivers/ata/libata-core.c	2007-03-19 11:20:33.000000000 +0800
@@ -3296,6 +3296,7 @@ static const struct ata_blacklist_entry 
 	{ "SanDisk SDP3B",	NULL,		ATA_HORKAGE_NODMA },
 	{ "SanDisk SDP3B-64",	NULL,		ATA_HORKAGE_NODMA },
 	{ "SANYO CD-ROM CRD",	NULL,		ATA_HORKAGE_NODMA },
+	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_NODMA },
 	{ "HITACHI CDR-8",	NULL,		ATA_HORKAGE_NODMA },
 	{ "HITACHI CDR-8335",	NULL,		ATA_HORKAGE_NODMA },
 	{ "HITACHI CDR-8435",	NULL,		ATA_HORKAGE_NODMA },
@@ -3303,6 +3304,7 @@ static const struct ata_blacklist_entry 
 	{ "TOSHIBA CD-ROM XM-1702BC", NULL,	ATA_HORKAGE_NODMA },
 	{ "CD-532E-A", 		NULL,		ATA_HORKAGE_NODMA },
 	{ "E-IDE CD-ROM CR-840",NULL,		ATA_HORKAGE_NODMA },
+	{ "CD-ROM 56X/AKH",	NULL,		ATA_HORKAGE_NODMA },
 	{ "CD-ROM Drive/F5A",	NULL,		ATA_HORKAGE_NODMA },
 	{ "WPI CDD-820", 	NULL,		ATA_HORKAGE_NODMA },
 	{ "SAMSUNG CD-ROM SC-148C", NULL,	ATA_HORKAGE_NODMA },
@@ -4371,8 +4373,9 @@ int ata_hsm_move(struct ata_port *ap, st
 	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
 
 fsm_start:
-	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
+	if ((ap->id == 2) || (ap->id == 4))
+		printk(KERN_ERR "ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
+		       ap->id, qc->tf.protocol, ap->hsm_task_state, status);
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
@@ -5091,8 +5094,14 @@ inline unsigned int ata_host_intr (struc
 	struct ata_eh_info *ehi = &ap->eh_info;
 	u8 status, host_stat = 0;
 
-	VPRINTK("ata%u: protocol %d task_state %d\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state);
+	if ((ap->id == 2) || (ap->id == 4)) {
+		printk(KERN_ERR "ata%u: protocol %d task_state %d\n",
+		       ap->id, qc->tf.protocol, ap->hsm_task_state);
+
+		host_stat = ap->ops->bmdma_status(ap);
+		printk(KERN_ERR "ata%u: host_stat 0x%X\n", ap->id, host_stat);
+		
+	}
 
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {
diff -Nrup linux-2.6.20.3/drivers/ata/libata-scsi.c linux-2.6.20.3-debug/drivers/ata/libata-scsi.c
--- linux-2.6.20.3/drivers/ata/libata-scsi.c	2007-03-14 02:27:08.000000000 +0800
+++ linux-2.6.20.3-debug/drivers/ata/libata-scsi.c	2007-03-19 11:20:56.000000000 +0800
@@ -2729,17 +2729,17 @@ static inline ata_xlat_func_t ata_get_xl
 static inline void ata_scsi_dump_cdb(struct ata_port *ap,
 				     struct scsi_cmnd *cmd)
 {
-#ifdef ATA_DEBUG
 	struct scsi_device *scsidev = cmd->device;
 	u8 *scsicmd = cmd->cmnd;
 
-	DPRINTK("CDB (%u:%d,%d,%d) %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
-		ap->id,
-		scsidev->channel, scsidev->id, scsidev->lun,
-		scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
-		scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
-		scsicmd[8]);
-#endif
+	if ((ap->id == 2) || (ap->id == 4)) {
+		printk(KERN_ERR "CDB (%u:%d,%d,%d) %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
+		       ap->id,
+		       scsidev->channel, scsidev->id, scsidev->lun,
+		       scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
+		       scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
+		       scsicmd[8]);
+	}
 }
 
 static inline int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,







