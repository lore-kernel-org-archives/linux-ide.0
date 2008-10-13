From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 04/49] pcmcia: use pcmcia_loop_config in pata and ide drivers
Date: Mon, 13 Oct 2008 20:26:56 +0200
Message-ID: <20081013182656.GA29664@isilmar.linta.de>
References: <20081013173803.GA18569@comet.dominikbrodowski.net> <1223920114-19788-4-git-send-email-linux@dominikbrodowski.net> <20081013191900.446abf29@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:35128 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751468AbYJMS07 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Oct 2008 14:26:59 -0400
Content-Disposition: inline
In-Reply-To: <20081013191900.446abf29@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-pcmcia@lists.infradead.org, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Mon, Oct 13, 2008 at 07:19:00PM +0100, Alan Cox wrote:
> 
> > +	/* Not sure if this is right... look up the current Vcc */
> 
> Not reassuring for a patch going upstream ? or is it just a stale
> comment ?

Stale comment to be found on the many places which get unified using this
function.

Best,
	Dominik
