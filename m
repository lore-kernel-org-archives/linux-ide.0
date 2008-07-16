From: "Sagar Borikar" <sagar.borikar@gmail.com>
Subject: Re: infrequent soft reset on sil 3512 sata controller with 2.6.18 kernel
Date: Wed, 16 Jul 2008 10:14:58 +0530
Message-ID: <3fb94e50807152144s4d9eacbvd8b4f2dab7b5949e@mail.gmail.com>
References: <3fb94e50807132240p1d846c3bpe23cc468820a58c9@mail.gmail.com>
	 <487D3977.3030607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:42990 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbYGPEo7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jul 2008 00:44:59 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6290602rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 15 Jul 2008 21:44:58 -0700 (PDT)
In-Reply-To: <487D3977.3030607@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, Jul 16, 2008 at 5:27 AM, Tejun Heo <htejun@gmail.com> wrote:
> Hello,
>
> Sorry about the delay.  Way overloaded these days.
No issues. But sincerely thanks a lot. We are badly tied up with this
issue currently.
>
> Sagar Borikar wrote:
>> I have one doubt and thought you are the best person who can address
>> it. Could you kindly help me out?
>
> Please cc linux-ide@vger.kernel.org when you reply.
>
>> Currently  I am working with NAS box which has following configuration:
>>
>> MIPS arch
>> 2.6.18 kernel - comparatively older but box is in production
>> 128 MB RAM
>> sil 3512 SATA controller
>> xfs file system
>>
>> When performing the iozone stress test of the box over CIFS, NFS
>> simultaneously, I find that the ata port gets soft reset once in 5-8
>> hours and because of which the the continuous write activity gets
>> stalled on the drives. All the smbd processes which are writing data
>> to the disk goes into uninterruptilbe sleep state continuosuly and the
>> test doesn't complete.
>>
>> Following is the log that I get :
>>
>> ata1: soft resetting port
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> ata1.00: configured for UDMA/100
>> ata1: EH complete
>> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
>> sda: Write Protect is off
>> SCSI device sda: drive cache: write back
>
> Can you please post the log which leads to the softreset?  The above
> only shows EH's response to the problem not the cause itself.  Also, if
> possible, please try more recent kernel.  Recent ones have better error
> reporting and will help debugging the problem even if it can't be used
> for production.

Unfortunatey, we can't upgrade kernel as this is a production system.
And these are the only logs
which I get on the console and dmesg output, nothing else comes from
sata controller. So I am
clueless from where the soft reset is triggered.

>> After this, I start getting errors from file system :
>>
>> can't seek in filesystem at bb 10686861057857128
>> can't read btree block 1630685585/1000141
>> can't seek in filesystem at bb 8951363201349912
>> can't read btree block 1365869628/911139
>> can't seek in filesystem at bb 5768064121399776
>> can't read btree block 880136736/1043772
>>
>> Which looks like filesystem is trying to read the block  which is not
>> present in the partition.
>> and because of which device driver cribs that it is trying to access
>> the data beyond end of the device.
>
> I don't have much experience with xfs but yeah that looks like a
> filesystem corruption, which shouldn't happen even after IO errors as
> all failed IOs are retried.
>
>> So I guess there is filesystem corruption too which can be solved
>> independently but ata1 getting soft reset under load is something
>> strange. Has anyone observed this before with silicon image 3512
>> cards?
>
> SATA IO errors are much more common than PATA ones probably due to its
> high signal rate.  Even on a otherwise perfectly healthy system, SATA IO
> errors occur occasionally (say, once in several months).  However, if
> such problems are frequent and regular, it does indicate a problem.  One
> of not-so-rare causes for such problems is power or interference
> problem.  Using different powre supply and hooking up the harddrive to a
> separate power supply is the easiest way to rule this out.
Understood but the point is we don't see soft reset on other platforms
with different sata controller. So I would guess that it could be a
combination of power suppy
and the sata controller. I'll update you with the results of separate
power supply to drive and system test.
>
> As for the data corruption, there has been several reports on sata_sil +
> certain nvidia chipset combination.  The problem hasn't been solved yet.
>  Other than that, considering its wide use, I don't think data
> corruption on sata_sil is something to worry about.
>
> Another more common way to lose data on a harddrive is cutting the power
> briefly while write is in progress (buffer is dirty).  This will make
> the drive forget about the content in the dirty buffer and the OS would
> think that only the connection to the drive was momentarily lost and
> just continue writing after recovery which is a pretty effective way to
> corrupt the filesystem.
>
> This momentary power loss (short voltage drop will do the job) is not so
> rare.  A few months ago, I tracked down a fs corruption problem on a
> server from a major vendor to this problem and it wasn't a single
> machine.  The whole line or production batch was problematic.

> You can often hear the head doing an emergency unload and then spinning
> back up shortly after.  This also increments emergency unload and/or
> start stop count in the smart output, so if those counters increase
> after such IO errors, it's likely that you're experiencing this problem.
>
> Hope it helped.

Thanks a ton for this detail information.
>
> --
> tejun
>
