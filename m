From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: use ATAPI dma even for data transfers not
 aligned to 16 bytes
Date: Mon, 16 Jun 2008 10:31:46 +0100
Message-ID: <20080616103146.0bbdc641@lxorguk.ukuu.org.uk>
References: <485615B4.7070002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55836 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758139AbYFPJzm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2008 05:55:42 -0400
In-Reply-To: <485615B4.7070002@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, 16 Jun 2008 16:26:44 +0900
Tejun Heo <tj@kernel.org> wrote:

> Most ATAPI DMA failures are due to controller issues including choking
> on data buffer w/o proper padding or draining areas and should be
> worked around in LLDs.  The default 16 byte alignment check in
> ata_check_atapi_dma() only partially hides problems (well, that was
> the conclusion back then, at least).

You need to modify some of the drivers before you can remove this check
now. At least AMD, and probably nvidia (but who knows) require 4
byte alignment for internal buffering unless you reconfigure the FIFO
(actually we should be using inl/outl as well in the AMD case it seems -
docs are not 100% clear). I'm currently investigating this bit.

Alan
