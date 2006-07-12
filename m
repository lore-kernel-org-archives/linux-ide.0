From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/6] AHCI suspend/resume support --take4
Date: Wed, 12 Jul 2006 13:42:54 -0400
Message-ID: <44B5349E.3070802@pobox.com>
References: <1152599802.7132.290.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:16595 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750827AbWGLRnB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jul 2006 13:43:01 -0400
In-Reply-To: <1152599802.7132.290.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: htejun@gmail.com, hare@suse.de, axboe@suse.de, linux-ide@vger.kernel.org

zhao, forrest wrote:
> Hi, all
> 
> This is resend of the take 4 of AHCI suspend/resume patches.
> The patch is against libata #upstream.
> 
> Compared with last version, all the changes are in [PATCH 6/6]. In
> particular, I made changes to the sixth patch to integrate it with
> Tejun's PM patch.

My current, still-pending request for these patches:

Please split up the patches such that each individual patch -- when 
applied in succession, creates a compilable, usable driver.  Patch #1 
must producing a working driver.  Patches #1-2 must produce a working 
driver.  Patches #1-3 must produce a working driver.  Patches #2-3 
(without patch #1) need not apply, much less produce a working driver.

As I described in an earlier email, patches are like mathematical 
proofs:  each step must produce a "complete equation."

For example, patch #1 in this series looks OK -- if only the existing 
users of ahci_stop_engine() and ahci_start_engine() to work.

As another example, the ACPI patches need to be split up into logical 
chunks, probably just two patches:

	1) Add support necessary to utilize _SDD, _GTF (SATA)
	2) Add support necessary to utilize _GTM, _STM (PATA)

or perhaps three patches:

	1) _GTF support, basic ACPI support
	2) SATA support (_SDD, other SATA details)
	3) PATA support (_GTM, _STM, other PATA details)

Overall, your code changes are looking good, but are not split up in a 
usable manner.

Regards,

	Jeff


