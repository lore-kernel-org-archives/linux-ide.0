From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
Date: Sat, 11 Sep 2004 09:11:09 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1094886669.13571.3.camel@thomas.tec.linutronix.de>
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de>
	 <1094828803.13450.4.camel@thomas.tec.linutronix.de>
	 <4141C8C6.1030307@inet6.fr>  <200409102321.17042.bzolnier@elka.pw.edu.pl>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:9628
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S268104AbUIKHSZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Sep 2004 03:18:25 -0400
In-Reply-To: <200409102321.17042.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Lionel Bouton <Lionel.Bouton@inet6.fr>, LKML <linux-kernel@vger.kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Fri, 2004-09-10 at 23:21, Bartlomiej Zolnierkiewicz wrote:
> Yep. :/  Lionel, can I push this fix upstream?
> 
> Could somebody enlighten me what exactly 'remapping mode' does?
> 
> Bartlomiej

The 5518 version of the IDE controller has a config bit which (re)maps
the main config registers to 5513 compatible offsets. So the 5513 code
can be used with some minor tweaks. If you don't use the remapping you
have to modify / rewrite quite a portion of the code in order to get it
working with the 5518 chip version.

tglx


