From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_it821x: sync with IDE it821x driver
Date: Sun, 10 Jun 2007 16:28:59 +0100
Message-ID: <20070610162859.1d377ea8@the-village.bc.nu>
References: <200706090223.20933.bzolnier@gmail.com>
	<466A417C.5090901@gmail.com>
	<200706092209.10636.bzolnier@gmail.com>
	<466B830B.5020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40308 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751024AbXFJPXq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Jun 2007 11:23:46 -0400
In-Reply-To: <466B830B.5020007@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Hmmm... indeed.  Alan, is there any reason we do that in ->set_piomode
> not ->mode_filter?  We end up with mismatching configuration between the
> controller and the higher speed drive.

We always talk more slowly than the drive which is just fine. Just about
every device on every controller does some variant of this, usually just
for the address setup timings. Our current behaviour (both old and new
IDE) may actually not be conservative enough for register rather than
data timings, which quite possibly should always be at the lower speed.

Currently the PATA drivers use mode_filter to remove modes not allowed
due to hardware issues/flaws/etc and a mix of their own timer merging and
the intelligence in the ata_timing functions to work out what timing
pattern should be used.

Beyond looking further into the register load timings and maybe making
the 8bit timings more conseratively merged (as Sergei I think feels they
should be) I don't plan to change this.

Alan

