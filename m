From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error
Date: Fri, 06 Aug 2004 01:01:05 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1091750465.8366.54.camel@localhost.localdomain>
References: <41126458.1050203@emc.com>
	 <1091724300.8043.58.camel@localhost.localdomain>
	 <4112BF1E.9070404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:39359 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268042AbUHFBE7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Aug 2004 21:04:59 -0400
In-Reply-To: <4112BF1E.9070404@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brett Russ <russb@emc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

On Gwe, 2004-08-06 at 00:13, Jeff Garzik wrote:
> Alan Cox wrote:
> > Once Jeff has MWDMA and ATAPI in the new SATA/ATA driver he wrote then
> > migration might be an even better option. It'll certainly be easier to
> > do a lot of things right with the newest SATA code than with the current
> > IDE layer.
> BTW MWDMA is already done and checked in :)

Do ATAPI and I'll be glad to help move the other drivers over. I need
hotplug for my PIIX controller and SI680!

