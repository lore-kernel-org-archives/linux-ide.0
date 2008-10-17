From: gettinther <gettinther@gmail.com>
Subject: Re: Can you please test the attached patch for nv hardreset problem?
Date: Fri, 17 Oct 2008 09:25:07 +0100
Message-ID: <64630f150810170125r546f4f26w202b45c6eaaecf3d@mail.gmail.com>
References: <48E80F11.3060101@kernel.org>
	 <64630f150810111634gbe4cfdfjccafc9f6f781edcc@mail.gmail.com>
	 <48F30678.7020807@kernel.org>
	 <64630f150810131213m64d8fc72j38debf71a692db16@mail.gmail.com>
	 <48F3F368.2090901@kernel.org>
	 <64630f150810141431r1d070cddl1c2a6b32ae80b64c@mail.gmail.com>
	 <48F57E0B.6050403@kernel.org>
	 <64630f150810151323k68ded27eie9a24e1b0579288a@mail.gmail.com>
	 <48F69C89.5070900@kernel.org>
	 <64630f150810160004o77d2819dy40a6f58d13af098d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:30797 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbYJQIZI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Oct 2008 04:25:08 -0400
Received: by an-out-0708.google.com with SMTP id d40so27216and.103
        for <linux-ide@vger.kernel.org>; Fri, 17 Oct 2008 01:25:07 -0700 (PDT)
In-Reply-To: <64630f150810160004o77d2819dy40a6f58d13af098d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, lists@ku-gbr.de, linux@sun7.cn, Robert Hancock <hancockr@shaw.ca>

On Thu, Oct 16, 2008 at 8:04 AM, gettinther <gettinther@gmail.com> wrote:
> On Thu, Oct 16, 2008 at 2:44 AM, Tejun Heo <tj@kernel.org> wrote:
>> gettinther wrote:
>>> On Wed, Oct 15, 2008 at 6:22 AM, Tejun Heo <tj@kernel.org> wrote:
>>>> gettinther wrote:
>>>>> The log simply ignores the drive altogether.
>>>>>
>>>>> from the sound coming from the drive, it does seem that the drive
>>>>> initially starts at boot, then stops.  After that stage the device
>>>>> detection takes place.  as the item is a pata to sata converter
>>>>> (emulated sata), it does not support hot plugging.
>>>>>
>>>>> I also need to mention that this behavior (start-stop during boot) did
>>>>> not happen on the 2.6.24 and I need to check the 2.6.27.  However the
>>>>> device is detected by both of these kernels.
>>>> Hmmm...
>>>>
>>>>> Oct 14 21:18:12 localhost kernel: ata2: SATA link up 1.5 Gbps (SStatus
>>>>> 113 SControl 300)
>>>> Hmmm... Can you please apply the attached patch on top of it and
>>>> report the boot log?
>>>>
>>>> --
>>>> tejun
>>>>
>>>
>>> here it is.  Let me know if you need other parts of the logs.
>>
>> Ah.. okay, you need to change .hardreset to ATA_OP_NULL instead of
>> sata_std_hardreset.
>>
>> --
>> tejun
>>
>
> On both 2.6.26 and 2.6.27 or just the 2.6.26?  The initial patch does
> work on the 2.6.27
>
> Thanks,
>
> Cyrille
>

Tried replacing sata_std_hardreset with  ATA_OP_NULL but it didn't
work.  I'll add back the debug patch and post the results
