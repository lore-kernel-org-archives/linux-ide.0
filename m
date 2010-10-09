From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ata device numbers
Date: Sat, 9 Oct 2010 20:01:10 +0100
Message-ID: <20101009200110.3e00a14c@lxorguk.ukuu.org.uk>
References: <4CB0A19C.20604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42280 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756091Ab0JISet (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Oct 2010 14:34:49 -0400
In-Reply-To: <4CB0A19C.20604@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri Olin <harri.olin@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

> ata13: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata13.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
> ata13.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata13.00: configured for UDMA/133
> scsi 12:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 
> ANSI: 5
> sd 12:0:0:0: [sdm] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
> sd 12:0:0:0: Attached scsi generic sg12 type 0
> sd 12:0:0:0: [sdm] Write Protect is off
> sd 12:0:0:0: [sdm] Mode Sense: 00 3a 00 00
> sd 12:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA
>   sdm: sdm1
> sd 12:0:0:0: [sdm] Attached SCSI disk

So /dev/sdm

