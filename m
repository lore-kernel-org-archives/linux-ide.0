From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv oops on module removal
Date: Fri, 18 Jan 2008 21:49:18 +0900
Message-ID: <4790A04E.6000506@gmail.com>
References: <478F5F1C.80608@wpkg.org> <478F6DB5.4080308@rtr.ca> <478F8A5A.3030003@wpkg.org> <478FFA0A.4060008@rtr.ca> <479029B3.5070506@gmail.com> <47907AE4.7020308@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:7553 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbYARMt1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 07:49:27 -0500
Received: by rv-out-0910.google.com with SMTP id k20so881937rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 18 Jan 2008 04:49:24 -0800 (PST)
In-Reply-To: <47907AE4.7020308@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Mark Lord <liml@rtr.ca>, Linux IDE <linux-ide@vger.kernel.org>

Tomasz Chmielewski wrote:
> Tejun Heo schrieb:
>> Mark Lord wrote:
>>> Tejun,
>>>
>>> This Oops (2.6.23.13) looks very much like the same bug
>>> you fixed recently for me in 2.6.24.
>>>
>>> The bug was with sata_qstor and other drivers, in that
>>> devres/libata were freeing the I/O resources before invoking
>>> the LLD's host/port_stop routines .. which still need the I/O.
>>>
>>> Did that patch get backported to 2.6.23 yet ?
>>
>> No, it's not but yeah it probably should have.  Tomasz, can you please
>> test whether the attached patch fixes the problem?
> 
> No oops anymore - I get those in the log instead (below).

Great.

> START_STOP FAILED doesn't sound very good, but perhaps it's normal?

Yeap, that's normal.  ATA device goes away beneath the SCSI driver and
when the SCSI driver tries to stop the drive, it's already gone.  I'll
push the patch to -stable.

Thanks.

-- 
tejun
