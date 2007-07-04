From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 9/15] ide: add PIO masks
Date: Wed, 4 Jul 2007 15:31:25 +0100
Message-ID: <20070704153125.771f9a79@the-village.bc.nu>
References: <200706302107.42458.bzolnier@gmail.com>
	<468AA351.4090509@ru.mvista.com>
	<20070703230034.233d0d7e@the-village.bc.nu>
	<468BAD97.2030904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41052 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759379AbXGDOZr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 10:25:47 -0400
In-Reply-To: <468BAD97.2030904@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

> > It doesn't need to do anything. 
> 
>     Not true. It should call ide_config_drive_speed() at least, else PIO 
> autotuning won't actually work.

Indeed - I forgot that old-ide doesn't do this itself but leaves it up to
the driver to forget 8)
