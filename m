From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 stability and performance
Date: Tue, 18 Mar 2008 15:40:01 +0900
Message-ID: <47DF63C1.5090205@gmail.com>
References: <20080304062942.GA14335@denix.org> <47CE55B3.6070701@gmail.com> <20080306041454.GA7242@denix.org> <47CF7222.7060702@gmail.com> <20080306065513.GE7150@denix.org> <47CF9880.4080900@gmail.com> <20080315214347.GA1511@denix.org> <47DDE0ED.6040304@rtr.ca> <20080318001513.GA2389@denix.org> <47DF4070.3040507@gmail.com> <20080318045316.GA3959@denix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:2457 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbYCRGkI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Mar 2008 02:40:08 -0400
Received: by wa-out-1112.google.com with SMTP id v27so6776540wah.23
        for <linux-ide@vger.kernel.org>; Mon, 17 Mar 2008 23:40:07 -0700 (PDT)
In-Reply-To: <20080318045316.GA3959@denix.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Dmytriyenko <denis@denix.org>
Cc: Mark Lord <liml@rtr.ca>, Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>

Hello,

Denys Dmytriyenko wrote:
>> Hmmm... This is first.  Which driver is it?  It means that controller is
>> reporting that NCQ command tags which are not issued (or already
>> completed) are in-flight.  Due to the way hdd reports NCQ command
>> completion, it's not possible for the drive to cause this.  This gotta
>> be a bug on the host side (be it controller chip or more likely the
>> driver).  The command tag in question is 5.  Only 0, 3 and 4 were in flight.
> 
> It is sata_sil24 on 2.6.23.9. If there were related fixes in the recent 
> versions, I can retest it.

No, not that I know of.

>> This one is different.  The drive reported device error but the driver
>> couldn't get more information about the error (log page 10h contains
>> it).  What does smartctl -a on the drive say?
> 
> # smartctl -a /dev/sdc
> smartctl version 5.37 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
> 
>   9 Power_On_Hours          0x0032   242   242   000    Old_age   Always       -       3941

Okay, power on hours is 3941.

> Error 42 occurred at disk power-on lifetime: 3444 hours (143 days + 12 hours)
>   When the command that caused the error occurred, the device was in an unknown state.
> 
>   After command completion occurred, registers were:
>   ER ST SC SN CL CH DH
>   -- -- -- -- -- -- --
>   84 41 28 ff 46 5a 40
> 
>   Commands leading to the command that caused the error were:
>   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
>   -- -- -- -- -- -- -- --  ----------------  --------------------
>   60 08 28 ff 46 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED
>   60 08 28 ff 46 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED
>   60 08 28 ff 46 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED
>   60 10 20 2f 47 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED
>   60 08 18 1f 47 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED

Error 42 occurred about 21days ago.  Unless your clock is off, I don't
think this is what you've seen but the error is UNC (uncorrectable media
error), so it does mean that your drive has some bad sectors which can
explain the device error you saw.

> Error 41 occurred at disk power-on lifetime: 3405 hours (141 days + 21 hours)
>   When the command that caused the error occurred, the device was in an unknown state.
> 
>   After command completion occurred, registers were:
>   ER ST SC SN CL CH DH
>   -- -- -- -- -- -- --
>   00 41 01 10 00 00 a0  Error:
> 
>   Commands leading to the command that caused the error were:
>   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
>   -- -- -- -- -- -- -- --  ----------------  --------------------
>   2f 00 01 10 00 00 a0 00      12:51:00.112  READ LOG EXT
>   60 20 20 7f 32 4c 40 00      12:51:00.081  READ FPDMA QUEUED
>   60 08 18 6f 32 4c 40 00      12:51:00.081  READ FPDMA QUEUED
>   60 30 10 9f 32 4c 40 00      12:51:00.081  READ FPDMA QUEUED
>   60 08 08 5f 32 4c 40 00      12:51:00.081  READ FPDMA QUEUED

Hmm.. this one less clear.  Maybe the device wasn't expecting READ LOG
EXT as it was still in NCQ command phase and got surprised?

Currently you're the first and only one to report illegal qc_active
transition problem.  I'd like to know what precedes the error which
isn't exactly easy in retrospect.  For now, please keep an eye on those
errors and report if you can see any pattern.  And just in case, can you
get 2.6.24 on the machine and see anything changes?

-- 
tejun
