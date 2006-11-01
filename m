From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] prep for PMP support, take 3
Date: Wed, 01 Nov 2006 13:25:17 +0900
Message-ID: <454821AD.5060909@gmail.com>
References: <11609542672061-git-send-email-htejun@gmail.com> <454804CB.9030805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:16750 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423948AbWKAEZ1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Oct 2006 23:25:27 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1639265ugm
        for <linux-ide@vger.kernel.org>; Tue, 31 Oct 2006 20:25:25 -0800 (PST)
In-Reply-To: <454804CB.9030805@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Weak ACK for the patchset:
> 
> SET FEATURES - XFER MODE also needs to use the defer capability.

We need to reconfigure the controller and revalidate devices after XFER 
MODE, so simple command exclusion isn't enough for XFER MODE.  I think 
we need EH level synchronization.  e.g. Something like the following.

* Controller has two ports portA and portB.  It needs host-wide 
exclusion for XFER_MODE and the associated controller reprogramming.

1. User (or whatever) issues XFER MODE for portA.

2. portA EH is invoked for XFER MODE. (local exclusion automatically 
achieved)

3. portA EH asks portB EH to participate in host-wide exclusion.

4. portB EH is invoked and waits for port A EH to complete.

5. portA EH now has host-wide exclusion.  Do XFER MODE, reprogram 
controller and revalidate.

6. portA EH tells portB EH that it's free to go and portA resumes.

7. portB resumes.

> And we also have such a need for simplex devices.  It would be useful
> to have all of this stuff collected into an "ATA command scheduling /
>  sequencing" area, rather than just a new hook confined to a single
> area. I think the problem space is more complex than that.

For simplex controllers, I dunno.  The current code depends on SCSI 
midlayer for command queue management and, as each ATA port is 
represented as separate SCSI host, it's difficult to implement 
cross-host exclusion properly.  Also, are simplex controllers big deal? 
    Aren't they mostly historical?

So, although per-host scheduling by asking SCSI midlayer to retry on 
certain conditions is a bit crude, I think it covers most common use 
cases (NCQ, PMP and whatever port level exclusion).

As you pointed out previously, it would be better if we can do it via 
return value of ->qc_prep or ->qc_issue, but we can't because a prepped 
qc cannot be given back to SCSI queue for retrial, which makes the 
separation between ->qc_prep and ->qc_issue meaningless at the moment. 
So, we end up with, ->qc_defer (before qc prep) and ->qc_prep/issue 
(after qc prep).

Thanks.

-- 
tejun
