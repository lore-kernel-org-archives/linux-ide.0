From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v2 4/4] [libata] pata_platform: s/ioport_shift/reg_shift/g
Date: Wed, 5 Dec 2007 09:56:43 +0900
Message-ID: <20071205005643.GA28860@linux-sh.org>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170745.GD15599@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pip10.gyao.ne.jp ([61.122.117.248]:63564 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751761AbXLEA5K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 19:57:10 -0500
Content-Disposition: inline
In-Reply-To: <20071204170745.GD15599@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Olof Johansson <olof@lixom.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kumar Gala <galak@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>

On Tue, Dec 04, 2007 at 08:07:45PM +0300, Anton Vorontsov wrote:
> This patch renames ioport_shift member of pata_platform_info
> structure to reg_shift. Users of pata_platform are followed
> appropriately.
> 
> Rationale of that change is: shifting applies to the whole memory
> mapped region, not only to the command block of the ATA registers,
> despite the fact that shifting is meaningless for ctl register.
> 
It's called ioport_shift because of the fact it shifts an ioport, namely
a struct ata_ioport *. We could rename it, but I really don't see the
point. If you don't like the choice of name on your platform, add a
comment to your platform-specific code noting this particular outrage so
it can be grepped for by future generations ;-)

Nacked-by: Paul Mundt <lethal@linux-sh.org>
