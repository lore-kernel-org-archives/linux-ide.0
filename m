From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] [PATCHSET] new Power Management for libata, take 2
Date: Mon, 26 Jun 2006 17:17:54 +0900
Message-ID: <449F9832.7050107@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>	 <1151304179.7132.169.camel@forrest26.sh.intel.com>	 <449F8597.7090605@gmail.com>	 <1151304561.7132.173.camel@forrest26.sh.intel.com>	 <449F88A9.30109@gmail.com> <1151305792.7132.184.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:14699 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964867AbWFZIR5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 04:17:57 -0400
Received: by py-out-1112.google.com with SMTP id t32so1374314pyc
        for <linux-ide@vger.kernel.org>; Mon, 26 Jun 2006 01:17:56 -0700 (PDT)
In-Reply-To: <1151305792.7132.184.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Mon, 2006-06-26 at 16:11 +0900, Tejun Heo wrote:
>> Will do after this whole thing get reviewed.  I don't know much about 
>> ACPI but don't we need to do it regardless of LLDs?  If so, I think it 
>> might be better to hook those directly into ata_eh_suspend/resume(). 
> 
> in ata_eh_suspend/resume(), all operations are device-level. We need a
> port-level function inside ata_eh_suspend/resume(), and inside this
> port-level function both generic port-level operations and LLD specific
> port-level callbacks are called.

Then, please create a separate hook.  It can be just side by side w/ 
ops->suspend/resume() calls but I think they need to be called 
separately from LLD-specific PM ops.

-- 
tejun
