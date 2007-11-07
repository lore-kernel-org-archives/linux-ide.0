From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 05/12] libata: xfer_mask is unsigned int not unsigned
 long
Date: Wed, 07 Nov 2007 10:12:25 +0900
Message-ID: <473110F9.6020404@gmail.com>
References: <1194327550227-git-send-email-htejun@gmail.com>	<11943275501285-git-send-email-htejun@gmail.com> <20071106105151.2e3d15b8@the-village.bc.nu> <473048F7.2050004@gmail.com> <4730AA0A.4090904@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:64288 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406AbXKGBMd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 20:12:33 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2627415wah
        for <linux-ide@vger.kernel.org>; Tue, 06 Nov 2007 17:12:32 -0800 (PST)
In-Reply-To: <4730AA0A.4090904@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>> Jeff, are you okay with u32 or 64?
> 
> unsigned long is IMO the best choice for bitmaps.
> 
> * it is a machine int on all(?) architectures

I don't really see much point in this.  What's the advantage of a
machine int for xfer mask?

> * it is 32-bit on 32-bit architectures

The problem I see for using native integral types for flags or mask is
that it's not fixed in size, so you can only use the smallest of all the
supported architectures.  We know for all archs we support, both
unsigned int and unsigned long are at least 32bits long but to me making
the assumption about expected number of bits using u32 or u64 is much
more important than other considerations.

> * it is consistent with test_bit(), set_bit() and lib/bitmap.c interfaces
> 
> * conversion to test_bit() and lib/bitmap.c interfaces as a future step
> is trivial

I don't think it's likely that we'll need those heavy machineries for
xfermask and the correct approach is to convert when the need actually
arises.

> * your structs inflate on 64-bit due to pointers anyway, so I see little
> real consequence to using the lower 32 bits of an unsigned long as a
> portable meme.

I'm not trying to optimize performance or size.  I'm trying to make
programming assumptions clear.  I think it's silly to optimize anything
for xfermask.  It just has to work and be clear to people working with it.

An optimal but overkill solution would be using fast_u32 or fast_u64
types such that the compiler can choose as necessary but as we don't
have that yet && xfermask handling is a very very cold path, I think we
should be aiming for clarity.

Thanks.

-- 
tejun
