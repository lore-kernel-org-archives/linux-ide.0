From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH]: Add id_to_dma_mode function for printing DMA modes
Date: Sun, 25 Feb 2007 15:57:00 -0500
Message-ID: <45E1F81C.3050504@garzik.org>
References: <20070220180159.632d33bc@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34801 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419AbXBYU5D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Feb 2007 15:57:03 -0500
In-Reply-To: <20070220180159.632d33bc@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan wrote:
> Also export dev_disable as this is needed by drivers doing slave decode
> filtering, which will follow shortly
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied



