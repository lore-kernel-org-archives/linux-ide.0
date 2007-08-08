From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata-core.c: ata_fill_sg() ... sanity check on arithmentic ?
Date: Wed, 8 Aug 2007 12:23:26 +0100
Message-ID: <20070808122326.171dbf65@the-village.bc.nu>
References: <loom.20070807T172323-813@post.gmane.org>
	<20070807180714.25b1a8c1@the-village.bc.nu>
	<loom.20070808T110804-590@post.gmane.org>
	<20070808110218.601fbda3@the-village.bc.nu>
	<loom.20070808T121526-382@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53881 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751404AbXHHLPw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 07:15:52 -0400
In-Reply-To: <loom.20070808T121526-382@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MikeW <mw_phil@yahoo.co.uk>
Cc: linux-ide@vger.kernel.org

> Thanks for clarifying - as you say, the spec is specific to PCI.
> Our silicon has its own host interface which was confused by a length of zero !

You aren't the first. If you look at the current tree you'll see we now
have

	ata_dumb_qc_prep()

for interfaces that think 0x0000 is zero. Set that as your qc_prep method
and set sg_tablesize in the driver to LIBATA_DUMB_MAX_PRD and it should
work (we have to use a smaller sglist limit as the worst case is now 2
entries per 64K block)
