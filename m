From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from device-tree
Date: Tue, 23 Feb 2016 11:20:30 +0100
Message-ID: <8540232.vQE3WQTD95@wuerfel>
References: <1455974302-7082-1-git-send-email-anuragku@xilinx.com> <18251200.Xfr10N5eWq@wuerfel> <3802E9A6666DF54886E2B9CBF743BA9825E01009@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:58903 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbcBWKVl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Feb 2016 05:21:41 -0500
In-Reply-To: <3802E9A6666DF54886E2B9CBF743BA9825E01009@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "tj@kernel.org" <tj@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anirudha Sarangi <anirudh@xilinx.com>, Srikanth Vemula <svemula@xilinx.com>, Punnaiah Choudary Kalluri <punnaia@xilinx.com>

On Tuesday 23 February 2016 05:58:32 Anurag Kumar Vulisha wrote:
> >
> > I don't know what is appropriate because I have no idea what Rxwatermark is
> > good for. Can you try describing why we can't just set it to the correct value
> > for everyone automatically?
> >
> 
> This RX watermark level sets the minimum number of free locations within the RX FIFO .When the rx fifo level crosses the programmed watermark level ,sata controller  will transmit HOLDS to the device asking it to wait. This happens when dma
> reads the rx fifo data slower than the device is sending the data. Note that it can take some time for the HOLDs to get to
> the other end and in the time there must be enough room in the FIFO to absorb all data that could arrive from the device.
> Currently we are using 0x40 for this value, which works fine with all hardware designs  we are currently having. But hoping
> that this value may vary for future silicon versions, I wanted to make this as a configurable value. So for this reason I thought
> of moving it either to device-tree or making it as a module_param() property.
> 

Ok, so if this depends on the silicon version, your initial approach
would be better than the module_param.

I would probably make this dependent on the compatible string instead,
and have a table in the device driver that uses a specific value
for each variant of the device, but either way should be fine.

Having a separate property is most appropriate if for each hardware
revision there is exactly one ideal value, while a table in the
driver makes more sense if this takes a bit of tuning and the driver
might choose to optimize it differently based on other constraints,
such as its own interrupt handler implementation.

	Arnd
