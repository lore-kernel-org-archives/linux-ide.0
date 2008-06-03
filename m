From: "Peer Chen" <pchen@nvidia.com>
Subject: RE: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Tue, 3 Jun 2008 15:56:35 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B2AA19253@hkemmail01.nvidia.com>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <200805291654.03617.volker.armin.hemmann@tu-clausthal.de> <483F804F.1@gmail.com> <200805301243.39751.volker.armin.hemmann@tu-clausthal.de> <4840A085.2080101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.112.152]:14005 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbYFCICH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jun 2008 04:02:07 -0400
In-Reply-To: <4840A085.2080101@gmail.com>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

I think it did support NCQ function, our windows driver doesn't check
that capability bit, so it can issue FP-DMA command no matter that bit
being set or not.
For the MSI issue, I suggest just disable the MSI for MCP65 ahci
controller, it should be hardware bug. More specifically, you can
disable the MSI if the MCP65 ahci controller's revision ID is 0xa1 or
0xa2.
What's 64bit problem?

BRs
Peer Chen
 

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] 
> Sent: Saturday, May 31, 2008 8:49 AM
> To: Hemmann, Volker Armin
> Cc: Peer Chen; Jeff Garzik; linux-kernel@vger.kernel.org; 
> linux-ide@vger.kernel.org; Kuan Luo
> Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not 
> with 2.6.24.3
> 
> Hemmann, Volker Armin wrote:
> > On Freitag, 30. Mai 2008, Tejun Heo wrote:
> >> Hello,
> >>
> >> Hemmann, Volker Armin wrote:
> >>> -AHCI+nomsi: boots fine. Works fine. But: I still can not 
> enable ncq
> >>> -AHCI+msi: the usual. No harddisks found, waiting for the 
> timeouts, 
> >>> -AHCI+then
> >>> kernel panic because of missing root.
> >>>
> >>> -NON-RAID/IDE+msi: works fine. No delays. No NCQ (not surprising 
> >>> since mobos handbook says that AHCI mode is required).
> >>> -NON-RAID/IDE+nomsi: see above.
> >> So, sans NCQ, the only remaining issue is MSI, right?  Peer Chen, 
> >> please lemme know which controllers are affected by this 
> MSI problem 
> >> and where the problem lies.
> > 
> > this is correct.
> > 
> >> The controller is not reporting NCQ capability in its cap register
> >> (flags: line contains ncq if the controller is), so NCQ is 
> not enabled.
> > 
> > ah, I thought all AHCI chipsets support NCQ (and the 
> board's handbook 
> > lists it as feature) thanks for the explanation.
> 
> It could be that the controller has ahci support but it just 
> forgets to set the corresponding cap bit.  Peer Chen, Kuan 
> Luo, can you guys please comment on the 64bit and ncq problems?
> 
> Thanks.
> 
> --
> tejun
> 
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
