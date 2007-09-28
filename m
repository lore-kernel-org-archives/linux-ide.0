From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 with port multiplier
Date: Fri, 28 Sep 2007 09:51:06 -0700
Message-ID: <46FD30FA.2010104@gmail.com>
References: <FD6311B7ED175B4480F31633F6098B4D911D11@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:56150 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbXI1Qwq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 12:52:46 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3598882wah
        for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 09:52:44 -0700 (PDT)
In-Reply-To: <FD6311B7ED175B4480F31633F6098B4D911D11@ffpglobal_mail.corp.ffplus.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon Chelton <jchelton@ffpglobal.com>
Cc: linux-ide@vger.kernel.org, Bruce Allen <ballen@gravity.phys.uwm.edu>

Jon Chelton wrote:
> This error occurred when assembling a software raid 5 array using mdadm.
> It also happened when copying large amounts of data from one drive to
> another.  I saw from an earlier post to disable or upgrade smartd.  I
> tried this (disabled) and moved about 50gb between disks and the error
> has not repeated yet.

Please post full kernel log containing boot message and the following
error trace.  cc'ing Bruce Allen for smartd.

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] 
> Sent: Friday, September 28, 2007 3:24 AM
> To: Jon Chelton
> Cc: linux-ide@vger.kernel.org
> Subject: Re: sata_sil24 with port multiplier
> 
> Jon Chelton wrote:
>> After applying the patches you sent, I had not received any additional
>> errors until today.  Below is an output from dmesg.
>>
>> ata1.15: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
>> ata1.15: irq_stat 0x00020002, PMP DMA CS errata
>> ata1.00: exception Emask 0x100 SAct 0x18084200 SErr 0x0 action 0x6
>> frozen
>> ata1.00: cmd 60/00:48:3f:8f:fa/01:00:0a:00:00/40 tag 9 cdb 0x0 data
>> 131072 in
>>          res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
>> error)
> 
> Hmmm... So, when did the above error occur?  Can you reproduce it?
> 


-- 
tejun
