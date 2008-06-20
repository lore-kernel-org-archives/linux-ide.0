From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] IDE fixes
Date: Fri, 20 Jun 2008 21:00:52 +0200
Message-ID: <200806202100.52560.bzolnier@gmail.com>
References: <200806202007.38081.bzolnier@gmail.com> <20080620190948.537f7f7a@lxorguk.ukuu.org.uk> <da824cf30806201135y7235df5cocd1dfe30d9cae54a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:12589 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbYFTS7l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jun 2008 14:59:41 -0400
Received: by py-out-1112.google.com with SMTP id p76so575407pyb.10
        for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 11:59:39 -0700 (PDT)
In-Reply-To: <da824cf30806201135y7235df5cocd1dfe30d9cae54a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 20 June 2008, Grant Grundler wrote:
> On Fri, Jun 20, 2008 at 11:09 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >
> >> +     PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS1GCF45", 0x709b1bf1, 0xf68b632),
> >
> > That one seems to be a digit short - is it 0x0f68b632 or a typo ?
> 
> Typo. Original patch seems to have 0xf68b6f32
> 
> http://lists.infradead.org/pipermail/linux-pcmcia/2008-May/005496.html

Thanks guys! [ ide-cs's ID lacked 'f' while pata_pcmcia one had it ]

I fixed the corresponding commit and recreated the git tree for Linus.

Bart
