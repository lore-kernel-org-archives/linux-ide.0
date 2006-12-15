From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] libata updates
Date: Fri, 15 Dec 2006 01:14:04 +0000
Message-ID: <20061215011404.0154fbf7@localhost.localdomain>
References: <20061214230840.GA25006@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46367 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964832AbWLOBFw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Dec 2006 20:05:52 -0500
In-Reply-To: <20061214230840.GA25006@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

>  
> +config PATA_IT8213
> +	tristate "IT8213 PATA support (Experimental)"
> +	depends on PCI && EXPERIMENTAL
> +	help
> +	  This option enables support for the ITE 821 PATA

Typo (IT8213) - probably my fault but only just noticed it


