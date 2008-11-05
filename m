From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Wed, 05 Nov 2008 14:47:43 +0100
Message-ID: <873ai6cmio.fsf@denkblock.local>
References: <871vxrzssj.fsf@denkblock.local> <491026AB.1090704@kernel.org>
	<20081104123211.A86321FD5A@chi.die-welt.net> <49108120.6000205@rtr.ca>
	<491083CC.5050508@rtr.ca> <49108AA0.1080507@rtr.ca>
	<491090BC.5060403@rtr.ca> <20081104185444.3BE721FDF7@chi.die-welt.net>
	<4910A509.1030307@rtr.ca> <49116811.5000109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:41684 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125AbYKENr4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Nov 2008 08:47:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <liml@rtr.ca>, Evgeni Golov <sargentd@die-welt.net>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo <tj@kernel.org> wrote:
> Mark Lord wrote:
>> Evgeni Golov wrote:
>
>>> On Tue, 04 Nov 2008 13:13:16 -0500 Mark Lord wrote:
>>>
>>>> Okay, hdparm-9.3 is now out in the wild (sourceforge),
>>>> and has  --idle-immediate and --idle-unload  flags now,
>>>> so it can be used to help debug/test this problem.
>>>
>>> Okay, got it, built it.
>>> Neither --idle-immediate nor --idle-immediate brings up the reset,
>>> echo 1000 > /sys/block/sda/device/unload_heads does.

You really have tested --idle-unload as well, I suppose.

[...]
> Hmmm... maybe garbage values in unused TF regs?
[...]
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 8077bdf..f0f3d11 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2649,7 +2649,7 @@ static void ata_eh_park_issue_cmd(struct ata_device *dev, int park)
>  		tf.command = ATA_CMD_CHK_POWER;
>  	}
> 
> -	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
> +	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;

After my embarrassing failure to parse a macro correctly a few days
back, I've got to be careful ;-). But still, what good does that patch
do? It doesn't really change anything, does it?

As a wild guess, I'm wondering whether ata_eh_revalidate_and_attach()
has anything to do with it. Unless you have a better suggestion, perhaps
the following debug patch would give some useful information.

Regards,

Elias
---
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8077bdf..26dc4d9 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3020,6 +3020,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	struct ata_device *dev;
 	int nr_failed_devs;
 	int rc;
+	int dev_parked = 0;
 	unsigned long flags, deadline;
 
 	DPRINTK("ENTER\n");
@@ -3123,6 +3124,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 					continue;
 
 				ata_eh_park_issue_cmd(dev, 1);
+				dev_parked = 1;
 			}
 		}
 
@@ -3135,10 +3137,17 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	} while (deadline);
 	ata_port_for_each_link(link, ap) {
 		ata_link_for_each_dev(dev, link) {
+			u32 serror;
+
 			if (!(link->eh_context.unloaded_mask &
 			      (1 << dev->devno)))
 				continue;
 
+			sata_scr_read(link, SCR_ERROR, &serror);
+			ata_dev_printk(dev, KERN_INFO,
+				       "SError: 0x%x, hotplug: %d\n",
+				       serror,
+				       ap->pflags & ATA_PFLAG_SCSI_HOTPLUG ? 1 : 0);
 			ata_eh_park_issue_cmd(dev, 0);
 			ata_eh_done(link, dev, ATA_EH_PARK);
 		}
@@ -3203,6 +3212,9 @@ dev_fail:
 		}
 	}
 
+	if (dev_parked)
+		ata_port_printk(ap, KERN_INFO, "hotplug: %d, nr_failed: %d\n",
+				ap->pflags & ATA_PFLAG_SCSI_HOTPLUG ? 1 : 0, nr_failed_devs);
 	if (nr_failed_devs)
 		goto retry;
 
