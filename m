From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/3] PATA host controller driver for ep93xx
Date: Wed, 4 Apr 2012 15:23:50 +0000
Message-ID: <201204041523.50872.arnd@arndb.de>
References: <4F7B0C54.8010804@metasoft.pl> <4F7C64B8.5000909@metasoft.pl> <4F7C65CE.6000309@metasoft.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56499 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379Ab2DDPYD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Apr 2012 11:24:03 -0400
In-Reply-To: <4F7C65CE.6000309@metasoft.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Rafal Prylowski <prylowski@metasoft.pl>, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, H Hartley Sweeten <hartleys@visionengravers.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>

On Wednesday 04 April 2012, Rafal Prylowski wrote:
> > 
> > According to ATA specification, maximum IORDY pulse width is 1250ns,
> > so I'll set timeout to 2ms (I should check this before posting the driver..).
> 
> 2ms is far too big value... Should be 2us.

Ok, in this case, don't use jiffies. I guess it was already flawed because
jiffies doesn't get updated while you are in an interrupt handler.

You could use ktime_get to get a high-resolution time stamp to compare to,
but it depends on how accurate your clocksource is.

	Arnd
