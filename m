From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata_piix: parallel scanning on PATA needs an extra
 locking
Date: Sun, 30 Aug 2009 15:13:21 +0100
Message-ID: <20090830151321.57bc33eb@lxorguk.ukuu.org.uk>
References: <200908301456.30132.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58853 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753721AbZH3OM3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Aug 2009 10:12:29 -0400
In-Reply-To: <200908301456.30132.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Alan Cox <alan@linux.intel.com>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Lets fix all such races by adding an extra locking to ->set_piomode
> and ->set_dmamode methods for PATA controllers.

Would it not be better to take the host lock in libata-core for these
cases so that we fix all the adapters in one swoop. Even if we are doing
this lock taking in the controller specific code it seems the right lock
to use ?

Looks fine as a temproary quickfix tho
