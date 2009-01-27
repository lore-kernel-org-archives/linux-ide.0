From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata fixes
Date: Tue, 27 Jan 2009 13:37:15 -0500
Message-ID: <497F545B.6000104@garzik.org>
References: <20090127073055.GA30360@havoc.gtf.org> <alpine.LFD.2.00.0901270748290.3123@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40936 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753812AbZA0ShY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 13:37:24 -0500
In-Reply-To: <alpine.LFD.2.00.0901270748290.3123@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Linus Torvalds wrote:
> 
> On Tue, 27 Jan 2009, Jeff Garzik wrote:
>> Please pull from 'upstream-linus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus
>>
>> to receive the following updates:
>>
>>  drivers/ata/Kconfig              |    6 ++--
>>  drivers/ata/libata-sff.c         |   12 ++++++-
>>  drivers/ata/pata_rb532_cf.c      |    2 -
>>  drivers/ata/pata_via.c           |   22 +++++++++---
>>  drivers/ata/sata_mv.c            |   56 ++++++++++++++----------------
>>  drivers/ata/sata_nv.c            |   70 +++++++++++++++++++++++--------------
>>  include/linux/pci_ids.h          |    4 ++
>>  7 files changed, 104 insertions(+), 68 deletions(-)
>>  delete mode 100644 arch/arm/mach-integrator/clock.h
> 
> Hmm. That delete of the empty file is "correct" (and probably came as a 
> result of somebody doing "make distclean" which deletes empty files), but 
> should not have been committed as part of "libata-sff: fix incorrect EH 
> message".
> 
> Seems to be a mistake, and a small one, but still.. Be more careful.

Er, oops.  Sorry about that.  Yeah, I habitually do 'make distclean' as 
part of my kclean and kbuild standard workflow scripts.

I also habitually _avoid_ "git commit -a", so I am surprised that I 
actually made this mistake.  I am 100% certain that I issued neither 
"git rm" nor "git update-index" commands on that file.

Granted, I should have been more careful, but I am also surprised this 
happened at all.

	Jeff



