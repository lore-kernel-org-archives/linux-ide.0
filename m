From: Tejun Heo <tj@kernel.org>
Subject: Re: Fwd: CF card I/O errors on Linux
Date: Sun, 23 May 2010 15:58:17 +0200
Message-ID: <4BF93479.8070506@kernel.org>
References: <7B56DFFC-819E-46BA-9D06-B9AB97144AD6@usgs.gov> <291D4AE0-82BE-44F8-9AF0-209433D9FA39@usgs.gov> <4BF505EC.5030102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46298 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754308Ab0EWN6a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 May 2010 09:58:30 -0400
In-Reply-To: <4BF505EC.5030102@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Larry Baker <baker@usgs.gov>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 05/20/2010 11:50 AM, Tejun Heo wrote:
>> If the failed command is one of the READ/WRITE MULTI commands (entries
>> 0-4 in ata_rw_cmds[]), and the device response is ABORT, use your
>> HORKAGE mechanism to set a flag like ATA_HORKAGE_BROKEN_MULTI to skip
>> setting dev->multi_count in libata-core.c (the code in 2., above), i.e.,
>> disable multi-sector transfers, then reconfigure the device to disable
>> multi-sector transfers (call ata_dev_configure(), I guess, so the new
>> configuration gets printed out in dmesg) and retry the transfer.  Any
>> future calls to ata_dev_configure() for that device will not attempt to
>> enable multi-sector transfers because the ATA_HORKAGE_BROKEN_MULTI is set:
>>
>> +        /* don't try to enable R/W multi if it is broken */
>> +        if (!(dev->horkage & ATA_HORKAGE_BROKEN_MULTI))
> 
> So, turn off MULTI on ABORT....  Oh yeah, I can add that to the
> existing speed down logic.  Would you be available to test patches?

Something like the following.  Please test whether it works as
expected.  It should turn off muti after two device errors during
partition scan.

Thanks.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c47373f..1f97189 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2416,7 +2416,8 @@ int ata_dev_configure(struct ata_device *dev)
 		dev->n_sectors = ata_id_n_sectors(id);

 		/* get current R/W Multiple count setting */
-		if ((dev->id[47] >> 8) == 0x80 && (dev->id[59] & 0x100)) {
+		if (!(dev->flags & ATA_DFLAG_MULTI_OFF) &&
+		    (dev->id[47] >> 8) == 0x80 && (dev->id[59] & 0x100)) {
 			unsigned int max = dev->id[47] & 0xff;
 			unsigned int cnt = dev->id[59] & 0xff;
 			/* only recognize/allow powers of two here */
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f77a673..60b352f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -53,6 +53,7 @@ enum {
 	ATA_EH_SPDN_SPEED_DOWN		= (1 << 1),
 	ATA_EH_SPDN_FALLBACK_TO_PIO	= (1 << 2),
 	ATA_EH_SPDN_KEEP_ERRORS		= (1 << 3),
+	ATA_EH_SPDN_MULTI_OFF		= (1 << 4),

 	/* error flags */
 	ATA_EFLAG_IS_IO			= (1 << 0),
@@ -1805,13 +1806,13 @@ static int speed_down_verdict_cb(struct ata_ering_entry *ent, void *void_arg)
  *	   occurred during last 5 mins, SPEED_DOWN and FALLBACK_TO_PIO.
  *
  *	2. If more than one DUBIOUS_TOUT_HSM or DUBIOUS_UNK_DEV errors
- *	   occurred during last 5 mins, NCQ_OFF.
+ *	   occurred during last 5 mins, NCQ_OFF and MULTI_OFF.
  *
  *	3. If more than 8 ATA_BUS, TOUT_HSM or UNK_DEV errors
  *	   ocurred during last 5 mins, FALLBACK_TO_PIO
  *
  *	4. If more than 3 TOUT_HSM or UNK_DEV errors occurred
- *	   during last 10 mins, NCQ_OFF.
+ *	   during last 10 mins, NCQ_OFF and MULTI_OFF.
  *
  *	5. If more than 3 ATA_BUS or TOUT_HSM errors, or more than 6
  *	   UNK_DEV errors occurred during last 10 mins, SPEED_DOWN.
@@ -1841,7 +1842,8 @@ static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)

 	if (arg.nr_errors[ATA_ECAT_DUBIOUS_TOUT_HSM] +
 	    arg.nr_errors[ATA_ECAT_DUBIOUS_UNK_DEV] > 1)
-		verdict |= ATA_EH_SPDN_NCQ_OFF | ATA_EH_SPDN_KEEP_ERRORS;
+		verdict |= ATA_EH_SPDN_NCQ_OFF | ATA_EH_SPDN_MULTI_OFF |
+			ATA_EH_SPDN_KEEP_ERRORS;

 	if (arg.nr_errors[ATA_ECAT_ATA_BUS] +
 	    arg.nr_errors[ATA_ECAT_TOUT_HSM] +
@@ -1855,7 +1857,7 @@ static unsigned int ata_eh_speed_down_verdict(struct ata_device *dev)

 	if (arg.nr_errors[ATA_ECAT_TOUT_HSM] +
 	    arg.nr_errors[ATA_ECAT_UNK_DEV] > 3)
-		verdict |= ATA_EH_SPDN_NCQ_OFF;
+		verdict |= ATA_EH_SPDN_NCQ_OFF | ATA_EH_SPDN_MULTI_OFF;

 	if (arg.nr_errors[ATA_ECAT_ATA_BUS] +
 	    arg.nr_errors[ATA_ECAT_TOUT_HSM] > 3 ||
@@ -1908,6 +1910,14 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev,
 		goto done;
 	}

+	/* turn off multi? */
+	if ((verdict & ATA_EH_SPDN_MULTI_OFF) && (dev->flags & ATA_DFLAG_PIO)) {
+		dev->flags |= ATA_DFLAG_MULTI_OFF;
+		ata_dev_printk(dev, KERN_WARNING,
+			       "PIO multi disabled due to excessive errors\n");
+		goto done;
+	}
+
 	/* speed down? */
 	if (verdict & ATA_EH_SPDN_SPEED_DOWN) {
 		/* speed down SATA link speed if possible */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ee84e7e..a145d80 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -147,6 +147,7 @@ enum {
 	ATA_DFLAG_DUBIOUS_XFER	= (1 << 16), /* data transfer not verified */
 	ATA_DFLAG_NO_UNLOAD	= (1 << 17), /* device doesn't support unload */
 	ATA_DFLAG_UNLOCK_HPA	= (1 << 18), /* unlock HPA */
+	ATA_DFLAG_MULTI_OFF	= (1 << 19), /* turn off PIO multi mode */
 	ATA_DFLAG_INIT_MASK	= (1 << 24) - 1,

 	ATA_DFLAG_DETACH	= (1 << 24),
