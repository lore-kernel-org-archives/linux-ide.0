From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_cmd64x: Set up MWDMA modes properly
Date: Fri, 10 Aug 2007 00:21:21 +0100
Message-ID: <20070810002121.4c12e5a1@the-village.bc.nu>
References: <200708092309.l79N9DAP016291@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53485 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753902AbXHIXOF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 19:14:05 -0400
In-Reply-To: <200708092309.l79N9DAP016291@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

On Fri, 10 Aug 2007 01:09:13 +0200 (MEST)
Mikael Pettersson <mikpe@it.uu.se> wrote:

> On Wed, 8 Aug 2007 14:33:20 +0100, Alan Cox wrote:
> > Set the MWDMA timing by updating the correct registers. Split the PIO
> > path as this is mostly shared code. Wants testing.
> 
> Works fine on my CMD646 SPARC Ultra5.

Thanks
