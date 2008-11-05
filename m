From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Wed, 05 Nov 2008 19:55:44 +0100
Message-ID: <87mygeypcf.fsf@denkblock.local>
References: <871vxrzssj.fsf@denkblock.local> <491026AB.1090704@kernel.org>
	<20081104123211.A86321FD5A@chi.die-welt.net> <49108120.6000205@rtr.ca>
	<491083CC.5050508@rtr.ca> <49108AA0.1080507@rtr.ca>
	<491090BC.5060403@rtr.ca> <20081104185444.3BE721FDF7@chi.die-welt.net>
	<4910A509.1030307@rtr.ca> <49116811.5000109@kernel.org>
	<873ai6cmio.fsf@denkblock.local> <4911A8EA.8030605@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:35135 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbYKESz6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Nov 2008 13:55:58 -0500
In-Reply-To: <4911A8EA.8030605@kernel.org> (Tejun Heo's message of "Wed, 05
	Nov 2008 23:08:42 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <liml@rtr.ca>, Evgeni Golov <sargentd@die-welt.net>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo <tj@kernel.org> wrote:
> Elias Oltmanns wrote:
[...]
>> As a wild guess, I'm wondering whether ata_eh_revalidate_and_attach()
>> has anything to do with it. Unless you have a better suggestion, perhaps
>> the following debug patch would give some useful information.
>
> I don't have much idea at this point.  To the drive, it shouldn't look
> any different.  Ah... it's ata_piix, right?  ata_piix doesn't have PHY
> event IRQ, so it could be that the command issued by hdparm did trigger
> PHY event but didn't get noticed by EH while the condition triggered by
> IDLE IMMEDIATE did.  One way to find out would be adding SCR print outs
> on command completion.

Right. Evgeni, could you please apply the following patch (2.6.28-rc3 or
thereabouts) and do the following in that order? Please report what has
been logged in dmesg:

# hdparm --idle-immediate /dev/sda
# hdparm --idle-unload /dev/sda
# hdparm --idle-immediate /dev/sda
# echo 1000 > /sys/block/sda/device/unload_heads
# hdparm --idle-immediate /dev/sda

The last one is only meant to verify that it behaves like the first.

Regards,

Elias
---
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 622350d..4948433 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4683,6 +4683,8 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 	if (ap->ops->error_handler) {
 		struct ata_device *dev = qc->dev;
 		struct ata_eh_info *ehi = &dev->link->eh_info;
+		u32 serror;
+		int rc;
 
 		WARN_ON(ap->pflags & ATA_PFLAG_FROZEN);
 
@@ -4721,6 +4723,16 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 		case ATA_CMD_SLEEP:
 			dev->flags |= ATA_DFLAG_SLEEPING;
 			break;
+
+		case ATA_CMD_IDLEIMMEDIATE:
+			rc = sata_scr_read(dev->link, SCR_ERROR, &serror);
+			if (!rc)
+				ata_dev_printk(dev, KERN_INFO,
+					       "SError: 0x%x\n", serror);
+			else
+				ata_dev_printk(dev, KERN_INFO,
+					       "Couldn't read SError: %d\n", rc);
+			break;
 		}
 
 		if (unlikely(dev->flags & ATA_DFLAG_DUBIOUS_XFER))
