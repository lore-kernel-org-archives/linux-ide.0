From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Correct IORDY handling
Date: Tue, 31 Jul 2007 16:45:11 +0100
Message-ID: <20070731164511.4d2f81ee@the-village.bc.nu>
References: <20070731140148.4cb780de@the-village.bc.nu>
	<46AF44D3.3090608@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55034 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751064AbXGaPiK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 11:38:10 -0400
In-Reply-To: <46AF44D3.3090608@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> 
> > +			dev->pio_mode <= XFER_PIO_2)
> 
>     Overindented line (to my taste :-). And do we really need to check this?
> 

Yes - if it refuses SET_XFER_MODE we really don't want to run any mode
above PIO2. No hardware *should* do this but then this is IDE...
