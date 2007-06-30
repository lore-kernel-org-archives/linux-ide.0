From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 13/15] ide: add ata_set{_max}_pio()
Date: Sat, 30 Jun 2007 23:39:13 +0100
Message-ID: <20070630233913.5d48fb54@the-village.bc.nu>
References: <200706302111.29322.bzolnier@gmail.com>
	<4686B70F.9080606@garzik.org>
	<200706302231.10032.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41089 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752962AbXF3WdN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 18:33:13 -0400
In-Reply-To: <200706302231.10032.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> This has been changing recently since "ide_" prefix seems to have
> negative emotional connotations. :-)
> 
> New patches for drivers/ide should use exclusively the "ata_" prefix.

Then I would ask that new patches for drivers/ide are all rejected by
Andrew Morton until you change policy.

> I don't see *any* problem with this since libata exists in the separate
> directory and the amount of code shared between libata and drivers/ide
> equals *zero* (not counting <linux/ata.h> containing defines etc).

Backtraces.. grep ...

Backtraces in particular.

Alan
