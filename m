From: "Carlos Pardo" <Carlos.Pardo@siliconimage.com>
Subject: RE: regarding sata_sil errata
Date: Wed, 1 Mar 2006 09:58:45 -0800
Message-ID: <2E9B8131C44AF746B1E06BF9B15A434B045D817B@mail.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from siimage.com ([12.24.47.101]:64190 "EHLO mail.siimage.com")
	by vger.kernel.org with ESMTP id S1030220AbWCAR5h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Mar 2006 12:57:37 -0500
Content-Class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

0x1002/0x436e, 0x1002/0x4379 and 0x1002/0x437a are 3112 (vendor is ATI). So the blacklist still applies. 0x240 is bogus. We do not have that product ID.

C-

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Tuesday, February 28, 2006 9:26 PM
To: Carlos Pardo; Raymond Liu; Jeff Garzik
Cc: linux-ide@vger.kernel.org
Subject: regarding sata_sil errata

Hello, all.

Now that we have R_ERR on DMA activate FIS errata workaround in place,
sata_sil driver seems to work much better now.  There are two things
to do regarding sata_sil errata.

1. removing non-affected drives from m15w blacklist.  I think we
   should test this in -mm for some time before submitting to
   upstream.  Will submit a patch soon.

2. determining which are 3112 and which are 3512.

   Carlos and Raymond, can you guys please let us know which are 3112
   and which are 3512?  The PCI IDs in question are 0x1095/0x0240,
   0x1002/0x436e, 0x1002/0x4379 and 0x1002/0x437a.  All these IDs are
   currently treated as 3112 but it's a shame to apply m15w when a
   controller can work happily with R_ERR on DMA activate FIS errata,
   isn't it?

Thanks.  :-)

-- 
tejun
