From: Tejun Heo <htejun@gmail.com>
Subject: Re: asdf
Date: Sat, 03 Feb 2007 13:07:39 +0900
Message-ID: <45C40A8B.1090307@gmail.com>
References: <11704009502014-git-send-email-htejun@gmail.com> <45C36DED.9020809@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:14087 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946319AbXBCEHp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 23:07:45 -0500
Received: by an-out-0708.google.com with SMTP id b33so772428ana
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 20:07:45 -0800 (PST)
In-Reply-To: <45C36DED.9020809@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, edmudama@gmail.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>

Ric Wheeler wrote:
[--snip--]
> We might still want/need to be able to "lock" specific drives so that
> they do not drop out of DMA mode, not as the default but as a system
> tuning issue. What we see in the set of ATA drives that we have in the
> field  is that dropping out of DMA mode is basically useless (for us at
> least) since it is so slow and we always have other drives to fall back
> on. Clearly not the case for typical end users, but a common case in the
> storage space where we pack as many disk drives into each box as we can.

I agree that some tuning knobs can be useful.  SATA drives now never
drops to PIO mode due to errors.  Even PATA drives should be failing
really hard to get degraded into PIO mode.

> On that other thread, I mentioned that we need to get some good testing
> done with this kind of thing.  With Mark's error injection fixes (or the
> new ATA spec'ed ability to inject errors that Doug mentioned), along
> with our population of real world flaky drives, I hope to be able to
> beat on this in a realistic way in our labs,

Yeap, really.  Things are pretty easy to adjust.  With all the posted
patches applied...

* Errors are categorized by ata_eh_categorize_error() considering
whether the failed request was regular IO operation and the err_mask.

* ata_eh_speed_down_verdict() scans error history and determines
verdicts (or'd bitmask of ATA_EH_SPDN_* flags).

* ata_eh_speed_down() tries to apply the verdict.  It always prefers the
least severe verdict and once a verdict is applied all others are
ignored and error history is cleared.

So, the basic tuning point is ata_eh_speed_down_verdict().  It's a very
short and easy-to-tune function which determines for how far back the
error history is scanned and which categories of errors trigger which
verdict.

Experimenting in realistic setup and reporting how the current setting
works and how better can it be adjusted will be a huge help.

Thanks.

-- 
tejun
