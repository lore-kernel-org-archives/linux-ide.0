From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 16142] r8169: Kernel Panic when a lot of data is
 transferred through network interface
Date: Sat, 3 Jul 2010 13:53:05 +0200
Message-ID: <20100703115305.GA26168@liondog.tnic>
References: <20100619100511.GA31429@liondog.tnic>
 <20100619132708.030fe408@cpc>
 <20100623080200.GB5010@liondog.tnic>
 <20100625185846.72171be0@cpc>
 <20100630065426.GA1857@liondog.tnic>
 <20100630200254.45ab84d1@cpc>
 <20100630183138.GA11036@liondog.tnic>
 <20100703094918.03007437@cbook.fritz.box>
 <20100703082304.GA25293@liondog.tnic>
 <20100703134149.63fd8c6d@cbook.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:53919 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568Ab0GCLxK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jul 2010 07:53:10 -0400
Content-Disposition: inline
In-Reply-To: <20100703134149.63fd8c6d@cbook.fritz.box>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans Mueller <hans42mueller@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

From: Hans Mueller <hans42mueller@googlemail.com>
Date: Sat, Jul 03, 2010 at 01:41:49PM +0200

> I do especially emphasize this, as it seems not to standard to answer
> bugreports at all.

It's a shame that users get that impression but sadly I must admit I
know what you mean and yes, we should try harder instead of hacking in
gazillion new features. But the answer is simple: writing new features
is much more fun than bughunting...

> (At least on the b43 bugreport list; I reported a bug as their driver
> seems to have destroyed my wifi card. Don't missundersstand me I know
> this can happen, but I exspected the will to stop the driver from
> destroying other peoples hardware.)

Hmm, that's strange. I remember reading that while
there's no real maintainer of the driver, there are
still people doing some work on it, according to this:
http://marc.info/?l=linux-wireless&m=127747220616577&w=2

Did you also add the wireless maintainer to the Cc of your bugreport
- "John W. Linville" <linville@tuxdriver.com> - along with a detailed
description of what the problem is, which kernel, how to reproduce along
with dmesg?

-- 
Regards/Gruss,
    Boris.
