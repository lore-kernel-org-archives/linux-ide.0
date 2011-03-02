From: Kushal Koolwal <kushalkoolwal@gmail.com>
Subject: Re: libata: ATA exception error messages in pata_sch module (CONFIG_PATA_SCH)
Date: Tue, 1 Mar 2011 23:29:23 -0800
Message-ID: <AANLkTinSk76q+PhiHqOdF2gCL1+ApK+oJzSG85TTVPm-@mail.gmail.com>
References: <AANLkTikD3NOA7=zOLRaft8TL=sTgPSCHNNKgTP3AfYWD@mail.gmail.com>
	<4D6D9684.505@gmail.com>
	<AANLkTikpg2d47rAO=FatTe-53Ju4u+YBXt8VKmani8TN@mail.gmail.com>
	<AANLkTimyVVZA3-pKyKUTyqTENRi1w2DXHcmAyg-J_8ok@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59012 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1CBH3Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2011 02:29:24 -0500
Received: by iyb26 with SMTP id 26so4664334iyb.19
        for <linux-ide@vger.kernel.org>; Tue, 01 Mar 2011 23:29:24 -0800 (PST)
In-Reply-To: <AANLkTimyVVZA3-pKyKUTyqTENRi1w2DXHcmAyg-J_8ok@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Borislav Petkov <petkovbb@gmail.com>, linux-ide@vger.kernel.org

I really appreciate your time on this so far.

>So there might not actually be a way to do it on this controller.
Initially I thought the same but when I checked the dmesg log of a
boot with only Hard drive present it seems that Linux is able to
detect that the system has 40 conductor cable:

[    1.932419] ata1.00: HPA detected: current 312579695, native 312581808
[    1.932522] ata1.00: ATA-7: WDC WD1600AAJB-00PVA0, 00.07H00, max UDMA/100
[    1.932615] ata1.00: 312579695 sectors, multi 0: LBA48
[    1.932707] ata1.00: limited to UDMA/33 due to 40-wire cable
[    1.940436] ata1.00: configured for UDMA/33
[    1.940774] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600AAJB-

So I guess now the question becomes why having an IDE CD-ROM causes
the Linux kernel to fail to detect the type of cable (40 wire) and
hence those exception messages.

Attached is the full dmesg log of a boot with only hard drive present.

Kushal
