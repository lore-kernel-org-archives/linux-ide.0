From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
Date: Thu, 18 May 2006 11:27:38 -0400
Message-ID: <446C926A.7020404@garzik.org>
References: <20060512132437.GB4219@htj.dyndns.org>	 <e4coc8$onk$1@sea.gmane.org> <4469E8CF.9030506@garzik.org>	 <4469EC4A.30908@gmx.de> <1147829339.7273.97.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:62850 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932066AbWERP1o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 May 2006 11:27:44 -0400
In-Reply-To: <1147829339.7273.97.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Michael Schierl <schierlm@gmx.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Tue, 2006-05-16 at 17:14 +0200, Michael Schierl wrote:
>> hmm. ok. Hannes' patch was the one in http://lkml.org/lkml/2006/3/6/47 ?
>>
>> I never found a kernel where I could apply that one and still compile
>> without errors :(
>>
>> I am no C guru, so I had no success to fix this patch without even
>> knowing where to apply against... (and I don't know anything about
>> kernel programming or even ACHI low-level programming).
>>
>> Is there a newer version available of that patch somewhere?
>>
>> And - what SATA ACPI patches?
>>
>> I have quite alot of patches related to sata and/or acpi (collected from
>> different mailing lists) here on hard disk but don't know which ones are
>> broken, outdated, etc. Most only apply on a 2.6.15 or 2.6.14-rc kernel...
>>
>> If more recent patches are only available via git, I'd need some good
>> GIT tutorial first...
>>
>> TIA, and sorry for stealing your time,
>>
>> Michael
> Michael,
> 
> I ported a patch from OpenSUSE for AHCI suspend/resume. You may find the
> patch at:
> http://marc.theaimsgroup.com/?l=linux-ide&m=114774543416039&w=2
> 
> Jeff,
> If Michael have a successful AHCI suspend/resume with this patch, I'm
> glad to port the patch to current libata-dev #upstream for the second
> time to push it into stock kernel. How do you think?

All reasonable patches accepted...

	Jeff



