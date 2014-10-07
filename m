From: Steven Honeyman <stevenhoneyman@gmail.com>
Subject: Re: [PATCH] libata: Un-break ATA blacklist
Date: Tue, 7 Oct 2014 17:51:16 +0100
Message-ID: <CABz95_CR8cKY-s2a3wrFshZpxuZ-P4iTtCYnB8_On7X9gsK-6g@mail.gmail.com>
References: <20141007112638.20944.qmail@ns.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:55964 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbaJGQvR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Oct 2014 12:51:17 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so8505695wiv.5
        for <linux-ide@vger.kernel.org>; Tue, 07 Oct 2014 09:51:16 -0700 (PDT)
In-Reply-To: <20141007112638.20944.qmail@ns.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-ide@vger.kernel.org, tj@kernel.org

On 7 October 2014 12:26, George Spelvin <linux@horizon.com> wrote:
> lib/glob.c provides a new glob_match() function, with arguments in
> (pattern, string) order.  It replaced a private function with arguments
> in (string, pattern) order, but I didn't swap the call site...
>
> The result was the entire ATA blacklist was effectively disabled.

Oops :)

> The lesson for today is "I f***ed up *how* badly *how* many months ago?",
> er, I mean "Nobody Tests RC Kernels On Legacy Hardware".
>
> This was not a subtle break, but it made it through an entire RC
> cycle unreported, presumably because all the people doing testing
> have full-featured hardware.

Everyone makes mistakes - although I'd be very surprised there are no
testers using the same SSD as mine. It's the most common mSATA drive
around here in the UK at the moment (even if it has a slightly dodgy
firmware!).

> I'd like to wait to add a Tested-by, but it's also important enough
> I want to publicly post a fix ASAP

Pesky timezone differences! I was at work when you posted this patch,
but just got home and recompiled. I can confirm this works:
[    3.845109] ata5.00: disabling queued TRIM support
[    3.845112] ata5.00: ATA-9: Crucial_CT240M500SSD3, MU05, max UDMA/133

...although the patch didn't apply as a quick copy-paste job from
Gmail ...but that's an unrelated matter :)


Thanks again,
Steven.
