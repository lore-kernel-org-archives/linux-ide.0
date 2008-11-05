From: Tejun Heo <tj@kernel.org>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Wed, 05 Nov 2008 18:32:01 +0900
Message-ID: <49116811.5000109@kernel.org>
References: <871vxrzssj.fsf@denkblock.local>	<491026AB.1090704@kernel.org>	<20081104123211.A86321FD5A@chi.die-welt.net>	<49108120.6000205@rtr.ca>	<491083CC.5050508@rtr.ca>	<49108AA0.1080507@rtr.ca>	<491090BC.5060403@rtr.ca> <20081104185444.3BE721FDF7@chi.die-welt.net> <4910A509.1030307@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090906050309050009080104"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50855 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754025AbYKEJcY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Nov 2008 04:32:24 -0500
In-Reply-To: <4910A509.1030307@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Evgeni Golov <sargentd@die-welt.net>, Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------090906050309050009080104
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Mark Lord wrote:
> Evgeni Golov wrote:
>> On Tue, 04 Nov 2008 13:13:16 -0500 Mark Lord wrote:
>>
>>> Okay, hdparm-9.3 is now out in the wild (sourceforge),
>>> and has  --idle-immediate and --idle-unload  flags now,
>>> so it can be used to help debug/test this problem.
>>
>> Okay, got it, built it.
>> Neither --idle-immediate nor --idle-immediate brings up the reset,
>> echo 1000 > /sys/block/sda/device/unload_heads does.
> ..
> 
> Mmmm.. okay, this is new stuff in 2.6.28,
> and it appears to just issue a --idle-unload equivalent after a delay.
> 
> But it does it from within libata-eh, so I suppose there must
> be some confusion in there somewhere.
> 
> So it's up to Tejun now, I suppose.

Hmmm... maybe garbage values in unused TF regs?

-- 
tejun

--------------090906050309050009080104
Content-Type: text/x-patch;
 name="idleimm-dbg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idleimm-dbg.patch"

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8077bdf..f0f3d11 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2649,7 +2649,7 @@ static void ata_eh_park_issue_cmd(struct ata_device *dev, int park)
 		tf.command = ATA_CMD_CHK_POWER;
 	}
 
-	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.protocol |= ATA_PROT_NODATA;
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
 	if (park && (err_mask || tf.lbal != 0xc4)) {

--------------090906050309050009080104--
