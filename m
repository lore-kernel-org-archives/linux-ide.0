From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: [PATCH] ide: Fix crash on repeated reset
Date: Mon, 4 Sep 2006 21:38:07 +0200
Message-ID: <20060904193807.GA6118@rhlx01.fht-esslingen.de>
References: <1157378041.30801.78.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:17640 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S964970AbWIDTiI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Sep 2006 15:38:08 -0400
Content-Disposition: inline
In-Reply-To: <1157378041.30801.78.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 04, 2006 at 02:54:01PM +0100, Alan Cox wrote:
>  	unsigned int sleeping	: 1;
>  		/* BOOL: polling active & poll_timeout field valid */
>  	unsigned int polling	: 1;
> +	 	/* BOOL: in a polling reset situation. Must not trigger another reset yet */
> +	unsigned	resetting  : 1;
> +

Inconsistent variable type declarations/formatting?

Andreas Mohr
