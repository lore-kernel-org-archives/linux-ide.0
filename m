From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: AMD 890GX vs 6Gbps SATA?
Date: Tue, 16 Nov 2010 18:04:29 +0800
Message-ID: <1E8B869C0C6913418421A406C094DF7C82DC6C@sshaexmb1.amd.com>
References: <2DEEA3AB13739D45A22ADDB5086AEA0B915107@sshaexmb1.amd.com><1E8B869C0C6913418421A406C094DF7C82D812@sshaexmb1.amd.com><m339r2lf9b.fsf@jhcloos.com><1E8B869C0C6913418421A406C094DF7C82D954@sshaexmb1.amd.com> <m3r5emjyv1.fsf@jhcloos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:16622
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932489Ab0KPKEp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Nov 2010 05:04:45 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <m3r5emjyv1.fsf@jhcloos.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Cloos <cloos@jhcloos.com>
Cc: linux-ide@vger.kernel.org, "Xu, Andiry" <Andiry.Xu@amd.com>, "Petkov, Borislav" <Borislav.Petkov@amd.com>, "Huang, Shane" <Shane.Huang@amd.com>

Hi James,

> As I at least implied in the original post, while the 640 is only a
> 3 Gbps drive, WDC says the WD1002FAEX is a 6 Gbps.
> 
> (And, before anyone asks, no jumpers -- such as the one which limits
> it to 3 Gbps -- are installed.)

Your south bridge chip is SB800 which should support SATA 6Gbps.

Quoting your dmesg:
> ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 3 Gbps
> 0x3f impl SATA mode

Quoting AHCI spec, HBA CAP.ISS(RO):
> Interface Speed Support (ISS): Indicates the maximum speed
> the HBA can support on its ports. These encodings match the
> system software programmable PxSCTL.DET.SPD field. Values are:
> Bits Definition
> 0000 Reserved
> 0001 Gen 1 (1.5 Gbps)
> 0010 Gen 2 (3 Gbps)
> 0011 Gen 3 (6 Gbps)
> 0100 - 1111 Reserved

Since your CAP.ISS is set to 0010(3Gbps), most likely you'll
have to ask your BIOS vendor to enable 6Gbps in one release.
Some BIOS vendors may set the max speed to Gen2 to save power.


Thanks,
Shane


