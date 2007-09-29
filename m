From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_pdc202xx_old
Date: Sat, 29 Sep 2007 02:23:04 -0400
Message-ID: <46FDEF48.5050806@garzik.org>
References: <20070926152317.67f4d6fd@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33928 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943AbXI2GXF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Sep 2007 02:23:05 -0400
In-Reply-To: <20070926152317.67f4d6fd@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> I've been doing an audit of this driver to try and find out why we have
> problems with some Clevo boxes that use it. Didn't get anywhere other
> than to discover all the bug reporters I have use vmware, which may or
> may not be chance.
> 
> In the process however I did find out our MWDMA2 performance was a bit
> low and code review showed the MWDMA0/2 timings are reversed due to a
> thinko in the table ordering
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied, after fixing Subject to be useful


