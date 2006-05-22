From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH8 and SATA
Date: Tue, 23 May 2006 08:39:57 +0900
Message-ID: <44724BCD.10509@gmail.com>
References: <447169C8.9060708@garzik.org> <44723571.1090500@gmail.com> <44724952.4040003@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.206]:7403 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751307AbWEVXj5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 May 2006 19:39:57 -0400
Received: by nz-out-0102.google.com with SMTP id 8so1433894nzo
        for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 16:39:57 -0700 (PDT)
In-Reply-To: <44724952.4040003@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> BTW, Intel sez:
>>>
>>> "FYI, I added PIIX_FLAG_IGNORE_PCS and was able to boot on ICH8."
>>>
>>
>> Yeap, that should achieve about the same effect as the experimental 
>> patch Andrew posted; also, about the same phantom bug.
> 
> Nod, just sending that to note conclusively that ICH8+PCS is a confirmed 
> problem case, as confirmed from multiple sources.
> 
> 
>> I don't think the phantom device problem is caused by missing 
>> dev_select.  We have enough dev_select() during classification.
> 
> Just a guess.  Can I easily reproduce this?  I have a bunch of Intel 
> machines, ICH5/6/7 (no ICH8 yet), of various flavors.
> 

I can reliably reproduce it using ICH7 (ASUS P5LD2).  The problem occurs 
on both combined and sata-only modes.  On my machine, combined mode maps 
secondary master and slave to P1 and P3, respectively.  And, of course, 
SATA only mode maps to PM, PS, SM, SS to P0, P2, P1, P3.

In either mode, occupy the master slot (P0 or P1) with an ATAPI device 
(I use PX716-SA) and leave the slave slot (P2 or P3) empty.  The 
signature of the ATAPI device is duplicated on the empty slave slot.  As 
noted before, this doesn't occur if the master device is ATA, only the 
slave slot is occupied or both are occupied.

-- 
tejun
