From: Tejun Heo <tj@kernel.org>
Subject: Re: ich10r ahci with port multiplier or native detaches disks
Date: Tue, 09 Sep 2008 13:44:27 +0200
Message-ID: <48C6619B.4020302@kernel.org>
References: <alpine.DEB.1.10.0809081638330.31178@kurp.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49637 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170AbYIILqO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Sep 2008 07:46:14 -0400
In-Reply-To: <alpine.DEB.1.10.0809081638330.31178@kurp.hut.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Wagner <jwagner@kurp.hut.fi>
Cc: linux-ide@vger.kernel.org

Jan Wagner wrote:
> First the minor(?) issue, the ICH10(R) datasheet
>   http://www.intel.com/Assets/PDF/datasheet/319973.pdf
> says on page 527, PMS flag: port multipliers are not supported. The
> PMFSE flag page 542 says neither port multipliers nor FIS pmp are
> supported.

ICH10R works fine with PMP in command-switching mode.  FIS based
switching is not supported and I agree the doc is somewhat confusing.

> On our ASUS P5Q Pro motherboard with ICH10R, ahci detects 'pmp':
> 
> ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA
> mode
> ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum
> part ems
> 
> In light of the datasheet, perhaps in ahci.c the CAP register (read-only
> from host) 'pmp' flag should be actively reset to 0 for ich10r?
> 
> Ayway the bigger issue with ICH10R is that the SATA disks detach
> randomly during "heavy" i/o load. This happens withing just a few
> seconds. If I disable NCQ (echo 1 > nr_requests), it takes "longer" to
> happen, some ten seconds. I already ruled out the SATA cables, disks
> themselves, and disk cages as a cause.
> 
> The detaching happens at least in these (Ubuntu-patched) kernels:
> 
> $ uname -rm
> 2.6.27-2-generic i686
> 
> $ uname -rm
> 2.6.24-19-generic i686
> 
> It happens with disks behind a port multiplier. The ich10r 'pmp'
> "support" seems to work as CB- but not FIS-based, so it is slow, or just
> broken.
> 
> But the detaches also happen with disks connected to the native ich10r
> ports.
> 
> All in all ich10r seems to work very unreliably. So I was wondering if
> support for ICH10R in ahci.c is not complete yet?
> 
> 
> Or can someone here shout "ich10r ahci works for me"?

ICH10 works fine w/ or w/o PMP.  Can you please post full kernel log
including boot messages and error messages?

Thanks.

-- 
tejun
