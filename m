From: "Andrew Hall" <andrew.a.hall@gmail.com>
Subject: RE: CF flash IDE failure to attach with 2.6.20+
Date: Mon, 25 Jun 2007 19:05:56 +1000
Message-ID: <467f858a.08b38c0a.77cc.5cf5@mx.google.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:63483 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbXFYJGW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 05:06:22 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1290847nzf
        for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 02:06:21 -0700 (PDT)
In-Reply-To: <4679EA43.4040002@gmail.com>
Content-Language: en-au
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, 'Jeff Garzik' <jeff@garzik.org>

> Does piix driver work?  If so, can you post boot dmesg and the result
> of
> 'hdparm -I /dev/hdX'?

I've still been battling to get this hardware detected with any of the
drivers mentioned previously except the newer libata piix driver. However
when using the old driver and using "all-generic-ide" and "irqpoll" as
kernel parameters I now have the device being detected albeit complaining
about lost interrupts and DMA timeouts. Here is the output from the hdparm
-I /dev/hda that you requested:

/dev/hda:

ATA device, with non-removable media
        Model Number:       CF CARD 512MB
        Serial Number:      CF512       0001943B
        Firmware Revision:  20070131
Standards:
        Likely used: 5
Configuration:
        Logical         max     current
        cylinders       983     983
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:     990864
        LBA    user addressable sectors:     990864
        device size with M = 1024*1024:         483 MBytes
        device size with M = 1000*1000:         507 MBytes
Capabilities:
        LBA, IORDY(may be)(cannot be disabled)
        bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Vendor
        R/W multiple sector transfer: Max = 1   Current = 1
        DMA: mdma0 mdma1 *mdma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
HW reset results:
        CBLID- below Vih
        Device num = 0

Many thanks for your help.

