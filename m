From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from device-tree
Date: Mon, 22 Feb 2016 16:19:39 +0100
Message-ID: <18251200.Xfr10N5eWq@wuerfel>
References: <1455974302-7082-1-git-send-email-anuragku@xilinx.com> <28916176.WDrPajhOPa@wuerfel> <3802E9A6666DF54886E2B9CBF743BA9825E00BD4@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:53144 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbcBVPT6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Feb 2016 10:19:58 -0500
In-Reply-To: <3802E9A6666DF54886E2B9CBF743BA9825E00BD4@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "tj@kernel.org" <tj@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anirudha Sarangi <anirudh@xilinx.com>, Srikanth Vemula <svemula@xilinx.com>, Punnaiah Choudary Kalluri <punnaia@xilinx.com>

On Monday 22 February 2016 10:53:11 Anurag Kumar Vulisha wrote:
> > >
> > 
> > How would a hardware integrator know which value is right for a particular
> > SoC?
> > 
> > Could it be keyed off the hardware ID? Could the bootloader perhaps set an
> > appropriate value in the AHCI_VEND_PTC register at boot time and the driver
> > read the initial value from it?
> > 
> > From the description, it sounds like this is a policy decision rather than
> > hardware description, and shouldn't really be in here.
> > 
> 
> Thanks for reviewing the patch. Can I use module_param() for this watermark instead of reading it from devicetree or
> doing it in bootloader. In bootloader we are initializing serdes controller for high speed devices. As a part of this initialization
> we will be reseting all the high speed pheripherals which are using serdes, so SATA will also get resetted. Because of this
> reason, can I use module_param() for Rxwatermark value  instead?
> 

I don't know what is appropriate because I have no idea what Rxwatermark
is good for. Can you try describing why we can't just set it to the
correct value for everyone automatically?

	Arnd
