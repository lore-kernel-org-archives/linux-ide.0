From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata ATAPI transfer size cleanups
Date: Thu, 1 Nov 2007 09:43:44 +0000
Message-ID: <20071101094344.6eb9d8bc@the-village.bc.nu>
References: <20071101090733.GA9258@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44029 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753598AbXKAJmS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Nov 2007 05:42:18 -0400
In-Reply-To: <20071101090733.GA9258@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thu, 1 Nov 2007 05:07:33 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> 
> This is purely for comment and testing, not for merging (yet?).
> 
> A common recipe in several vendor drivers (either GPL'd, or I have NDA'd
> access to use them as a documentation-like reference) for ATAPI was
> slightly different from ours.  This recipe can be found in
> atapi_tf_xfer_size(), and it's slightly different from Alan's.

Looks mostly good. Might cause breakage on one or two controllers by
setting lbam/lbah to 0 for DMA but we can test that and find out.

Note however - the scheme in use now has been tested for over ten years
in drivers/ide. The scheme below has not...

Having an ata_tf_xfer_size method is definitely a good idea whatever
methods we eventually decide on.
