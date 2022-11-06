Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920DFC4332F
	for <linux-ide@archiver.kernel.org>; Sun,  6 Nov 2022 07:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKFHFT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Nov 2022 02:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKFHFS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Nov 2022 02:05:18 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18856A45A
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 00:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667718317; x=1699254317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=io4VG3Xaguyy/NUHHpH1/fGIqkb9pV5hP+VZm3QqIKE=;
  b=M+5XeaLwOGBOKcO/AjbVFvLhPp7hPDKNxInocWwFZVkRVhKQrvnUZedX
   sfLACicY8kt7jQ3jXeuGV53eeihWvkZ2+Xmadjqz/V7y1ePdlZvYncP7q
   t6XOiNRRR3vTTeaYo275AYwClcIv6gYCivHLOq1ndwNNBGXyKzDYYWl6I
   MhmaoPXi18v/DDJHWwfM54Qgvq87AHyMV3AG9DHfdzhQZx1xCMDBJAYBE
   LzfdkkT0686YkczqOE5IwqgV9sU8vqjhkxYfoEcyIuu68NM02ch0Q0A7T
   G7KCYD28hNbqgVlyWBvM40+lqIBN3FZ/98ZlyvVF0kAHvEIFRZs8rhkmU
   w==;
X-IronPort-AV: E=Sophos;i="5.96,142,1665417600"; 
   d="scan'208";a="220743061"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2022 15:05:16 +0800
IronPort-SDR: 13CiDrZGHJphpGUck4JwqUoJp2rMHqySSMrZuymHMvX3Y3LepRQSR+l8WoIH469n8Joer/bstT
 3lSWqq4kU7IFYdwEDCknNlgOak/oqo2H3EPOFEtt5kV04VEV4ie0nTlcZQwgh7C2SjPFXvDeXu
 QLqrq3MnJ8WwrOJw431ZbehFBfvNVo9pGKqiGWlNJBYQuMaFDTK4K0aQ4MeDYwiB6ceGP8tkH2
 R5F5Po22OOLuPX6G1MTu53dSANQRWNaZkKqiQ/2XtgkjUNMJ78nPv8tvSdoyif72pjCCMarT+o
 jsY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Nov 2022 23:18:40 -0700
IronPort-SDR: UtJrTtrpuVwlm6pinhPZlbg5SPc2ifXCCUEG4KVLzW3Ld+csMH6IE3Owg1IyMG+YvR6qi/dhL0
 uMzUmx1Rg9hqgkBYSg7spGmVKQ6NzER9swLNwFj2CO3BKc/yVlBarvrUdE76D03BtYq3Zf6xYm
 1AVSDywCrLSIBkxgIEoflCXeyCwJyJYJFpgdrMbDOM+klg5ulxpUP7pPJQEi5ZQgMHIgv3dQiK
 XMzaa/7H6Tmmvk6HglYcCdqN7Mo+OVjeXwjZEMH/M/Wduxv5RNgf+JINY6w5OEOaV7q6SMwkXH
 fRw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 00:05:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N4lk33k3Cz1RvTr
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 00:05:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667718315; x=1670310316; bh=io4VG3Xaguyy/NUHHpH1/fGIqkb9pV5hP+V
        Zm3QqIKE=; b=pRxT6TLgZGVEuHopTwceyzG/YuNkIZ0ku0CcjscrlB/8zkPnqKM
        cP8aBVGH1PvlsNv9llCHEZvs6URJFyj0mTgdAYByOX7fkLN1nR4XgSOQrlI0zAo4
        +fw5kAt3ojdFY9f8uahF3rVuZw9TYpYm6Z4LRSLwLzSpDzrx7Y62JApD9KTL8tju
        mMe72IRtyl+IYkz0IvCRwvcyhS8TYFfWehz5PJVJ0LRhfcBCyrKsYuwkxKC2BwQJ
        vmYxNPcwLk0WColALrEeCqBfSYzr28K3pYu+790RCFbyBoFR6FWIWGbjd3/6jI1h
        DcMkKR5ydCgJb2GXS11zctV9BDhLKm3FWZA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C0N3jMiFRfb1 for <linux-ide@vger.kernel.org>;
        Sun,  6 Nov 2022 00:05:15 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N4lk24mgpz1RvLy;
        Sun,  6 Nov 2022 00:05:14 -0700 (PDT)
Message-ID: <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
Date:   Sun, 6 Nov 2022 16:05:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     Dinu Marius <marius@psihoexpert.ro>
Cc:     linux-ide@vger.kernel.org
References: <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/2/22 04:21, Dinu Marius wrote:
> Hello.
> 
> I'm contacting you because your email is listed in www.kernel.org/doc/linux/MAINTAINERS
> I encountered a problem with the ahci-mvebu driver. I think it's a bug.
> 
> Hardware:
> Areca ARC-5040 RAID enclosure (DAS), eSATA port, 8 SATA drive bays with 1x 500GB HDD stand-alone and 7x 2TB HDDs in RAID5.
> Linksys WRT-1900ACS v2 router, Marvell Armada 385 (88F6820), one eSATAp using ahci-mvebu driver with port-multiplier support.
> The router runs OpenWrt with kernel version 5.15.

