From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: don't whine if ->prereset() returns -ENOENT
Date: Mon, 12 Mar 2007 12:10:32 +0000
Message-ID: <20070312121032.3cfd1786@lxorguk.ukuu.org.uk>
References: <20070309163148.GA12848@havoc.gtf.org>
	<b637ec0b0703091324q7f15fddbpc8c24b4e1131e3f4@mail.gmail.com>
	<20070309234839.2070a265@lxorguk.ukuu.org.uk>
	<45F50E28.7010509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52298 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965538AbXCLLHs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 07:07:48 -0400
In-Reply-To: <45F50E28.7010509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Fabio Comolli <fabio.comolli@gmail.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>

> 1. I think these ports should be made dummy instead of returning
> -ENOENT on prereset().  -ENOENT from prereset() was a hack to keep
> ata_piix's behavior unchanged while converting it to new EH.  If no
> one objcts, I'll convert similar usages to use dummy ports after new
> init model and drop -ENOENT hack in #upstream.

No objection at all.

> 2. -ENODEV sounds more appropriate.  Why have I used -ENOENT.  :-)

You didn't - I did. I think -ENOENT is better as we are missing an entire
channel not a device (disk).

>
