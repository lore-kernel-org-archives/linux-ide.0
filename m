From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Problems with Silicon Image Port Multiplier Card
Date: Tue, 03 Nov 2009 18:11:54 -0600
Message-ID: <4AF0C6CA.8020205@gmail.com>
References: <4AF0A1FC.4030106@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:47950 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbZKDALw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Nov 2009 19:11:52 -0500
Received: by gxk26 with SMTP id 26so4107248gxk.1
        for <linux-ide@vger.kernel.org>; Tue, 03 Nov 2009 16:11:57 -0800 (PST)
In-Reply-To: <4AF0A1FC.4030106@aon.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-ide@vger.kernel.org

On 11/03/2009 03:34 PM, Peter Klotz wrote:
> Hello
>
> My port multiplier capable eSATA Express Card refuses to talk to my
> external HDD box (2 HDDs, JBOD mode).
>
> Inserting the card into the Express Card slot looks normal:
>
> [ 622.549794] pciehp 0000:00:1c.2:pcie04: Card present on Slot(0)
> [ 622.698856] sata_sil24 0000:03:00.0: enabling device (0100 -> 0103)
> [ 622.698873] sata_sil24 0000:03:00.0: PCI INT A -> GSI 18 (level, low)
> -> IRQ 18
> [ 622.702334] scsi8 : sata_sil24
> [ 622.709268] scsi9 : sata_sil24
> [ 622.709409] ata7: SATA max UDMA/100 host m128@0xfd804000 port
> 0xfd800000 irq 18
> [ 622.709418] ata8: SATA max UDMA/100 host m128@0xfd804000 port
> 0xfd802000 irq 18
> [ 624.800150] ata7: SATA link down (SStatus 0 SControl 0)
> [ 626.890131] ata8: SATA link down (SStatus 0 SControl 0)
>
>
> Turning on the external box results in lots of errors:
>
> [ 666.030153] ata8: hard resetting link
> [ 668.250125] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> [ 668.250949] ata8.15: Port Multiplier 1.1, 0x1095:0x5744 r33, 3 ports,
> feat 0x1/0x9
> [ 668.251251] ata8.15: applying bridge limits
> [ 668.251340] ata8.00: hard resetting link
> [ 668.720140] ata8.00: failed to read SCR 0 (Emask=0x40)
> [ 668.720156] ata8.15: hard resetting link
> [ 668.720161] ata8: controller in dubious state, performing PORT_RST

Which kernel version is this? Can you test latest git?
