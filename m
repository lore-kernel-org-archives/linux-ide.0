From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add correct interrupt property for pegasos ide
Date: Thu, 05 Apr 2007 11:47:18 +1000
Message-ID: <1175737638.30879.107.camel@localhost.localdomain>
References: <20070404111635.GA1855@aepfle.de>
	 <200704042010.50088.bzolnier@gmail.com> <20070404181138.GA6050@aepfle.de>
	 <200704042042.15108.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56885 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041AbXDEBrd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2007 21:47:33 -0400
In-Reply-To: <200704042042.15108.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Paul Mackeras <paulus@samba.org>, linux-ide@vger.kernel.org

> There might be also the another issue here - the chipset claims fully native
> mode (prog-if 8f - taken from your previous mail) so driver takes IRQ value
> from dev->irq (which your patch fixes to be 14 instead of 20 if I'm reading
> it correctly) but in reality chipset seems to be still using legacy IRQs
> (14 for the primary port and 15 for the secondary one).  What IRQ value is
> reported by the libata for the secondary port?  Does the second port work?

It's a crackpot VIA chipset... it claims to be fully native but uses legacy
IRQs... go figure. So yes, we need a quirk. I don't have chipset specs
so I don't know if the driver can "detect" that though.

Ben.

