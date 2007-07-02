From: Chr <chunkeey@web.de>
Subject: Re: [patch 2.6.22-rc6] ATA: add a PCI ID for Intel Santa Rosa PATA controller
Date: Mon, 2 Jul 2007 13:24:16 +0200
Message-ID: <200707021324.17250.chunkeey@web.de>
References: <468408F1.3080307@redhat.com> <468886E1.7080302@leemhuis.info> <4688C054.2030208@leemhuis.info>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:43149 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbXGBLYT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 07:24:19 -0400
In-Reply-To: <4688C054.2030208@leemhuis.info>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thorsten Leemhuis <fedora@leemhuis.info>
Cc: Chuck Ebbert <cebbert@redhat.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jason Gaston <jason.d.gaston@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, chunkeey@web.de

On Monday, 2. July 2007, you wrote:
> On 02.07.2007 07:02, Thorsten Leemhuis wrote:
> Hmmm. From looking at the ICH8-Datasheet (
> http://www.intel.com/design/chipsets/datashts/313056.htm
> or http://download.intel.com/design/chipsets/datashts/31305603.pdf )
> page 189 and later it seems to me that the ICH8M (just as all the other
> Intel-Chipsets I know) officially only supports Ultra ATA 100 (and not
> 133!).
> 
> So is the ich_pata_133 correct in the patch (see quoted line above)?
> 
> CU
> thl
> 
(please keep the CC).

For some strange reason, I can not get the pdf...  

Anyway, the original patch had "ich_pata_100".
see: http://www.mail-archive.com/linux-ide%40vger.kernel.org/msg07416.html

but Alan Cox wrote:
http://www.mail-archive.com/linux-ide%40vger.kernel.org/msg07417.html
> 
> Its ich_pata_133 - all the newer chips are. They work even better if you
> set them into AHCI mode in the BIOS and then they should "just work" with
> recent kernels as the AHCI driver now matches by class.
> 
> Alan

And "Gaston, Jason D" <jason.d.gaston@intel.com> didn't complain about it.
it's a "bit" confusing with all "native" AHCI SATA chipset that have to emulate 
PATA for compatibility reasons... 

So, whom can we trust? I've seen wrong specs, but you know "To err is human".

Thanks,
	Chr.
