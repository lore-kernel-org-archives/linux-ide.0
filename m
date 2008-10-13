From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/49] pcmcia: use pcmcia_loop_config in pata and ide
 drivers
Date: Mon, 13 Oct 2008 19:19:00 +0100
Message-ID: <20081013191900.446abf29@lxorguk.ukuu.org.uk>
References: <20081013173803.GA18569@comet.dominikbrodowski.net>
	<1223920114-19788-4-git-send-email-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42729 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758093AbYJMSTG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 14:19:06 -0400
In-Reply-To: <1223920114-19788-4-git-send-email-linux@dominikbrodowski.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org, Dominik Brodowski <linux@dominikbrodowski.net>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org


> +	/* Not sure if this is right... look up the current Vcc */

Not reassuring for a patch going upstream ? or is it just a stale
comment ?

Alan
