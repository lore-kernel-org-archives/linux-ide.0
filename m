From: Jacobo Pantoja <jacobopantoja@gmail.com>
Subject: Re: [nForce4] - Repeatable issues with nForce 4
Date: Sun, 30 Nov 2014 12:03:17 +0100
Message-ID: <CAO18KQgEn8qWozNmySU_S7vT1XSN+FfXM-1uqRWaVdOMc6sPbw@mail.gmail.com>
References: <CAO18KQjN88PjQSh0bMo+YgqmSSE--eaxL3Lgo5QeUjg3vMu6iQ@mail.gmail.com>
 <20140914093721.GA9028@mtj.dyndns.org> <CADLC3L397fmyWa1CpzZfkTkZavyKPG4M7JccdgbgTRTsUp8VVQ@mail.gmail.com>
 <CAO18KQjP785u-jiucmRFczNTRLPJMnbXm7ukvRBNvdSaW6KUhg@mail.gmail.com> <CADLC3L1BvbouQEqbdu2iDuk73-UO6a_O84gCpfaYfD6pPuLvoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52668 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaK3LDi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Nov 2014 06:03:38 -0500
Received: by mail-wi0-f178.google.com with SMTP id hi2so14661364wib.5
        for <linux-ide@vger.kernel.org>; Sun, 30 Nov 2014 03:03:37 -0800 (PST)
In-Reply-To: <CADLC3L1BvbouQEqbdu2iDuk73-UO6a_O84gCpfaYfD6pPuLvoA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

It took me a while, but I got time to recompile and reproduce the
lockup with ultra-verbose output.

Three out of four lockups seem identical (1, 2 and 4) but number 3
seems different. The trigger mechanism was the same: connect through
ssh (verbose screen made impossible working locally), start dd'ing
from disk to /dev/null in an area with some bad sectors, and wait
until lockup.

It is 100% reproducible, at least for the moment.

The link with the 4 photos:
https://drive.google.com/folderview?id=0B4EqBXYvV-kTR2daRm1GYVBDbWs&usp=sharing

Any idea about what to test now?

Best regards,
Jpantoja

