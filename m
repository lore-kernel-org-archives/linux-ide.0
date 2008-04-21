From: "Sylver Bruneau" <sylver.bruneau@googlemail.com>
Subject: sata_mv errata function
Date: Mon, 21 Apr 2008 14:42:42 +0200
Message-ID: <3908ea640804210542s4e1e8403tfec4a99816b5d148@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.178]:45800 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535AbYDUMmo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Apr 2008 08:42:44 -0400
Received: by el-out-1112.google.com with SMTP id n30so376497elf.21
        for <linux-ide@vger.kernel.org>; Mon, 21 Apr 2008 05:42:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org

Hello,
during my analysis of some recent patches [1] from Marvell for several
ARM based (88f5182 & 88f5281) NAS devices, i've found that some
errata stuff are a little bit different from what is done in sata_mv.c
 mainline code.

I don't know if there is a reason for the code not to be the same, but
I think that it could be useful to bring that to you.

Here are the facts ...
First, the fix value for phyMode 3 is a little bit different :
 while sata_mv.c is applying a
        tmp &= ~0x7F800000;
the patch from Marvell (check _fixPhyParams function in
arch/arm/mach-feroceon/Board
/SATA/CoreDriver/mvSata.c file) is applying a
        regVal &= ~0x7F900000;

The fix value for phyMode 4 is also different for GEN IIE (6042 &
7042) devices :
in Marvell patch, there is an additional fix for this case (where nothing
seems to be done for this in sata_mv.c) :
        /* phy mode 4 register of Gen IIE devices has some restriction */
         if (pAdapter->sataAdapterGeneration >= MV_SATA_GEN_IIE)
        {
            phyMode4Value &= ~0x5DE3FFFC;
            phyMode4Value |= MV_BIT2;
        }

I understand that what is done in this function is not well documented,
 but as it's what is done by Marvell in their patches, do you think that it
should be merged in sata_mv.c ?

If so, I will post a proper patch to add this !

Thanks,
Sylver Bruneau

[1] Marvell/QNAP patch for the TS-409 NAS (88f5281 based + PCIe
88SX7042 SATA controller)
      http://qnap.free.fr/kernel/stock/linux-2.6.21.1.patch
