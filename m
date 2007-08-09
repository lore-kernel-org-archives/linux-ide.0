From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] pata_hpt37x: actually clock HPT374 by 50 MHz DPLL
Date: Thu, 9 Aug 2007 23:52:13 +0100
Message-ID: <20070809235213.391ab6c9@the-village.bc.nu>
References: <200708052245.16406.sshtylyov@ru.mvista.com>
	<200708092248.44675.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35015 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751731AbXHIWqu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 18:46:50 -0400
In-Reply-To: <200708092248.44675.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, rah@bash.sh

>  * This driver is heavily based upon:
>  *
>  * linux/drivers/ide/pci/hpt366.c               Version 0.36    April 25, 2003
>  *
> reference to hpt366 version should also be updated (or removed)


Disagree - its not based on the newer hpt366 driver. Its based on the old
one. Actually by now it bears almost no resemblence any of them
