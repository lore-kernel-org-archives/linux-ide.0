From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] pata_hpt37x: actually clock HPT374 by 50 MHz DPLL
Date: Sun, 5 Aug 2007 20:23:59 +0100
Message-ID: <20070805202359.41fd0236@the-village.bc.nu>
References: <200708052245.16406.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35044 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753506AbXHETSY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Aug 2007 15:18:24 -0400
In-Reply-To: <200708052245.16406.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, rah@bash.sh

>  		/* Compute DPLL */
> -		dpll = 2;
> -		if (port->udma_mask & 0xE0)
> -			dpll = 3;
> +		dpll = (port->udma_mask & 0xC0) ? 3 : 2;

Gak, I'd much rather people kept to the nice easy to read if() but fine

is_author_p()?Signed-off-by:Acked-by Alan Cox <alan@redhat.com>

