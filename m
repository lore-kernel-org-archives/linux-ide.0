From: "Grant Grundler" <grundler@google.com>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Thu, 28 Aug 2008 08:53:49 -0700
Message-ID: <da824cf30808280853o11a8637fk96a3645e1066112a@mail.gmail.com>
References: <200808261045.33241.elendil@planet.nl>
	 <200808281125.14012.elendil@planet.nl>
	 <c70ff3ad0808280353n18967a9frf414091ae768030c@mail.gmail.com>
	 <200808281317.04908.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:42057 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbYH1PyB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Aug 2008 11:54:01 -0400
Received: from spaceape11.eur.corp.google.com (spaceape11.eur.corp.google.com [172.28.16.145])
	by smtp-out.google.com with ESMTP id m7SFrpYx006659
	for <linux-ide@vger.kernel.org>; Thu, 28 Aug 2008 16:53:51 +0100
Received: from ug-out-1314.google.com (ugez36.prod.google.com [10.66.177.36])
	by spaceape11.eur.corp.google.com with ESMTP id m7SFqbSf009524
	for <linux-ide@vger.kernel.org>; Thu, 28 Aug 2008 08:53:50 -0700
Received: by ug-out-1314.google.com with SMTP id z36so1130140uge.32
        for <linux-ide@vger.kernel.org>; Thu, 28 Aug 2008 08:53:50 -0700 (PDT)
In-Reply-To: <200808281317.04908.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: saeed bishara <saeed.bishara@gmail.com>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Thu, Aug 28, 2008 at 4:17 AM, Frans Pop <elendil@planet.nl> wrote:
> On Thursday 28 August 2008, saeed bishara wrote:
>> can you try setting bit 0 of the 0xf108002c then run some io?
>
> How can I set that bit?

Try mmio_rd/mmio_wr at  http://svn.gnumonks.org/trunk/mmio_test/

grant

>
>> which disk you have there?
>
> ata1.00: ATA-7: HDT722516DLA380, V43OA91A, max UDMA/133
> ata1.00: 321672960 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata1.00: configured for UDMA/133
> ata2: SATA link down (SStatus 0 SControl 300)
> scsi 0:0:0:0: Direct-Access     ATA      HDT722516DLA380  V43O PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
> sd 0:0:0:0: [sda] Attached SCSI disk
> sd 0:0:0:0: Attached scsi generic sg0 type 0
>
> From smartctl:
> Model Family:     Hitachi Deskstar T7K250 series
> Device Model:     HDT722516DLA380
> Firmware Version: V43OA91A
> User Capacity:    164,696,555,520 bytes
> ATA Version is:   7
> ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 1
>
>> is there any chance that you can replace it with different model that
>> support NCQ?
>
> No, sorry. This is the only model SATA disk I have available. However, I use the
> exact same model in a x86_64 desktop without any problems.
>
> Possibly another owner of a TS-109 or maybe TS-209 can confirm the issue with a
> different model disk.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
