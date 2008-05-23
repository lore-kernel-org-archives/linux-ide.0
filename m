From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET #upstream-fixes] git tree available
Date: Fri, 23 May 2008 10:04:39 +0900
Message-ID: <48361827.1020402@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com> <48305961.2050509@gmail.com> <006501c8ba19$c1f53340$6917a8c0@parents> <48323E4F.3050806@rtr.ca> <4832535B.1080505@gmail.com> <483256FF.1010200@gmail.com> <00a501c8bae2$7815f7e0$6917a8c0@parents> <4833AC14.5090207@gmail.com> <00b901c8bb7a$caaa1ed0$6917a8c0@parents> <4834C101.70005@gmail.com> <00ee01c8bc6e$cc9ee910$6917a8c0@parents>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.180]:56426 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386AbYEWBEs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 May 2008 21:04:48 -0400
Received: by el-out-1112.google.com with SMTP id s27so218847ele.1
        for <linux-ide@vger.kernel.org>; Thu, 22 May 2008 18:04:46 -0700 (PDT)
In-Reply-To: <00ee01c8bc6e$cc9ee910$6917a8c0@parents>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian & Chamaigne Scamman <scammanbc@earthlink.net>
Cc: 'Mark Lord' <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org

Brian & Chamaigne Scamman wrote:
> Tejun Heo wrote:
>> Can you please put ssleep(5) right after the first ata_do_reset() call 
>> in drivers/ata/libata-eh.c::ata_eh_reset() and see whether the problem 
>> goes away?
> 
> This actually caused more problems. The "failed to IDENTIFY (I/O error,
> err_mask=0x11)" was still printed, plus there was a 5 second delay for each
> port on the PMP during each of the 3 attempts to read the drive. In the end,
> neither of the two SSD drives I tried ended up working. Changing ssleep(5)
> to msleep(5) didn't remove the IDENTIFY errors, but still allowed the drives
> to work.
> 
> Is there anyway to control the length of the reset pulse? I've heard that
> some of the SSD's require the reset pulse to be held longer than normal.

For sata_sil24, it's determined by the controller.  Hmmm... Please wait 
a bit, I have another thing to try.

-- 
tejun
