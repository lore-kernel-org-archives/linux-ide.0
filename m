From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] ide/ide-cs: fix order of releasing resources
Date: Thu, 14 Jan 2010 11:38:37 +0100
Message-ID: <20100114103837.GA13818@dominikbrodowski.net>
References: <1263324894-28117-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:40318 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754941Ab0ANKlW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Jan 2010 05:41:22 -0500
Content-Disposition: inline
In-Reply-To: <1263324894-28117-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "David S. Miller" <davem@davemloft.net>

On Tue, Jan 12, 2010 at 08:34:54PM +0100, Wolfram Sang wrote:
> ide_detach() called first ide_release() and then release_region(). This
> produced the following warnings:
> 
>   Trying to free nonexistent resource <000000000000c10e-000000000000c10e>
>   Trying to free nonexistent resource <000000000000c100-000000000000c107>
> 
> This is true, because the callchain inside ide_release() is:
> 
>   ide_release -> pcmcia_disable_device -> pcmcia_release_io
> 
> So, the whole io-block is already gone for release_region(). To fix
> this, just swap the order of releasing (and remove the now obsolete
> shadowing).
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Best,
	Dominik
