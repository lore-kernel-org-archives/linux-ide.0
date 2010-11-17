From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: AMD 890GX vs 6Gbps SATA?
Date: Tue, 16 Nov 2010 18:31:12 -0600
Message-ID: <4CE32250.8050401@hardwarefreak.com>
References: <2DEEA3AB13739D45A22ADDB5086AEA0B915107@sshaexmb1.amd.com><1E8B869C0C6913418421A406C094DF7C82D812@sshaexmb1.amd.com><m339r2lf9b.fsf@jhcloos.com><1E8B869C0C6913418421A406C094DF7C82D954@sshaexmb1.amd.com> <m3r5emjyv1.fsf@jhcloos.com> <1E8B869C0C6913418421A406C094DF7C82DC6C@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:49937 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498Ab0KQAbO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Nov 2010 19:31:14 -0500
In-Reply-To: <1E8B869C0C6913418421A406C094DF7C82DC6C@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: James Cloos <cloos@jhcloos.com>, linux-ide@vger.kernel.org, "Xu, Andiry" <Andiry.Xu@amd.com>, "Petkov, Borislav" <Borislav.Petkov@amd.com>

Huang, Shane put forth on 11/16/2010 4:04 AM:

> Since your CAP.ISS is set to 0010(3Gbps), most likely you'll
> have to ask your BIOS vendor to enable 6Gbps in one release.
> Some BIOS vendors may set the max speed to Gen2 to save power.

Unless you have a PMP on the other end of that SATA link with a bunch of
striped drives, or an expensive SSD, you won't notice a performance
difference between 3 Gb/s and 6 Gb/s link speed anyway:  no single mech
drive on the planet can come close to pushing 300 MB/s let alone 600.
The fastest 15k SAS drives are peaking at around 200 MB/s IIRC.  And
there are few [affordable] SSDs that will saturate a SATA II link, let
alone a SATA III link.

My advice, FWIW, is to simply ignore this, unless you plan on attaching
a device in the near future that can actually exceed 300 MB/s.
Currently the only way to do this is with striped mech drives on a PMP,
or with a $500+ SSD.

-- 
Stan
