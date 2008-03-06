From: Tejun Heo <htejun@gmail.com>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Thu, 06 Mar 2008 17:39:59 +0900
Message-ID: <47CFADDF.20200@gmail.com>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange> <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.189]:10868 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbYCFIkK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 03:40:10 -0500
Received: by gv-out-0910.google.com with SMTP id s4so1413096gve.37
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 00:40:08 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0802290010320.10498@axis700.grange>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Guennadi Liakhovetski wrote:
> Indeed! It was in "IDE" mode, and 2 out of the 3 chips were handled by the 
> piix driver (btw, why did Intel put 3 different SATA controllers on one 
> board?). I switched it to AHCI mode (the third possibility is RAID) and 
> indeed a kernel with (only) ahci driver managed to bring them up! 
> Although, the eSATA link was "slow to respond":
> 
> ata4: port is slow to respond, please be patient (Status 0x80)
> ata4: softreset failed (device not ready)
> ata4: port is slow to respond, please be patient (Status 0x80)
> ata4: softreset failed (device not ready)
> ata4: port is slow to respond, please be patient (Status 0x80)
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.00: ATA-7: WDC WD1600BB-00RDA0, 20.00K20, max UDMA/100
> ata4.00: 312581808 sectors, multi 16: LBA48
> ata4.00: applying bridge limits
> ata4.00: configured for UDMA/100
> 
> but then it did manage it. Is such a delay normal?

If you hotplugged it, sometimes drives don't respond too well and takes
a few retries to talk to it.  How long did the whole thing take?  And is
it always like that?

> One more question, what do UDMA numbers mean in SATA context? The internal 
> SATA disk is "ata1.00: configured for UDMA/133", but should be SATA-2.

1.00 is port 1 device 00 and UDMA numbers don't mean much to SATA devices.

Thanks.

-- 
tejun
