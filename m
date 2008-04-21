From: "Morrison, Tom" <tmorrison@empirix.com>
Subject: RE: sata_mv errata function
Date: Mon, 21 Apr 2008 09:20:21 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010CA88A84@EMPBEDEX.empirix.com>
References: <3908ea640804210542s4e1e8403tfec4a99816b5d148@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from empbedex1.empirix.com ([12.38.203.54]:4329 "EHLO
	empbedex1.empirix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759881AbYDUNfk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Apr 2008 09:35:40 -0400
Content-class: urn:content-classes:message
In-Reply-To: <3908ea640804210542s4e1e8403tfec4a99816b5d148@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sylver Bruneau <sylver.bruneau@googlemail.com>, linux-ide@vger.kernel.org
Cc: jeff@garzik.org

Interesting - I was just looking at this code this morning - and
comparing with the reference driver Marvell has given us - this was
one of the differences I was looking at because with this new driver
and the old reference driver we were having performance problems
due to vibrations or something that is causing the disk write
performance
to go very low (<5Mbytes/second)...

I'd be very interested what Mark has to say about this - he just 
made some update to the driver - perhaps he has updated these values...

t

-----Original Message-----
From: linux-ide-owner@vger.kernel.org
[mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Sylver Bruneau
Sent: Monday, April 21, 2008 8:43 AM
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org
Subject: sata_mv errata function

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
in Marvell patch, there is an additional fix for this case (where
nothing
seems to be done for this in sata_mv.c) :
        /* phy mode 4 register of Gen IIE devices has some restriction
*/
         if (pAdapter->sataAdapterGeneration >= MV_SATA_GEN_IIE)
        {
            phyMode4Value &= ~0x5DE3FFFC;
            phyMode4Value |= MV_BIT2;
        }

I understand that what is done in this function is not well documented,
 but as it's what is done by Marvell in their patches, do you think that
it
should be merged in sata_mv.c ?

If so, I will post a proper patch to add this !

Thanks,
Sylver Bruneau

[1] Marvell/QNAP patch for the TS-409 NAS (88f5281 based + PCIe
88SX7042 SATA controller)
      http://qnap.free.fr/kernel/stock/linux-2.6.21.1.patch
--
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
