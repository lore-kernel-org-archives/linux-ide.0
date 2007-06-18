From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [BUG] ide dma_timer_expiry, then hard lockup
Date: Mon, 18 Jun 2007 16:22:38 -0500
Message-ID: <20070618212238.GI5836@austin.ibm.com>
References: <20070618175713.GD5836@austin.ibm.com> <20070618212704.394912b8@the-village.bc.nu> <20070618204601.GF5836@austin.ibm.com> <20070618220441.3a3af8ca@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:37449 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759098AbXFRVWr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 17:22:47 -0400
Content-Disposition: inline
In-Reply-To: <20070618220441.3a3af8ca@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 18, 2007 at 10:04:41PM +0100, Alan Cox wrote:
> 
> If you've got a nice repeatable problem 

Very highly repeatable :-(

> please try using the libata
> driver. That handles the error paths differently and doesn't try a FIFO
> drain which might matter in this case I guess.

Dohh, yes, of course. Completely forgot about that. (I assume you mean 
CONFIG_ATA).  Will report tommorrow.

--linas
