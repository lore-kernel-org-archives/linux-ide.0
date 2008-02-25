From: Pavel Machek <pavel@ucw.cz>
Subject: Re: new regression in 2.6.25-rc3: can't resume from suspend to
	ram, ata1 errors
Date: Mon, 25 Feb 2008 23:24:00 +0100
Message-ID: <20080225222400.GA4093@elf.ucw.cz>
References: <8f53421d0802251257o75d2975dldcfb99a2dc5e3539@mail.gmail.com> <47C32D48.7060909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761626AbYBYWfH@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47C32D48.7060909@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon 2008-02-25 16:04:08, Jeff Garzik wrote:
> Michael S. Tsirkin wrote:
>> git bisect points at this commit:
>> commit 559bbe6cbd0d8c68d40076a5f7dc98e3bf5864b2.
>> power_state: get rid of write-only variable in SATA
>
>
> Hello Pavel --
>
> It looks like this not a write-only variable after all...

Yep, right and sorry.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
