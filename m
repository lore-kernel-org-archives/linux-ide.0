From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Subject: Re: Unexpected _GTF length (8)
Date: Sun, 22 Sep 2013 19:09:37 +0200
Message-ID: <CAMeQTsZ7STfS6ewWkLUak-jQ2KEKbydvMMai6F4QbtDdEPswdw@mail.gmail.com>
References: <CAMeQTsby_CoGq1xAKUEVg_yWyqSSMjfSf6gWWzFRR+-znpPVbw@mail.gmail.com>
	<20130922155957.GC28571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:43292 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab3IVRJj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Sep 2013 13:09:39 -0400
Received: by mail-lb0-f177.google.com with SMTP id w7so1982061lbi.22
        for <linux-ide@vger.kernel.org>; Sun, 22 Sep 2013 10:09:37 -0700 (PDT)
In-Reply-To: <20130922155957.GC28571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Sun, Sep 22, 2013 at 5:59 PM, Tejun Heo <tj@kernel.org> wrote:
> On Sun, Sep 22, 2013 at 03:56:35AM +0200, Patrik Jakobsson wrote:
>> Where REGS_PER_GTF is defined as 7 which is correct according to ACPI specs.
>> Since I'm getting a length of 8 I started digging in the ACPI code and found
>> that the length is rounded up to acpi_size (u32 or u64 depending on arch). I
>> cannot find any commits that recently touched this though I didn't really dig
>> through it all.
>
> It means your bios is buggy.

I must be confusing the actual buffer length with the allocated buffer
length. It is
not entirely clear what is what in the ACPI-CA code. What I don't understand is
how a simple "Return (GTF0)" where GTF0 is 56 bits gets padded to 64 bits by
the firmware. Maybe the iasl disassembly is lying to me.

>> I've disassembled the SSDT for the "SataAhci" and everything looks ok. That
>> code returns a 56 bit buffer. I also tried calling the _GTF method manually
>> which returned the following (padded to 8 bytes by the ACPI code ofc).
>>
>> {0x10, 0x03, 0x00, 0x00, 0x00, 0xa0, 0xef, 0x00}
>>
>> Doing a quick google search gives me a few of these _GTF length errors dating
>> back to at least 2011. What's going on here? Is this a known error?
>
> Failing to execute _GTF is usally fine to the point where I sometimes
> wonder why we bother with it at all.  The above command is SET
> FEATURES / Enable SATA Feature / DIPM, which enables device side link
> powersaving and is a weird thing to do from _GTF anyway as host side
> needs configuration too.  You can properly configure it using libata
> link PM.

Thanks for the info. I tested "fixing up" the code to let the _GTF slide through
and I couldn't see it make any difference whatsoever. As you say, we can safely
ignore this.

Cheers
Patrik

>
> Thanks.
>
> --
> tejun
