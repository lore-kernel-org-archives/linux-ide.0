From: Tejun Heo <htejun@gmail.com>
Subject: Re: Current qc_defer implementation may lead to infinite recursion
Date: Mon, 11 Feb 2008 14:06:09 +0900
Message-ID: <47AFD7C1.7070204@gmail.com>
References: <87ir0w4rzo.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:34041 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbYBKFGP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 00:06:15 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1942290wah.23
        for <linux-ide@vger.kernel.org>; Sun, 10 Feb 2008 21:06:15 -0800 (PST)
In-Reply-To: <87ir0w4rzo.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Elias Oltmanns wrote:
> Hi Tejun,
> 
> due to your commit 31cc23b34913bc173680bdc87af79e551bf8cc0d libata now
> sets max_host_blocked and max_device_blocked to 1 for all devices it
> manages. Under certain conditions this may lead to system lockups due to
> infinite recursion as I have explained to James on the scsi list (kept
> you cc-ed). James told me that it was the business of libata to make
> sure that such a recursion cannot happen.
> 
> In my discussion with James I imprudently claimed that this was easy to
> fix in libata. However, after giving the matter some thought, I'm not at
> all sure as to what exactly should be done about it. The easy bit is
> that max_host_blocked and max_device_blocked should be left alone as
> long as the low level driver does not provide the ->qc_defer() callback.
> But even if the driver has defined this callback, ata_std_qc_defer() for
> one will not prevent this recursion on a uniprocessor, whereas things
> might work out well on an SMP system due to the lock fiddling in the
> scsi midlayer.
> 
> As a conclusion, the current implementation makes it imperative to leave
> max_host_blocked and max_device_blocked alone on a uniprocessor system.
> For SMP systems the current implementation might just be fine but even
> there it might just as well be a good idea to make the adjustment
> depending on ->qc_defer != NULL.

Hmmm... The reason why max_host_blocked and max_device_blocked are set
to 1 is to let libata re-consider status after each command completion
as blocked status can be rather complex w/ PMP.  I haven't really
followed the code yet but you're saying that blocked count of 2 should
be used for that behavior, right?

Another strange thing is that there hasn't been any such lock up /
infinite recursion report till now although ->qc_defer mechanism bas
been used widely for some time now.  Can you reproduce the problem w/o
the disk shock protection?

Thanks.

-- 
tejun
