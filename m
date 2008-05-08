From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: kernel 2.6.25 with ide driver cs5520 does not boot.
Date: Thu, 8 May 2008 15:07:31 +0200
Message-ID: <58cb370e0805080607n4f5de192o5a7371fd0fb1e9f8@mail.gmail.com>
References: <20080508.165814.197343623.takada@mbf.nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:22047 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758798AbYEHNHd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 May 2008 09:07:33 -0400
Received: by fk-out-0910.google.com with SMTP id 18so788989fkq.5
        for <linux-ide@vger.kernel.org>; Thu, 08 May 2008 06:07:31 -0700 (PDT)
In-Reply-To: <20080508.165814.197343623.takada@mbf.nifty.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: TAKADA Yoshihito <takada@mbf.nifty.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

On Thu, May 8, 2008 at 9:58 AM, TAKADA Yoshihito <takada@mbf.nifty.com> wrote:
> HI, all.
>  (please CC to me, I'm not on LKML)
>
>  kernel 2.6.25 with ide driver cs5520 does not boot.
>
>  Attached part of dmesgs as dmesgs.txt

CS5520 is a bit special hardware because it doesn't support "normal"
DMA but Virtual DMA (PIO transfers between device<->host but DMA
transfers between host<->CPU).  In 2.6.25 we added support for Virtual
DMA to cs5520 host driver so it could be it (till 2.6.25 PIO has always
been used - the info printed by kernel about PIO/DMA BIOS settings was
misleading/bogus so it got removed altogether in 2.6.26-rc1).

I'll double-check the code and datasheet/errata that we don't miss
something important for proper Virtual DMA support (and if not than
I guess that we need to disable this feature for now).

In the meantime please try 2.6.26-rc1 (just to be sure that the
problem was not caused by something else that got fixed already).

>  kernel 2.6.23 with cs5520 is works correct. cs5520 scans ide0 and ide1.
>  kernel 2.6.24 with cs5520 is works wrong, but it can boot. cs5520 scans ide0 only.

[...]

2.6.24 contained a bug in calculating DMA base for the second port (thus
the error message) but it shouldn't affect anything (ide1 is still probed
according to dmesg, please let me know if there are some devices on ide1
that are not getting detected).

Thanks,
Bart
