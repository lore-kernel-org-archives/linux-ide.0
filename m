From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] [PATCHSET] new Power Management for libata, take 2
Date: Mon, 26 Jun 2006 16:11:37 +0900
Message-ID: <449F88A9.30109@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>	 <1151304179.7132.169.camel@forrest26.sh.intel.com>	 <449F8597.7090605@gmail.com> <1151304561.7132.173.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.206]:41572 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932386AbWFZHLX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 03:11:23 -0400
Received: by nz-out-0102.google.com with SMTP id z31so1264399nzd
        for <linux-ide@vger.kernel.org>; Mon, 26 Jun 2006 00:11:22 -0700 (PDT)
In-Reply-To: <1151304561.7132.173.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Mon, 2006-06-26 at 15:58 +0900, Tejun Heo wrote:
> 
>>> Does it make sense to add port-wide PM callbacks in this patch set?
>> Yes, it does.  I removed those because none of the currently converted 
>> drivers used it.  Does AHCI need them?  If so, I'll add them.  Are you 
>> gonna do ACPI stuff w/ those callbacks?
>>
> 
> Yeap, both AHCI suspend/resume patch and ACPI-SATA patch need these
> port-wide callbacks.
> It's appreciated if you could add them in your PM patch :)

Will do after this whole thing get reviewed.  I don't know much about 
ACPI but don't we need to do it regardless of LLDs?  If so, I think it 
might be better to hook those directly into ata_eh_suspend/resume(). 
Other than ACPI, what do you want to do in per-port callbacks for AHCI?

-- 
tejun