Can you try current mainline 6.1-rc kernel ? Not going to debug 5.15.
Debugging should be done on the latest kernel and any bug fix backported.

> 
> Problem encountered:
> Areca DAS is not detected properly. When I connect it, I get these repeating errors in kernel log:
> 
> [--- from boot log ---]
> <4>[    1.490840] ahci-mvebu f10a8000.sata: supply ahci not found, using dummy regulator
> <4>[    1.498512] ahci-mvebu f10a8000.sata: supply phy not found, using dummy regulator
> <4>[    1.506053] ahci-mvebu f10a8000.sata: supply target not found, using dummy regulator
> <6>[    1.513896] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl platform mode
> <6>[    1.522994] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs
> <6>[    1.532212] scsi host0: ahci-mvebu
> <6>[    1.535848] scsi host1: ahci-mvebu
> <6>[    1.539353] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x100 irq 49
> <6>[    1.547313] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x180 irq 49
> 
> [--- Areca connected ---]
> <6>[  742.795979] ata2: SATA link down (SStatus 100 SControl 300)
> <3>[  745.465974] ata2: COMRESET failed (errno=-32)
> <4>[  745.470361] ata2: reset failed (errno=-32), retrying in 8 secs
> <3>[  755.365973] ata2: COMRESET failed (errno=-32)
> <4>[  755.370361] ata2: reset failed (errno=-32), retrying in 8 secs
> <6>[  764.655979] ata2: SATA link down (SStatus 100 SControl 300)
> <6>[  766.045984] ata2: SATA link down (SStatus 101 SControl 300)
> <6>[  767.576004] ata2: SATA link down (SStatus 100 SControl 300)
> <6>[  768.325978] ata2: SATA link down (SStatus 100 SControl 300)
> <3>[  770.865973] ata2: COMRESET failed (errno=-32)
> <4>[  770.870360] ata2: reset failed (errno=-32), retrying in 8 secs
> <6>[  779.515985] ata2: SATA link down (SStatus 101 SControl 300)
> <6>[  780.275979] ata2: SATA link down (SStatus 100 SControl 300)
> 
> The same errors appear if I leave it connected during reboot.
> I tried to limit SATA speed to 150 and to disable NCQ from Areca admin interface. It didn't work.
> I found no way of making it work.
> 
> The same router works perfectly when I connect a laptop HDD.

You mean an external single HDD connected with an eSATA port ?

> The same DAS, including the same eSATA cable, works perfectly when connected to an older 
> Linksys WRT-1900AC v1 with Marvell Armada XP (MV78230), using sata-mv driver. 

What kernel version is running on that older Linksys box ?

> This is the kernel log from the older router:
> 
> [--- from boot log ---]
> <7>[    1.612541] sata_mv f10a0000.sata: version 1.28
> <6>[    1.612652] sata_mv f10a0000.sata: slots 32 ports 1
> <6>[    1.618121] scsi host0: sata_mv
> <6>[    1.621486] ata1: SATA max UDMA/133 irq 36
> 
> [--- Areca connected ---]
> <6>[88761.966331] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
> <6>[88761.975472] ata1.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 ports, feat 0xf/0x1f

This one seems OK with the PHY detection and it links up. Let me know the
kernel version and we can see what changed between the older kernel and
5.15. But you should still try latest 6.1-rc if possible.

> <6>[88764.670933] ata1.00: ATA-6: WDC WD50ARC-5040-VOL#01, 0100 AX, max UDMA/133
> <6>[88764.677860] ata1.00: 976773168 sectors, multi 0: LBA48
> <6>[88764.683599] ata1.00: configured for UDMA/133
> <6>[88764.688391] ata1.01: ATA-6: Areca   Archive, 0100 AX, max UDMA/133
> <6>[88764.694596] ata1.01: 23437498368 sectors, multi 0: LBA48
> <6>[88764.700779] ata1.01: configured for UDMA/133
> <5>[88764.705557] scsi 0:0:0:0: Direct-Access     ATA      WDC WD50ARC-5040 n/a PQ: 0 ANSI: 5
> <5>[88764.714802] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
> <5>[88764.722521] sd 0:0:0:0: [sda] Write Protect is off
> <7>[88764.727558] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> <5>[88764.727915] scsi 0:1:0:0: Direct-Access     ATA      Areca   Archive  n/a PQ: 0 ANSI: 5
> <5>[88764.728706] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> <5>[88764.745574] sd 0:1:0:0: [sdb] 23437498368 512-byte logical blocks: (12.0 TB/10.9 TiB)
> <5>[88764.753819] sd 0:1:0:0: [sdb] Write Protect is off
> <7>[88764.758886] sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
> <5>[88764.759101] sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> <5>[88764.760537] sd 0:0:0:0: [sda] Attached SCSI disk
> <5>[88764.772600] sd 0:1:0:0: [sdb] Attached SCSI disk
> 
> I'm not currently using the new router, so it's available for tests.
> Thanks.
> Marius Dinu
> 

-- 
Damien Le Moal
Western Digital Research

