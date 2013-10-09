From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [BUG,REGRESSION] SATA regression on 12.0-rc4 kernel
Date: Tue, 8 Oct 2013 23:50:33 -0600
Message-ID: <CADLC3L3EYU0VSfLMYjo013jSTWm4yZw24y+4HdvOOoEkOc6uhQ@mail.gmail.com>
References: <87vc1ahyft.fsf@natisbad.org>
	<20131007125943.GA1332@titan.lakedaemon.net>
	<87bo303nfe.fsf@natisbad.org>
	<52537015.6040200@gmail.com>
	<87y564waw0.fsf@natisbad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:62810 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab3JIFue (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Oct 2013 01:50:34 -0400
Received: by mail-qc0-f173.google.com with SMTP id c3so232167qcv.32
        for <linux-ide@vger.kernel.org>; Tue, 08 Oct 2013 22:50:34 -0700 (PDT)
In-Reply-To: <87y564waw0.fsf@natisbad.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Marc Carino <marc.ceeeee@gmail.com>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, willy tarreau <w@1wt.eu>, Jason Cooper <jason@lakedaemon.net>

On Tue, Oct 8, 2013 at 12:10 AM, Arnaud Ebalard <arno@natisbad.org> wrote:
> Hi Robert,
>
> Robert Hancock <hancockrwd@gmail.com> writes:
>
>> On 10/07/2013 01:12 PM, Arnaud Ebalard wrote:
>>> Hi guys,
>>>
>>> yesterday, I reported on arm kernel mailing list what looked like a sata
>>> regression on my platform (Marvell Armada 370-based NETGEAR ReadyNAS
>>> 102). I initially thought this was an ARM-related issue. My initial
>>> email, provided below, contains various details on the platform and the
>>> error encountered.
>>>
>>> Today, before starting a painful git bisect, I decided to git log
>>> sata_mv.c code and then more generally drivers/ata to quickly end up on
>>> commit ed36911c747c (libata: Add support for SEND/RECEIVE FPDMA QUEUED)
>>> against which I got suspicious after looking again at the errors I had:
>>>
>>> [  417.288155] ata1.00: exception Emask 0x0 SAct 0x1fff6001 SErr 0x0 action 0x6 frozen
>>> [  417.295838] ata1.00: failed command: WRITE FPDMA QUEUED
>>> [  417.301097] ata1.00: cmd 61/48:00:80:ad:0b/00:00:0c:00:00/40 tag 0 ncq 36864 out
>>> [  417.315896] ata1.00: status: { DRDY }
>>> [  417.319570] ata1.00: failed command: WRITE FPDMA QUEUED
>>> [  417.324814] ata1.00: cmd 61/08:68:70:a1:87/00:00:0d:00:00/40 tag 13 ncq 4096 out
>>> [  417.339619] ata1.00: status: { DRDY }
>>> [  417.343288] ata1.00: failed command: WRITE FPDMA QUEUED
>>> [  417.348536] ata1.00: cmd 61/08:70:28:a2:87/00:00:0d:00:00/40 tag 14 ncq 4096 out
>>> [  417.363341] ata1.00: status: { DRDY }
>>> [  417.367010] ata1.00: failed command: WRITE FPDMA QUEUED
>>> [  417.372257] ata1.00: cmd 61/08:80:80:a3:87/00:00:0d:00:00/40 tag 16 ncq 4096 out
>>> [  417.387061] ata1.00: status: { DRDY }
>>> [  417.390733] ata1.00: failed command: WRITE FPDMA QUEUED
>>> [  417.395977] ata1.00: cmd 61/08:88:58:a1:c7/00:00:0d:00:00/40 tag 17 ncq 4096 out
>>> [  417.410782] ata1.00: status: { DRDY }
>>>
>>> Reverting both 87fb6c31b9 (libata: Add support for queued DSM TRIM) and
>>> ed36911c74 (libata: Add support for SEND/RECEIVE FPDMA QUEUED) makes the
>>> problem disappear. Note: reverting 87fb6c31b9 is not enough and I cannot
>>> compile the kernel with only the latter reverted.
>>>
>>> If you need more info on the platform or want me to test something some
>>> fix, do not hesitate.
>>
>> I assume that it consistently fails on a non-working kernel and
>> consistently works with those patches reverted? Given that both of
>> those patches seem to only be touching SSDs with NCQ trim support, it
>> seems odd they would be breaking a normal hard drive, but maybe there
>> is some unexpected side effect..
>
> With two different disks (same model though, i.e. 250GB 3.5" WD blue), it
> consistently works on a 3.11.4 and consistently fails on 3.12-rc3 and
> 3.12-rc4 (not tested others 3.12-rc). The problem is easy to reproduce,
> i.e. I just need to perform some disk operations. With the two commits
> reverted from 3.12-rc4, I can consistently do a "find / -exec sha256sum
> '{}' \;" w/o anything happening.
>
> What I do not understand is why the log report failed FPDMA commands if
> the feature is supposed to be SSD-related (looking only at commit
> messages: 87fb6c31b9 seems SSD-related, ed36911c74 does not). Is it
> possible that the feature detection is what is causing the issue? Or
> that the hardware report support w/o having? I can test with a different
> disk if you think it would help.

The commands that are failing are WRITE FPDMA QUEUED which is a
regular NCQ write command. The ones that these commits add support for
are FPDMA_SEND and FPDMA_RECV which are used for NCQ trim commands.

It's possible that the feature detection for this is picking up
support for FPDMA SEND/RECV on this drive when it shouldn't be. Can
you post the output of "hdparm --Istdout /dev/sdX" for one of these
drives (where X matches the drive in question)?
