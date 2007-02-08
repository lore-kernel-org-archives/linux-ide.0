From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] ATA convert GSI to irq on ia64
Date: Thu, 8 Feb 2007 19:42:04 +0000
Message-ID: <20070208194204.GC2354@infradead.org>
References: <1170920422.15989.354.camel@ymzhang>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:57163 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423276AbXBHTmK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Feb 2007 14:42:10 -0500
Content-Disposition: inline
In-Reply-To: <1170920422.15989.354.camel@ymzhang>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Thu, Feb 08, 2007 at 03:40:22PM +0800, Zhang, Yanmin wrote:
> If an ATA drive uses legacy mode, ata driver will choose 14 and 15 as the
> fixed irq number. On ia64 platform, such numbers are GSI and should be converted
> to irq vector.
> 
> Below patch against kernel 2.6.20 fixes it.

These direct arch ifdefs in core aren't acceptable.  The again I'm
pretty sure we have patches floating around to turn these two macros
into architecture-supplied ones, IIRC it came from the powerpc side.

