From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] [PATCHSET] new Power Management for libata, take 2
Date: Mon, 26 Jun 2006 15:58:31 +0900
Message-ID: <449F8597.7090605@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com> <1151304179.7132.169.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:51137 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751190AbWFZG6Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 02:58:16 -0400
Received: by py-out-1112.google.com with SMTP id z59so1327109pyg
        for <linux-ide@vger.kernel.org>; Sun, 25 Jun 2006 23:58:15 -0700 (PDT)
In-Reply-To: <1151304179.7132.169.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Sat, 2006-06-24 at 20:30 +0900, Tejun Heo wrote:
>> Hello, all.
>>
>> This is the second take of new-power-management patchset.  Changes
>> from the last take[1] are...
>>
>> * Per-dev PM is now supported.  Now generic device PM layer drives
>>   whole PM sequence and libata port-wide PM does much less.
>>
> 
> Hello, Tejun
> 
> It seems that port-level PM callbacks are removed in this patch set :(
> So if the author of other types of SATA controllers need to do port-
> level PM operations, they need to first add the callbacks by themselves,
> right?

Right.

> Does it make sense to add port-wide PM callbacks in this patch set?

Yes, it does.  I removed those because none of the currently converted 
drivers used it.  Does AHCI need them?  If so, I'll add them.  Are you 
gonna do ACPI stuff w/ those callbacks?

-- 
tejun
