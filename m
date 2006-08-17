From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Merging libata PATA support into the base kernel
Date: Thu, 17 Aug 2006 10:52:28 +0100
Message-ID: <1155808348.15195.55.camel@localhost.localdomain>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <20060810122056.GP11829@suse.de> <20060810190222.GA12818@knob.reflex>
	 <200608102140.36733.rjw@sisk.pl> <44E3E1E6.9090908@PicturesInMotion.net>
	 <20060817091842.GC17899@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:55472 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964778AbWHQJcu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Aug 2006 05:32:50 -0400
In-Reply-To: <20060817091842.GC17899@elf.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Lee Trager <Lee@PicturesInMotion.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jason Lunz <lunz@falooley.org>, Jens Axboe <axboe@suse.de>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Stefan Seyfried <seife@suse.de>

Ar Iau, 2006-08-17 am 11:18 +0200, ysgrifennodd Pavel Machek:
> > Well it seems I am one of those users who is bit by the resume bug. I
> > was wondering why no developer has replied to my
> > bug(http://bugzilla.kernel.org/show_bug.cgi?id=6840) even though many
> > users have. Id try to fix it myself but Ive never done kernel

Probably because its a repeat of a well known problem and nobody has
volunteered to fix it even when its been explained to them

When we set the HPA on boot we must do the same on resume or the error
you see occurs.

> 
> Time to learn?
> 
> 								Pavel
