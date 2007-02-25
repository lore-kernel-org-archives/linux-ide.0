From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream-fixes] pata_amd: fix an obvious bug
 in cable detection
Date: Sun, 25 Feb 2007 13:29:45 +0000
Message-ID: <20070225132945.44299b0c@lxorguk.ukuu.org.uk>
References: <20070205080128.GH1625@htj.dyndns.org>
	<45E0EBD6.2010008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43318 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964842AbXBYM1G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Feb 2007 07:27:06 -0500
In-Reply-To: <45E0EBD6.2010008@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, stable@kernel.org

On Sat, 24 Feb 2007 20:52:22 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Tejun Heo wrote:
> > 80c test mask is at bits 18 and 19 of EIDE Controller Configuration
> > not 22 and 23.  Fix it.
> > 
> > Signed-off-by: Tejun Heo <htejun@gmail.com>
> > ---
> > This makes unreliable cable detection even more unreliable.  Please
> > consider for -stable.  Thanks.

At minimum you also need to stop doing drive side detect for PATA_CBL_80
as many controllers don't do both so if you've got host side detect that
is what you must trust.

Fixed that in my internal tree and it seems happier
