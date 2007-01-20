From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_uli: ignore SIMPLEX
Date: Sat, 20 Jan 2007 12:41:51 +0900
Message-ID: <45B18F7F.7000900@gmail.com>
References: <20070116055551.GN10987@htj.dyndns.org> <45B15F7E.2080807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:53669 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965098AbXATDmB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Jan 2007 22:42:01 -0500
Received: by nz-out-0506.google.com with SMTP id s1so543741nze
        for <linux-ide@vger.kernel.org>; Fri, 19 Jan 2007 19:42:00 -0800 (PST)
In-Reply-To: <45B15F7E.2080807@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Some uli controllers have stuck SIMPLEX bit which can't be cleared
>> with ata_pci_clear_simplex(), but the controller is capable of doing
>> DMAs on both channels simultaneously.  Ignore it.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> This is going to be the common case going forward.  Please create an
> 'ignore simplex bit' flag, and set it in sata_uli

I'm a little bit hesitant to do that.

1. I don't think we're gonna have a lot of drivers which need this.
Just a few.  We've just found one now.

2. I think libata core layer (sff included) is burdened with too much
already.  Also, now that devres is acked, we can easily transition to
alloc - init - register model which gives LLDs much more flexibility and
this kind of stuff can easily be done in init_one()'s.  It just fits there.

But, it's your call.

Thanks.

-- 
tejun
