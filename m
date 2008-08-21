From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.26.*] boot problem (ahci/irq related?)
Date: Thu, 21 Aug 2008 14:45:45 +0200
Message-ID: <200808211445.46467.rjw@sisk.pl>
References: <8db1092f0808111312x3baf819bxbb05030c05693065@mail.gmail.com> <8db1092f0808160236o63c42de4k3c455c349d3e9da6@mail.gmail.com> <8db1092f0808201136y15a67647i95fd00fb5d2476fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37215 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbYHUMm1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Aug 2008 08:42:27 -0400
In-Reply-To: <8db1092f0808201136y15a67647i95fd00fb5d2476fc@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Yinghai Lu <yhlu.kernel@gmail.com>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, tj@kernel.org, andi@firstfloor.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Wednesday, 20 of August 2008, Maciej Rutecki wrote:
> 2008/8/16 Maciej Rutecki <maciej.rutecki@gmail.com>:
> > I test few versions of linux kernel and 2.6.26-rc3 hangs during boot,
> > 2.6.26-rc2 (propably) is good. I wrote "propably" because bug is not
> > 100% reproducible and must have more time to be sure. After I will try
> > bisect. Any suggestions?
> >
> > --
> > Maciej Rutecki
> > http://www.maciek.unixy.pl
> >
> 
> I try bisect (no results), and one time I boot kernel with
> initcall_debug option. Kernel stops on this:
> http://unixy.pl/maciek/download/kernel/dupa/initcall_debug.jpg

Do you have a log where it doesn't hang?

Rafael
