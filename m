From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 03/12] serial: mvebu-uart: initial support for Armada-3700 serial port
Date: Tue, 16 Feb 2016 22:35:14 +0100
Message-ID: <2634634.yW5ZfZDXSz@wuerfel>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com> <3647094.zzYms58VAY@wuerfel> <20160216222706.6b1d3375@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:55192 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561AbcBPVgK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Feb 2016 16:36:10 -0500
In-Reply-To: <20160216222706.6b1d3375@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Jonathan Corbet <corbet@lwn.net>, arm@kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Omri Itach <omrii@marvell.com>, Hans de Goede <hdegoede@redhat.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Wilson Ding <dingwei@marvell.com>

On Tuesday 16 February 2016 22:27:06 Thomas Petazzoni wrote:
> Arnd,
> 
> On Tue, 16 Feb 2016 22:20:51 +0100, Arnd Bergmann wrote:
> 
> > > +config SERIAL_MVEBU_CONSOLE
> > > +       bool "Console on Marvell EBU serial port"
> > > +       depends on SERIAL_MVEBU_UART
> > 
> > then this one must become
> > 
> >       depends on SERIAL_MVEBU_UART
> > 
> > so it does not get enabled if the driver is not builtin.
> 
> Hm, what's the different between "depends on SERIAL_MVEBU_UART" and
> "depends on SERIAL_MVEBU_UART" ? Is it the late time that causes my
> eyes to misunderstand what you mean, or some typo on your side ? 
> 


typo: I meant

	depends on SERIAL_MVEBU_UART=y


	Arnd
