From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] Don't change transfer speed while requests are in
 flight
Date: Wed, 21 Feb 2007 13:12:59 +0000
Message-ID: <20070221131259.3817762d@lxorguk.ukuu.org.uk>
References: <20070221012112.GB1777@freefall.freebsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48753 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751233AbXBUMJQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 07:09:16 -0500
In-Reply-To: <20070221012112.GB1777@freefall.freebsd.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> +	 * If we are in an interrupt, it should be safe to issue
> +	 * SETFEATURES manually, since there shouldn't be any requests in
> +	 * flight.

There may be error recovery going on from a timeout on another processor.
I don't see how your code protects against that (and the old code is
broken too)

