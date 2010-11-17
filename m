From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: AMD 890GX vs 6Gbps SATA?
Date: Wed, 17 Nov 2010 10:48:47 +0800
Message-ID: <1E8B869C0C6913418421A406C094DF7C82DDA2@sshaexmb1.amd.com>
References: <2DEEA3AB13739D45A22ADDB5086AEA0B915107@sshaexmb1.amd.com><1E8B869C0C6913418421A406C094DF7C82D812@sshaexmb1.amd.com><m339r2lf9b.fsf@jhcloos.com><1E8B869C0C6913418421A406C094DF7C82D954@sshaexmb1.amd.com> <m3r5emjyv1.fsf@jhcloos.com> <1E8B869C0C6913418421A406C094DF7C82DC6C@sshaexmb1.amd.com> <4CE32250.8050401@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:52566 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757446Ab0KQCtG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Nov 2010 21:49:06 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <4CE32250.8050401@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stan Hoeppner <stan@hardwarefreak.com>, James Cloos <cloos@jhcloos.com>
Cc: linux-ide@vger.kernel.org, "Xu, Andiry" <Andiry.Xu@amd.com>, "Petkov, Borislav" <Borislav.Petkov@amd.com>, "Huang, Shane" <Shane.Huang@amd.com>

James & Stan,


> > Since your CAP.ISS is set to 0010(3Gbps), most likely you'll
> > have to ask your BIOS vendor to enable 6Gbps in one release.
> > Some BIOS vendors may set the max speed to Gen2 to save power.
> 
> Unless you have a PMP on the other end of that SATA link with a bunch
> of
> striped drives, or an expensive SSD, you won't notice a performance
> difference between 3 Gb/s and 6 Gb/s link speed anyway:  no single
mech
> drive on the planet can come close to pushing 300 MB/s let alone 600.
> The fastest 15k SAS drives are peaking at around 200 MB/s IIRC.  And
> there are few [affordable] SSDs that will saturate a SATA II link, let
> alone a SATA III link.
> 
> My advice, FWIW, is to simply ignore this, unless you plan on
attaching
> a device in the near future that can actually exceed 300 MB/s.
> Currently the only way to do this is with striped mech drives on a
PMP,
> or with a $500+ SSD.

There is one RW bit in SB800 which makes SATA controller operate
in maximum Gen2 (3.0Gbps), this bit will limit CAP.ISS(RO) to
0010(3Gbps).

Some BIOS vendors may enable this bit "to save more power"(from spec,
driver needs not touch it). That's why I suggested James contact BIOS
vendor if you do want to get the 6Gbps dmesg.



Thanks,
Shane


