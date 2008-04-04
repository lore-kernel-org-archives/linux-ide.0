From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] pata_ali: disable ATAPI DMA
Date: Fri, 04 Apr 2008 02:47:34 -0400
Message-ID: <47F5CF06.9020208@garzik.org>
References: <47F46DE7.6090809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55823 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933AbYDDGrh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 02:47:37 -0400
In-Reply-To: <47F46DE7.6090809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> ATAPI DMA just doesn't work reliably on pata_ali.  The IDE driver can
> do it but for some mysterious reason, pata_ali can't.  This patch
> disables it by default and makes the driver whine during
> initialization.  "pata_ali.atapi_dma" parameter is added so that user
> can bypass the workaround.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> I just had another run with pata_ali.  I tried various things w/o any
> success.  I just can't see what's the difference between alim15x3 and
> pata_ali.  I again tried to make the command issue path of pata_ali +
> libata behave virtually identical to alim15x3 but it just didn't work.
> :-(  :-(  :-(
> 
> drivers/ata/pata_ali.c |   40 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 40 insertions(+)

applied


