From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [nForce4] - Repeatable issues with nForce 4
Date: Sun, 14 Sep 2014 14:04:37 -0600
Message-ID: <CADLC3L1u--R5Fb99G6XCc1xs22eBsu+i0Jxco0GD29Pe5ZQ_Uw@mail.gmail.com>
References: <CAO18KQjN88PjQSh0bMo+YgqmSSE--eaxL3Lgo5QeUjg3vMu6iQ@mail.gmail.com>
	<20140914093721.GA9028@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:59563 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbaINUEi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Sep 2014 16:04:38 -0400
Received: by mail-qg0-f46.google.com with SMTP id q107so2961740qgd.19
        for <linux-ide@vger.kernel.org>; Sun, 14 Sep 2014 13:04:37 -0700 (PDT)
In-Reply-To: <20140914093721.GA9028@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jacobo Pantoja <jacobopantoja@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Sep 14, 2014 at 3:37 AM, Tejun Heo <tj@kernel.org> wrote:
> (cc'ing Robert Hancock)
>
> Hello,
>
> On Sat, Sep 13, 2014 at 11:50:08PM +0200, Jacobo Pantoja wrote:
>> (Sorry if you receive twice, I have noticed that the first email had
>> blank subject)
>> Dear Tejun Heo and linux-ide team,
>>
>> I'm Jacobo Pantoja. I'm a technology passionate and electronics engineer.
>> I have my ("beloved") computer with an nForce4 chipset, and I have had almost
>> always the ADMA interface enabled. The board itself is ASUS A8N-E, with
>> reportedly CK804 chipset, if it may be relevant at all.
>>
>> As suggested by Tejun, I'm sending my problem to the list.
>>
>> I noticed that from time to time the machine was freezed, but I was not
>> able to correctly catch the trigger. Till yesterday.
>>
>> I noticed that one of my 2 TB drives had some few sectors, which were
>> marked as "pending reallocation", but not reallocated. When this has
>> happened to me (in different computers, though), I solved it by dd'ing
>> the whole disk, locating the bad sector(s) and filling it with zeroes.
>> So I tried... and I have discovered that when a bad sector is tried to
>> be read, the system locks up.
>>
>> You may find attached:
>> * dmesg when adma activated (but not including the moment of the error
>>        because the computer freezes)
>> * photo taken in the moment of the error with adma activated
>> * dmesg when adma is not activated, including the moment of the error
>>
>> This is totally reproducible**, and I am willing to do any additional
>> testing that may help in solving this issue, if there is any interest.
>>
>> **I have noticed, while trying to provide clear dmesg's and so on, that
>> if I do the reading with ADMA disabled, the sector may be marked (as expected)
>> as definitively bad block, and then reallocated. Given that the drive has
>> still some few bad blocks, we have still some chances of reproducing again
>> and again, but really I don't know for sure how many tries do we have.
>
> You can create bad blocks using hdparm --make-bad-sector on most
> drives.
>
> So, the controller locks up the whole machine while trying to handle a
> UNC error.  Heh, it even times out on READ_LOG_EXT during EH.
> Unfortunately, I'm not sure there's much we can do at this point.
> IIRC, NV ADMA support never really matured which is why it never got
> turned on by default.  I wouldn't be too surprised if the issue is
> with the controller itself.  Quite a few of these first-gen NCQ
> controllers were quite flaky after all.  Robert should know a lot
> better than me tho.

I don't have much great insight, but it seems like these controllers
definitely have some issues with error handling. From what I saw, some
types of errors would basically cause the controller to seize up and
not respond properly to CPU requests on the HT bus (there were some
reports of MCE errors referring to HT timeouts). I've seen the CK804
lock up Windows, I think with either the NVIDIA or the default
Microsoft IDE drivers installed, when doing things like reading a
damaged DVD on an optical drive connected to the CK804 SATA
controller, which leads me to suspect it's some kind of hardware issue
that we may not be able to get around (even not using ADMA doesn't
appear to be a complete solution). I've asked NVIDIA for help about
some of the issues that were reported but it seems like they mostly
clammed up on this particular subject.

It seems like these controllers were tested with, and work fine with,
hard drives that don't have any bad sectors or other issues, but as
soon as errors start happening things start to fall apart. They came
out a bit before optical drives on SATA started becoming commonplace
where they would have had to deal with more error handling.
