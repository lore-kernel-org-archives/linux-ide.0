From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv PCI ERROR; PCI IRQ reason=0x00000000 highpoint rocketraid
 2300 pci-e
Date: Wed, 14 Nov 2007 18:35:39 -0500
Message-ID: <473B864B.1040401@rtr.ca>
References: <1195081099.21755.18.camel@liza>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3857 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755472AbXKNXfk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Nov 2007 18:35:40 -0500
In-Reply-To: <1195081099.21755.18.camel@liza>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hein-Pieter van Braam <hp@syntomax.com>
Cc: linux-ide@vger.kernel.org

Hein-Pieter van Braam wrote:
> Hi list,
> 
> I have a couple of Highpoint Rocket(Fake)Raid 2300 PCI-e X1 adapters in
> my system, I bought those because the box said ('Open Source' next to
> 'linux driver' btw, talk about false advertising). Here's the lspci
> output:
> 
> 02:00.0 SCSI storage controller: HighPoint Technologies, Inc. RocketRAID
> 230x 4 Port SATA-II Controller (rev 02)
> 03:00.0 SCSI storage controller: HighPoint Technologies, Inc. RocketRAID
> 230x 4 Port SATA-II Controller (rev 02)
> 04:00.0 SCSI storage controller: HighPoint Technologies, Inc. RocketRAID
> 230x 4 Port SATA-II Controller (rev 02)
> 
> and lspci -n
> 
> 02:00.0 0100: 1103:2300 (rev 02)
> 03:00.0 0100: 1103:2300 (rev 02)
> 04:00.0 0100: 1103:2300 (rev 02)
> 
> Now, because the chip on the thing is a Marvell 7042 I figured I just
> add the PCI ID to the driver. I tried this, and, if I do not boot from
> the device it does seem to work. I did however get the following errors
> (a lot):
> 
> 02:00.0 sata_mv PCI ERROR; PCI IRQ reason=0x00000000
...

Mmm.. the current 7042 support is somewhat experimental,
and definitely temperamental.  Over the next few months I expect
to be involved in fixing all of that, bringing it up to fully
supported in all modes.

The reference board I have here with a 7042 seems to work just fine for me,
so I really should get hold of one like yours.

But they're not cheap (~$150 shipped).

Anyway.  Unless somebody else fixes it in the meanwhile,
stay tuned for full support in the December/January timeframe.

-ml

> I write this from memory, but the numbers are correct, sorry if they do
> not EXACTLY match.
> 
> The disk drives do work, but they are dog slow, and when I try to boot
> my ubuntu 7.10 system with this driver, it hangs during boot, right
> after it tried to enable my software raid volumes. 
> 
> I have tried both the 'stock' ubuntu kernel 2.6.22-14-generic (I guess
> that won't mean much) but I also tried vanilla kernel.org 2.6.23.1
> 
> I realize that this is probably too little information, and I'm very
> willing to provide any other information that you might want. 
> I'd love to provide a complete boot log, but my @#$@#%@#$ motherboard
> does not have a serial interface. Any suggestion is highly
> appreciated :)
> 
> Thank you so much for your help in advance, I feel all dirty using the
> proprietary driver from highpoint :)
> 
> - Hein-Pieter van Braam
> 
> 

