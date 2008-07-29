From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide pmac breakage
Date: Tue, 29 Jul 2008 16:45:02 +0200
Message-ID: <200807291645.03382.bzolnier@gmail.com>
References: <1217208596.11188.144.camel@pasglop> <1217332971.11188.249.camel@pasglop> <200807291404.46906.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:50905 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbYG2Or6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jul 2008 10:47:58 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1691525nfc.21
        for <linux-ide@vger.kernel.org>; Tue, 29 Jul 2008 07:47:57 -0700 (PDT)
In-Reply-To: <200807291404.46906.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

On Tuesday 29 July 2008, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 29 July 2008, Benjamin Herrenschmidt wrote:
> > On Tue, 2008-07-29 at 13:41 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > Well, all I do is call into Bart's new helpers to scan for or
> > > unregister
> > > > devices ...
> > > 
> > > The switch to these helpers happened _before_ 2.6.26 and it shouldn't
> > > bring
> > > such behavior change (ditto for new IDE host addition/removal
> > > helpers)...
> > > 
> > > Please try to git-bisect it when you have some time.
> > 
> > Ok, I will. I worked fine when I last tried your patches. I'll see if I
> > can track it down too. Been a bit too busy lately as you can imagine.
> > 
> > Do you have something that exercise the same code path you can use ?
> 
> I'll see if I can reproduce it with IDE warm-plug support later...

OK, I reproduced it here with IDE warm-plug support
(echo -n "1" > /sys/class/ide_port/ide*/delete_devices)
for devices driven by ide-cd.

It is also reproducible under qemu so I'm scripting it
into git-bisect run now...

Thanks,
Bart
