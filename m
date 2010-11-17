From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: AMD 890GX vs 6Gbps SATA?
Date: Tue, 16 Nov 2010 18:38:29 -0600
Message-ID: <4CE32405.7010604@hardwarefreak.com>
References: <2DEEA3AB13739D45A22ADDB5086AEA0B915107@sshaexmb1.amd.com><1E8B869C0C6913418421A406C094DF7C82D812@sshaexmb1.amd.com><m339r2lf9b.fsf@jhcloos.com><1E8B869C0C6913418421A406C094DF7C82D954@sshaexmb1.amd.com> <m3r5emjyv1.fsf@jhcloos.com> <1E8B869C0C6913418421A406C094DF7C82DC6C@sshaexmb1.amd.com> <4CE32250.8050401@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:49138 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563Ab0KQAia (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Nov 2010 19:38:30 -0500
In-Reply-To: <4CE32250.8050401@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: James Cloos <cloos@jhcloos.com>, linux-ide@vger.kernel.org, "Xu, Andiry" <Andiry.Xu@amd.com>, "Petkov, Borislav" <Borislav.Petkov@amd.com>

Stan Hoeppner put forth on 11/16/2010 6:31 PM:

> Currently the only way to do this is with striped mech drives on a PMP,
> or with a $500+ SSD.

Let me correct that slightly.  There are also host (OS) independent
external RAID enclosures on the market with a real embedded RAID
controller, and host connection via single or multiple lane eSATA.  If
using a single 3 Gb/s eSATA link with such an enclosure, with enough
disks, you could easily saturate a 3 Gb/s link.  Some of these may even
saturate a single 6 Gb/s link depending on drive count and quality of
the RAID controller.

-- 
Stan
