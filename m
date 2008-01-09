From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil[24] / silicon image binary drivers / SiI4726 RAID
Date: Wed, 09 Jan 2008 14:52:58 +0900
Message-ID: <4784613A.7020507@gmail.com>
References: <20080103141049.5c7534c8@pane.pane>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:47443 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbYAIFxE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 00:53:04 -0500
Received: by rv-out-0910.google.com with SMTP id k20so106489rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 21:53:04 -0800 (PST)
In-Reply-To: <20080103141049.5c7534c8@pane.pane>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Neuwirth <mail@paul-neuwirth.de>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Paul Neuwirth wrote:
> Hallo,
> i hope I am here at the right address. I am using a Silicon Image 3124
> SATA-Controller with the Silicon Image 4726 pm /
> hardware-RAID product, using the sata_sil24 driver.
> The pm is also a hardware raid-controller (not SATARAID - fake, see
> docs on http://www.siliconimage.com/products/product.aspx?id=74).
> For the configuration of hardware raid, you can download a software
> from the sii website (SiI4726 Manager). But this software only seems to
> work with the precompiled proprietary drivers from sii (e.g.
> sii3124.ko), i think there are unimplemented specific commands in the
> sil_sata(24) drivers.
> Isn't it possible to make a opensource way to configure the hardware
> raid controller or make the sil_sata(24) driver be usable with the
> sii's RAID manager? (If the hardware would be needed therefor i could
> provide)
> The binary drivers from sii for their controllers are unfortunately only
> available for a very low number of kernels (e.g. suse enterprise, RHEL
> kernels, see
> http://www.siliconimage.com/support/supportsearchresults.aspx?pid=27&cid=3&ctid=2&osid=1&). 
> I don't know whom to contact at sii to get specifications or (more
> improbably) a suiting driver... Nor am I an kernel programmer...
> I only know following:
> -for the configuration a "config disk" is provided by the pm (hwinfo is
> below)
> -the sii configuration manager recognizes all SATA-disks, but doesn't
> detect serial numbers or the config disk.

The Config Disk pseudo device used for 4276 configuration is seriously
brain damaged.

1. Locks up on SRST.
2. Times out on DMA READ at offset zero (ie. timeout on partition scan).
3. PIO READ works but PIO READs always return zero

Currently, libata-pmp works around #1 and #2.  #2 is worked around by
forcing PIO mode.  Because PIO READs always return zero, partition code
just skips the device.  The problem is that the configuration program
can also read zeros.  I suggested SIMG to update their program to use
SG_IO for config disk access which then can be quirked in libata to
allow special case DMA accesses but never got a reply on the subject.

-- 
tejun
