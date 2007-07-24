From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_hpt37x: Fix 2.6.22 clock PLL regression
Date: Tue, 24 Jul 2007 16:56:20 -0400
Message-ID: <46A66774.3070702@garzik.org>
References: <20070724151748.7e99f4f0@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59225 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932742AbXGXU4X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jul 2007 16:56:23 -0400
In-Reply-To: <20070724151748.7e99f4f0@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> 	Just one version of Linux ago
> 	The PLL code broke - oh no!
> 	But set the right mode
> 	And fix up the code
> 	Makes the PLL timing sync go
> 
> Closes-bug: #8791
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


