From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [RFC v2 3/3] ahci_platform: perform platform exit in host_stop() hook
Date: Wed, 31 Oct 2012 23:41:45 -0700
Message-ID: <CAN8TOE_RZtpnEnNuM2ZyODGGURUWDba57vVOHa0BEsh5h8wFPQ@mail.gmail.com>
References: <1351368576-5264-1-git-send-email-computersforpeace@gmail.com>
	<1351368576-5264-4-git-send-email-computersforpeace@gmail.com>
	<20121029013709.GB5171@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:32877 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab2KAGlq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Nov 2012 02:41:46 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1527812pbb.19
        for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2012 23:41:46 -0700 (PDT)
In-Reply-To: <20121029013709.GB5171@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, Kevin Cernekee <cernekee@gmail.com>

Hi Tejun,

On Sun, Oct 28, 2012 at 6:37 PM, Tejun Heo <tj@kernel.org> wrote:
> On Sat, Oct 27, 2012 at 01:09:36PM -0700, Brian Norris wrote:
>> AHCI platform devices may provide an exit() routine, via
>> ahci_platform_data, that powers off the SATA core. Such a routine should
>> be executed from the ata_port_operations host_stop() hook. That way, the
>> ATA subsystem can perform any last-minute hardware cleanup (via devres,
>> for example), then trigger the power-off at the appropriate time.
>>
>> This patch fixes bus errors triggered during module removal or device
>> unbinding, seen on an SoC SATA core.
>>
>> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>
> For all three patches,
>
>   Acked-by: Tejun Heo <tj@kernel.org>

Thanks for the help and the Acked-by. Unfortunately, I embarrassed to
say that I was basing this on an old libata-dev/NEXT branch.
Apparently I had an old github URL still (I thought there was
something fishy... I'd recommend either updating or removing the
github, FWIW):

git://github.com/jgarzik/libata-dev.git

And my test system was actually a 3.3 kernel. So, this patch doesn't
apply to the *real* libata-dev/NEXT. I will rebase and resubmit,
accounting for:

   commit f1e70c2c535923de253eea2021376a936eb8d478
   ata/ahci_platform: Add clock framework support

Incidentally, this fix is probably helpful for my SoC.

> If you have some time, it would be nice to introduce
> ata_platform_remove_one().  There's no reason to have that implemented
> separately in each driver.

OK, I think I have a pretty good set of patches. I have about 8
drivers switched over to a new ata_platform_remove_one(). Should I
submit it with my resend of this series?

>  It would also be nice to move
> remove_one()'s to some higher level port_ops so that individual
> drivers don't have to specify them explicitly.

Hmm, which port op would you recommend? host_stop()? Or a new remove_one() op?

Brian

P.S. I'm seeing some more issues in libata that I still need to dig
further into. When removing or unbinding, libata cannot stop the
driver properly (gets a "START_STOP FAILED" message from the SCSI
subsystem). The problem lies in the fact that ata_dev_disable() is
being called before sd_start_stop_device(), causing the failure. If
this rings a bell as to an obvious issue, let me know... Thanks.
