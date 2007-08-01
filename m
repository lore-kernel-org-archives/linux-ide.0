From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-sff; Unbreak non DMA capable controllers again
Date: Wed, 01 Aug 2007 10:01:49 -0400
Message-ID: <46B0924D.9070604@garzik.org>
References: <20070726184130.68f6c8ac@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41645 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933015AbXHAOBw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Aug 2007 10:01:52 -0400
In-Reply-To: <20070726184130.68f6c8ac@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Seems nobody else is checking/testing this case as it keeps getting
> horked.
> 
> If we have no BAR4 mapping on an SFF controller this is *NOT* an error,
> it just means it isn't doing BMDMA.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied to #upstream-fixes


