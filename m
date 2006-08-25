From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [Fwd: [BUG] sata_via doesn't detect anymore my disks (broken between rc1 and rc3)]
Date: Fri, 25 Aug 2006 12:29:03 +0200
Message-ID: <m2d5aprtw0.fsf@vador.mandriva.com>
References: <44D98E7E.3060208@pobox.com> <44E29AEF.8030606@gmail.com>
	<20060816051408.GI6371@htj.dyndns.org>
	<m2wt98bio1.fsf@vador.mandriva.com> <m2sljwbil7.fsf@vador.mandriva.com>
	<44E37BD4.8010709@pobox.com> <m23bbva9cs.fsf@vador.mandriva.com>
	<44E46E0E.4060703@gmail.com> <m2fyfv7a8s.fsf@vador.mandriva.com>
	<44EB32AD.1080305@gmail.com> <m2fyfnciky.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:9489 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP id S932408AbWHYK3F
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Aug 2006 06:29:05 -0400
In-Reply-To: <m2fyfnciky.fsf@vador.mandriva.com> (Thierry Vignaud's message of "Wed, 23 Aug 2006 22:17:49 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Thierry Vignaud <tvignaud@mandriva.com> writes:

> > Can you please test two patches attached in this mail?  Just quick
> > result will be enough.  If both don't work, I'll go ahead and
> > create a third one - which emulates the old phy hardreset exactly
> > as I did for softreset of vt6420.
> 
> I'll.
> 
> As, I've tested that using:
> - ata_std_prereset + ata_std_softreset didn't work
> - vt6420_prereset + ata_std_softreset worked
> - vt6420_prereset w/o ata_std_softreset didn't work
> 
> I simple interdiff between your two patches makes me think the odds're
> higher the second will succeed but you've done some extra changes
> since your previous patch.
> I'll you tell you more about this tomorrow.

none of both these patches worked :-(
