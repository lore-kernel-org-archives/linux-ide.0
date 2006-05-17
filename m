From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
	stable kernel
Date: Wed, 17 May 2006 09:28:59 +0800
Message-ID: <1147829339.7273.97.camel@forrest26.sh.intel.com>
References: <20060512132437.GB4219@htj.dyndns.org>
	 <e4coc8$onk$1@sea.gmane.org> <4469E8CF.9030506@garzik.org>
	 <4469EC4A.30908@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60522 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751084AbWEQBj7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 21:39:59 -0400
In-Reply-To: <4469EC4A.30908@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Schierl <schierlm@gmx.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, 2006-05-16 at 17:14 +0200, Michael Schierl wrote:
> hmm. ok. Hannes' patch was the one in http://lkml.org/lkml/2006/3/6/47 ?
> 
> I never found a kernel where I could apply that one and still compile
> without errors :(
> 
> I am no C guru, so I had no success to fix this patch without even
> knowing where to apply against... (and I don't know anything about
> kernel programming or even ACHI low-level programming).
> 
> Is there a newer version available of that patch somewhere?
> 
> And - what SATA ACPI patches?
> 
> I have quite alot of patches related to sata and/or acpi (collected from
> different mailing lists) here on hard disk but don't know which ones are
> broken, outdated, etc. Most only apply on a 2.6.15 or 2.6.14-rc kernel...
> 
> If more recent patches are only available via git, I'd need some good
> GIT tutorial first...
> 
> TIA, and sorry for stealing your time,
> 
> Michael
Michael,

I ported a patch from OpenSUSE for AHCI suspend/resume. You may find the
patch at:
http://marc.theaimsgroup.com/?l=linux-ide&m=114774543416039&w=2

Jeff,
If Michael have a successful AHCI suspend/resume with this patch, I'm
glad to port the patch to current libata-dev #upstream for the second
time to push it into stock kernel. How do you think?

Thanks,
Forrest

