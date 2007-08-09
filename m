From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] pata_cmd64x: Set up MWDMA modes properly
Date: Fri, 10 Aug 2007 01:09:13 +0200 (MEST)
Message-ID: <200708092309.l79N9DAP016291@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:51256 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbXHIXJc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Aug 2007 19:09:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, alan@lxorguk.ukuu.org.uk, jeff@garzik.org, linux-ide@vger.kernel.org

On Wed, 8 Aug 2007 14:33:20 +0100, Alan Cox wrote:
> Set the MWDMA timing by updating the correct registers. Split the PIO
> path as this is mostly shared code. Wants testing.

Works fine on my CMD646 SPARC Ultra5.

/Mikael
