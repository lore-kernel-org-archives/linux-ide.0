From: Tejun Heo <htejun@gmail.com>
Subject: Re: infrequent soft reset on sil 3512 sata controller with 2.6.18
 kernel
Date: Wed, 16 Jul 2008 14:00:31 +0900
Message-ID: <487D806F.2090504@gmail.com>
References: <3fb94e50807132240p1d846c3bpe23cc468820a58c9@mail.gmail.com>	 <487D3977.3030607@gmail.com> <3fb94e50807152144s4d9eacbvd8b4f2dab7b5949e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:20269 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbYGPFAm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jul 2008 01:00:42 -0400
Received: by ti-out-0910.google.com with SMTP id b6so2858965tic.23
        for <linux-ide@vger.kernel.org>; Tue, 15 Jul 2008 22:00:41 -0700 (PDT)
In-Reply-To: <3fb94e50807152144s4d9eacbvd8b4f2dab7b5949e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: linux-ide@vger.kernel.org

Sagar Borikar wrote:
>> Can you please post the log which leads to the softreset?  The above
>> only shows EH's response to the problem not the cause itself.  Also, if
>> possible, please try more recent kernel.  Recent ones have better error
>> reporting and will help debugging the problem even if it can't be used
>> for production.
> 
> Unfortunatey, we can't upgrade kernel as this is a production system.
> And these are the only logs
> which I get on the console and dmesg output, nothing else comes from
> sata controller. So I am
> clueless from where the soft reset is triggered.

Eh... That shouldn't happen but ISTR fixing paths where diagnostics
weren't reported correctly.  :-(  You can make it more verbose by
editing drivers/ata/libata-eh.c::ata_eh_report().  There are several
conditions which make it veil without reporting.  Remove them so that it
always reports.

>> SATA IO errors are much more common than PATA ones probably due to its
>> high signal rate.  Even on a otherwise perfectly healthy system, SATA IO
>> errors occur occasionally (say, once in several months).  However, if
>> such problems are frequent and regular, it does indicate a problem.  One
>> of not-so-rare causes for such problems is power or interference
>> problem.  Using different powre supply and hooking up the harddrive to a
>> separate power supply is the easiest way to rule this out.
> Understood but the point is we don't see soft reset on other platforms
> with different sata controller. So I would guess that it could be a
> combination of power suppy
> and the sata controller. I'll update you with the results of separate
> power supply to drive and system test.

Hmmm.. Combination of PSU + SATA controller isn't very likely.  :-(
Well, please rule it out anyway as the other possibility (silent data
corruption) is scarier and much more difficult to track down.

>> This momentary power loss (short voltage drop will do the job) is not so
>> rare.  A few months ago, I tracked down a fs corruption problem on a
>> server from a major vendor to this problem and it wasn't a single
>> machine.  The whole line or production batch was problematic.
> 
>> You can often hear the head doing an emergency unload and then spinning
>> back up shortly after.  This also increments emergency unload and/or
>> start stop count in the smart output, so if those counters increase
>> after such IO errors, it's likely that you're experiencing this problem.
>>
>> Hope it helped.
> 
> Thanks a ton for this detail information.

Can you please report full boot log + smartctl -a output before and
after an error?

-- 
tejun
