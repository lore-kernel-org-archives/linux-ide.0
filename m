From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.26.*] boot problem (ahci/irq related?)
Date: Fri, 22 Aug 2008 12:10:58 +0200
Message-ID: <200808221210.59560.rjw@sisk.pl>
References: <8db1092f0808111312x3baf819bxbb05030c05693065@mail.gmail.com> <200808211445.46467.rjw@sisk.pl> <8db1092f0808220158k742c6429y5f8ee48d5eb61a30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43240 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753120AbYHVKHh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 06:07:37 -0400
In-Reply-To: <8db1092f0808220158k742c6429y5f8ee48d5eb61a30@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Yinghai Lu <yhlu.kernel@gmail.com>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, tj@kernel.org, andi@firstfloor.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Friday, 22 of August 2008, Maciej Rutecki wrote:
> 2008/8/21 Rafael J. Wysocki <rjw@sisk.pl>:
> 
> >
> > Do you have a log where it doesn't hang?
> >
> > Rafael
> >
> 
> http://unixy.pl/maciek/download/kernel/2.6.27-rc3/dmesg-2.6.27-rc3.txt

This doesn't look like the same configuration as in the picture you
sent previously.  In particular, the ICH7 lines are missing.

Thanks,
Rafael
