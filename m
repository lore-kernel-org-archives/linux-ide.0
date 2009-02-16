From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata-sff: fix 32-bit PIO ATAPI regression
Date: Mon, 16 Feb 2009 18:56:10 -0500
Message-ID: <4999FD1A.3080407@pobox.com>
References: <200902152224.25144.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45785 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbZBPX4R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Feb 2009 18:56:17 -0500
In-Reply-To: <200902152224.25144.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, rjw@sisk.pl, akpm@linux-foundation.org

Sergei Shtylyov wrote:
> Commit 871af1210f13966ab911ed2166e4ab2ce775b99d (libata: Add 32bit PIO support)
> has caused all kinds of errors on the ATAPI devices, so it has been empirically
> proven that one shouldn't try to read/write an extra data word when a device is
> not expecting it already. "Don't do it then"; however, still use a chance to do
> 32-bit read/write one last time when there are exactly 3 trailing bytes.
> 
> Oh, and stop pointlessly swapping the bytes to and fro on big-endian machines
> by using io*_rep() accessors which shouldn't byte-swap.
> 
> This patch should fix the kernel.org bug #12609.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> Added the comments and signoff.
> The patch is against the recent Linus' tree.
> It's a hopefully better replacement for Hugh Dickins most recent patch
> (http://marc.info/?l=linux-ide&m=123352294619281)...

applied, much appreciated!


