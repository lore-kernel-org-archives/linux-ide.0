From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pdc2027x: Switch properly to ioread/iowrite
Date: Thu, 20 Sep 2007 16:36:45 -0400
Message-ID: <46F2D9DD.5090105@garzik.org>
References: <20070920150712.33d2973a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43350 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbXITUgr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Sep 2007 16:36:47 -0400
In-Reply-To: <20070920150712.33d2973a@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Alan Cox wrote:
> Some iomap functions were still using readl/writel and friends which
> happens to work on most platforms but is not correct.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


