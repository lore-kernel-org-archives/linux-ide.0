From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_pdc202xx_old: Further fixups
Date: Thu, 10 Jan 2008 16:54:41 -0500
Message-ID: <47869421.60401@garzik.org>
References: <20080104000849.588592ea@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33690 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756101AbYAJVyp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jan 2008 16:54:45 -0500
In-Reply-To: <20080104000849.588592ea@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Turns out distros always enabled burst mode and it is pretty essential so
> do the same. Also sort out the post DMA mode restore properly.
> 
> My 20263 card now seems happy but needs some four drive tests done yet
> (when I've persuaded the kernel not to hang in the edd boot code if I
> plug them in ..)
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied #upstream-fixes


