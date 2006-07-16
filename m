From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: tighten ATA kconfig dependancies
Date: Sun, 16 Jul 2006 08:04:47 +0200
Message-ID: <1153029887.3033.7.camel@laptopd505.fenrus.org>
References: <6yL2J-7rR-1@gated-at.bofh.it> <6yLco-7DB-1@gated-at.bofh.it>
	 <E1G1p1y-0000ZU-Io@be1.lrz>  <20060716055857.GA29733@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:58541 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750739AbWGPGEu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Jul 2006 02:04:50 -0400
In-Reply-To: <20060716055857.GA29733@mars.ravnborg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: 7eggert@gmx.de, Dave Jones <davej@redhat.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>


> A cross compile toolchain is the only real soluion. Otherwise we would
> soon end up with far to many drivers selectable for x84-64.

if the *driver* is not platform specific, what is the problem with that?
Aunt Tilly again? The only difference between x86 and x86-64 is isa-bus
cards and things that were put on a motherboard but never on a PCI card.
That's maybe a dozen or two total for the entire kernel, and a set that
is not growing.

