From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata-core.c: ata_fill_sg() ... sanity check on arithmentic ?
Date: Tue, 7 Aug 2007 18:07:14 +0100
Message-ID: <20070807180714.25b1a8c1@the-village.bc.nu>
References: <loom.20070807T172323-813@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46319 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751613AbXHGQ7p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 12:59:45 -0400
In-Reply-To: <loom.20070807T172323-813@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MikeW <mw_phil@yahoo.co.uk>
Cc: linux-ide@vger.kernel.org

> So then ap->prd[idx].flags_len gets set to (0x10000 & 0xFFFF) = 0 !
> So this sg element ends up with a zero length, even though the
> transfer size should be 64k.
> 
> Is this correct behaviour, if not, should it be corrected ?

The specification says that 0x0000 means 64K. A couple of controllers do
get this wrong and we did recently add a second sg list builder for those.

Perhaps a comment or two is in order ?