On 16 September 2014 at 04:47, Robert Hancock <hancockrwd@gmail.com> wrote:
> On Mon, Sep 15, 2014 at 6:41 AM, Jacobo Pantoja <jacobopantoja@gmail.com> wrote:
>> Dears,
>>
>> Thank you for taking your time to answer. See my comments below.
>>
>> On 14 September 2014 22:03, Robert Hancock <hancockrwd@gmail.com> wrote:
>>> On Sun, Sep 14, 2014 at 3:37 AM, Tejun Heo <tj@kernel.org> wrote:
>>>>
>>>> (cc'ing Robert Hancock)
>>>>
>>>> Hello,
>>>>
>>>> On Sat, Sep 13, 2014 at 11:50:08PM +0200, Jacobo Pantoja wrote:
>>>> > (Sorry if you receive twice, I have noticed that the first email had
>>>> > blank subject)
>>>> > Dear Tejun Heo and linux-ide team,
>>>> >
>>>> > I'm Jacobo Pantoja. I'm a technology passionate and electronics
>>>> > engineer.
>>>> > I have my ("beloved") computer with an nForce4 chipset, and I have had
>>>> > almost
>>>> > always the ADMA interface enabled. The board itself is ASUS A8N-E, with
>>>> > reportedly CK804 chipset, if it may be relevant at all.
>>>> >
>>>> > As suggested by Tejun, I'm sending my problem to the list.
>>>> >
>>>> > I noticed that from time to time the machine was freezed, but I was not
>>>> > able to correctly catch the trigger. Till yesterday.
>>>> >
>>>> > I noticed that one of my 2 TB drives had some few sectors, which were
>>>> > marked as "pending reallocation", but not reallocated. When this has
>>>> > happened to me (in different computers, though), I solved it by dd'ing
>>>> > the whole disk, locating the bad sector(s) and filling it with zeroes.
>>>> > So I tried... and I have discovered that when a bad sector is tried to
>>>> > be read, the system locks up.
>>>> >
>>>> > You may find attached:
>>>> > * dmesg when adma activated (but not including the moment of the error
>>>> >        because the computer freezes)
>>>> > * photo taken in the moment of the error with adma activated
>>>> > * dmesg when adma is not activated, including the moment of the error
>>>> >
>>>> > This is totally reproducible**, and I am willing to do any additional
>>>> > testing that may help in solving this issue, if there is any interest.
>>>> >
>>>> > **I have noticed, while trying to provide clear dmesg's and so on, that
>>>> > if I do the reading with ADMA disabled, the sector may be marked (as
>>>> > expected)
>>>> > as definitively bad block, and then reallocated. Given that the drive
>>>> > has
>>>> > still some few bad blocks, we have still some chances of reproducing
>>>> > again
>>>> > and again, but really I don't know for sure how many tries do we have.
>>>>
>>>> You can create bad blocks using hdparm --make-bad-sector on most
>>>> drives.
>>>>
>>
>> If I understand correctly, the lockups occur when trying to read bad
>> sectors, prior to reallocating them. I have read hdparm's man page,
>> but I don't understand clearly if there is going to be the same effect
>> (e.g. is it going to timeout in the same way?). I can check that but
>> at first I need to make my whole backup.
>
> I think normally the drive reacts in the same way as any other kind of
> bad sector, but it likely depends on the specific drive.
>
>>
>>>> So, the controller locks up the whole machine while trying to handle a
>>>> UNC error.  Heh, it even times out on READ_LOG_EXT during EH.
>>>> Unfortunately, I'm not sure there's much we can do at this point.
>>>> IIRC, NV ADMA support never really matured which is why it never got
>>>> turned on by default.  I wouldn't be too surprised if the issue is
>>>> with the controller itself.  Quite a few of these first-gen NCQ
>>>> controllers were quite flaky after all.  Robert should know a lot
>>>> better than me tho.
>>
>> Ok, the point is if there is something to test before giving up
>> definitively with the ADMA mode for this controller. For me it is not
>> that important to have it working, but since the hardware is in place,
>> my technologist heart tells me to use it. In any case, I can
>> definitely live without it.
>>
>>>
>>>
>>> I don't have much great insight, but it seems like these controllers
>>> definitely have some issues with error handling. From what I saw, some types
>>> of errors would basically cause the controller to seize up and not respond
>>> properly to CPU requests on the HT bus (there were some reports of MCE
>>> errors referring to HT timeouts). I've seen the CK804 lock up Windows, I
>>> think with either the NVIDIA or the default Microsoft IDE drivers installed,
>>> when doing things like reading a damaged DVD on an optical drive connected
>>> to the CK804 SATA controller, which leads me to suspect it's some kind of
>>> hardware issue that we may not be able to get around (even not using ADMA
>>> doesn't appear to be a complete solution). I've asked NVIDIA for help about
>>> some of the issues that were reported but it seems like they mostly clammed
>>> up on this particular subject.
>>>
>>> It seems like these controllers were tested with, and work fine with, hard
>>> drives that don't have any bad sectors or other issues, but as soon as
>>> errors start happening things start to fall apart. They came out a bit
>>> before optical drives on SATA started becoming commonplace where they would
>>> have had to deal with more error handling.
>>
>> My main concern is that the whole computer is freezed. Is there any
>> additional kernel debug switch or whatever that may help in
>> understanding the problem?
>
> Turning on some or all of the libata debug options (at the cost of a
> likely huge amount of output) may be useful. You can try changing the
> "#undef ATA_DEBUG" and "#undef ATA_VERBOSE_DEBUG" lines in
> include/linux/libata.h to #define and rebuilding the kernel. If you
> can reproduce the lockup after that, it may indicate where it's
> occurring, though you may still need to add more output to narrow it
> down.
>
> It's quite possible that there's no reasonable workaround, but I don't
> know that anyone has taken the effort to debug this very thoroughly. I
> don't have a CK804 machine anymore so I can't provide too much
> first-hand assistance myself.
>
>>
>> I have seen some obscurity regarding ADMA for CK804 in the kernel
>> commits, but if we can isolate and reproduce the problems, perhaps we
>> can find a workaround.
>>
>>
>> I have another (different) annoying thing: why my emails do not appear
>> in the mailing list logs [1]? I'm not sure if the people subscribed to
>> the list are receiving my emails, or only your responses to them.
>
> Looks like at least this email made it to the list.
