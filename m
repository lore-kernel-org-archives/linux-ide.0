From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/4] libata-core.c: add another IRQ calls
Date: Tue, 16 Jan 2007 12:03:35 +0000
Message-ID: <20070116120335.59b4491d@localhost.localdomain>
References: <200701161046.l0GAk5Go019691@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51138 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750726AbXAPL52 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 06:57:28 -0500
In-Reply-To: <200701161046.l0GAk5Go019691@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com, jeff@garzik.org

On Tue, 16 Jan 2007 19:46:14 +0900
Akira Iguchi <akira2.iguchi@toshiba.co.jp> wrote:

> When enabling IRQ, ap->ops->irq_on is checked.
> Because most drivers can use ata_irq_on() as is, this
> patch allows ap->ops->irq_on to be NULL.
> If it is NULL, ata_irq_on() are used.


Acked-by: Alan Cox <alan@redhat.com>


Jeff - at some point we could eliminate a lot of the NULL checks like
these by having the registration code fill in the defaults where
appropriate ?

Alan
