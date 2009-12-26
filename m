From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Re: Long delays while hibernating
Date: Sat, 26 Dec 2009 16:32:24 +0000
Message-ID: <74fd948d0912260832i3716ec59rbb812bb18c5d6a07@mail.gmail.com>
References: <74fd948d0912221950m1ade8475pfe3ec3018e14d834@mail.gmail.com>
	 <4B31CAF9.8070104@kernel.org>
	 <74fd948d0912230550i639f7c05m9a6e5c9996479c01@mail.gmail.com>
	 <4B331C16.4080901@kernel.org>
	 <74fd948d0912240634h621de8b6l746470556da3eb7f@mail.gmail.com>
	 <74fd948d0912240759n72e8c141y6b75f1ee7caadf60@mail.gmail.com>
	 <4B34D2AC.8040908@kernel.org>
	 <74fd948d0912251010y2bba5bd6nf7aa3a34a7946c31@mail.gmail.com>
	 <4B35665F.20001@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:62786 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbZLZQc0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Dec 2009 11:32:26 -0500
Received: by ewy19 with SMTP id 19so750011ewy.21
        for <linux-ide@vger.kernel.org>; Sat, 26 Dec 2009 08:32:25 -0800 (PST)
In-Reply-To: <4B35665F.20001@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

On Sat, Dec 26, 2009 at 1:26 AM, Tejun Heo <tj@kernel.org> wrote:
> (cc'ing Rafael)
>
> On 12/26/2009 03:10 AM, Pedro Ribeiro wrote:
>>> Oh... Can you please try this one then?
>>
>> Sorry, still hangs with this patch :(
>>
>> This only happens in hibernation... suspend is fine.
>
> Hmmm... the patch does apply to both suspend and hibernation. =A0Rafa=
el,
> Pedro's ThinkPad T400 burns cpu cycle for 30secs on "Atomic
> copy/restore" step of hibernation if the ultrabay is powered off. =A0=
The
> original report can be found at...
>
> =A0http://thread.gmane.org/gmane.linux.ide/44190
>
> Please note that it's with TuxOnIce patches. =A0Anyways, ata_piix on
> certain configurations have similar issues where after the OS is done
> suspending and powering off the piix controller, the BIOS tries to
> access it and ends up burning cpu cycles which can be worked around b=
y
> leaving the controller on after suspend. =A0Applying the same workaro=
und
> didn't resolve the issue. =A0Do you know what can make cpu burn for
> 30secs on the atomic copy/restore step?
>
> Pedro, can you please try to reproduce the problem without TuxOnIce
> patches?
>
> Thanks.
>
> --
> tejun
>

Hi Rafael and Tejun,

I am experiencing the same delay with the kernel swsusp, so this is
definitely not a TuxOnIce issue.

Regards,
Pedro
