From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: RE: [RFC PATCH] drivers: ata: Read Rx water mark value from
 device-tree
Date: Tue, 23 Feb 2016 05:58:32 +0000
Message-ID: <3802E9A6666DF54886E2B9CBF743BA9825E01009@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1455974302-7082-1-git-send-email-anuragku@xilinx.com>
 <28916176.WDrPajhOPa@wuerfel>
 <3802E9A6666DF54886E2B9CBF743BA9825E00BD4@XAP-PVEXMBX01.xlnx.xilinx.com>
 <18251200.Xfr10N5eWq@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-cys01nam02on0063.outbound.protection.outlook.com ([104.47.37.63]:46160
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750736AbcBWGOa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Feb 2016 01:14:30 -0500
In-Reply-To: <18251200.Xfr10N5eWq@wuerfel>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "tj@kernel.org" <tj@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anirudha Sarangi <anirudh@xilinx.com>, Srikanth Vemula <svemula@xilinx.com>, Punnaiah Choudary Kalluri <punnaia@xilinx.com>

Hi Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Monday, February 22, 2016 8:50 PM
> To: Anurag Kumar Vulisha
> Cc: robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> ijc+devicetree@hellion.org.uk; galak@codeaurora.org; tj@kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> ide@vger.kernel.org; Anirudha Sarangi; Srikanth Vemula; Punnaiah Choudary
> Kalluri
> Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from device-
> tree
>
> On Monday 22 February 2016 10:53:11 Anurag Kumar Vulisha wrote:
> > > >
> > >
> > > How would a hardware integrator know which value is right for a
> > > particular SoC?
> > >
> > > Could it be keyed off the hardware ID? Could the bootloader perhaps
> > > set an appropriate value in the AHCI_VEND_PTC register at boot time
> > > and the driver read the initial value from it?
> > >
> > > From the description, it sounds like this is a policy decision
> > > rather than hardware description, and shouldn't really be in here.
> > >
> >
> > Thanks for reviewing the patch. Can I use module_param() for this
> > watermark instead of reading it from devicetree or doing it in
> > bootloader. In bootloader we are initializing serdes controller for
> > high speed devices. As a part of this initialization we will be reseting all the
> high speed pheripherals which are using serdes, so SATA will also get
> resetted. Because of this reason, can I use module_param() for Rxwatermark
> value  instead?
> >
>
> I don't know what is appropriate because I have no idea what Rxwatermark is
> good for. Can you try describing why we can't just set it to the correct value
> for everyone automatically?
>

This RX watermark level sets the minimum number of free locations within the RX FIFO .When the rx fifo level crosses the programmed watermark level ,sata controller  will transmit HOLDS to the device asking it to wait. This happens when dma
reads the rx fifo data slower than the device is sending the data. Note that it can take some time for the HOLDs to get to
the other end and in the time there must be enough room in the FIFO to absorb all data that could arrive from the device.
Currently we are using 0x40 for this value, which works fine with all hardware designs  we are currently having. But hoping
that this value may vary for future silicon versions, I wanted to make this as a configurable value. So for this reason I thought
of moving it either to device-tree or making it as a module_param() property.

Thanks,
Anurag Kumar V

>       Arnd


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

