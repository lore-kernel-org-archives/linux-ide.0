From: Tejun Heo <htejun@gmail.com>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Fri, 07 Mar 2008 13:51:50 +0900
Message-ID: <47D0C9E6.8090301@gmail.com>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange> <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange> <47CFADDF.20200@gmail.com> <Pine.LNX.4.64.0803061248070.5670@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010401000509030904090105"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.189]:14146 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbYCGEwB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 23:52:01 -0500
Received: by rn-out-0910.google.com with SMTP id v46so551036rnb.15
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 20:52:00 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0803061248070.5670@axis700.grange>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010401000509030904090105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Guennadi Liakhovetski wrote:
> Mar  4 15:04:28 6a kernel: ata4: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xa frozen
> Mar  4 15:04:28 6a kernel: ata4: irq_stat 0x00000040, connection status changed
> Mar  4 15:04:28 6a kernel: ata4: SError: { PHYRdyChg CommWake DevExch }Mar  4 15:04:28 6a kernel: ata4: hard resetting link
> Mar  4 15:04:38 6a kernel: ata4: softreset failed (device not ready)
> Mar  4 15:04:38 6a kernel: ata4: hard resetting link
> Mar  4 15:04:48 6a kernel: ata4: softreset failed (device not ready)
> Mar  4 15:04:48 6a kernel: ata4: hard resetting link
> Mar  4 15:04:55 6a kernel: ata4: port is slow to respond, please be patient (Status 0x80)
> Mar  4 15:05:20 6a kernel: ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

That's unusually long but if you look at the last reset try.  It began
at @48 and the device comes up after 32secs without the driver taking
further action, which might indicate that the device actually took that
long.  Hmmm.. maybe it's having problem establishing link at 3Gbps.

> Looks like almost a minute to me? On another occurence I see about 1.5 
> minutes, then "port is slow to respond, please be patient (Status 0x80)" 
> has been repeated 3 times. On cold-plug also 3 times, I think, about the 
> same time then (time is not updated in the log).

I see.  Does the attached patch make any difference?

>> And is it always like that?
> 
> So far - yes.
> 
>>> One more question, what do UDMA numbers mean in SATA context? The internal 
>>> SATA disk is "ata1.00: configured for UDMA/133", but should be SATA-2.
>> 1.00 is port 1 device 00 and UDMA numbers don't mean much to SATA devices.
> 
> Sorry, I actually meant to ask what "UDMA/133" means for a SATA link?

That doesn't really mean much to native SATA devices.  That's just
something we're carrying over from PATA days.

Thanks.

-- 
tejun

--------------010401000509030904090105
Content-Type: text/x-patch;
 name="force-1.5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="force-1.5.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4fbcce7..abebdcc 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6712,6 +6712,7 @@ int sata_link_init_spd(struct ata_link *link)
 	spd = (scontrol >> 4) & 0xf;
 	if (spd)
 		link->hw_sata_spd_limit &= (1 << spd) - 1;
+	link->hw_sata_spd_limit = 1;
 
 	ata_force_spd_limit(link);
 

--------------010401000509030904090105--
