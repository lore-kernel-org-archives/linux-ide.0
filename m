From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: limit post SRST nsect/lbal wait to ~100ms
Date: Sun, 10 Jun 2007 12:23:08 -0400
Message-ID: <466C256C.9040509@garzik.org>
References: <9d2cd630705270801m2826be60p3f802c502b26c531@mail.gmail.com> <466196AD.3090502@garzik.org> <9d2cd630706031046n2bd77585o7c0df1c5fea5167f@mail.gmail.com> <46667466.4010500@gmail.com> <9d2cd630706062322v2d73b32dp1da56f97e2069fff@mail.gmail.com> <4667B347.9040900@gmail.com> <alpine.LFD.0.98.0706071352440.4205@woody.linux-foundation.org> <20070607224746.GA23290@havoc.gtf.org> <alpine.LFD.0.98.0706091054360.20321@woody.linux-foundation.org> <466AF98C.80101@garzik.org> <20070610052620.GH29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39063 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228AbXFJQXN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Jun 2007 12:23:13 -0400
In-Reply-To: <20070610052620.GH29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>

Tejun Heo wrote:
> After SRST, libata used to wait for nsect/lbal to be set to 1/1 for
> the slave device.  However, some ATAPI devices don't set nsect/lbal
> after SRST and the wait itself isn't too useful as we're gonna wait
> for !BSY right after that anyway.
> 
> Before reset-seq update, nsect/lbal wait failure used to be ignored
> and caused 30sec delay during detection.  After reset-seq, all
> timeouts are considered error conditions making libata fail to detect
> such ATAPI devices.
> 
> This patch limits nsect/lbal wait to around 100ms.  This should give
> acceptable behavior to such ATAPI devices while not disturbing the
> heavily used code path too much.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Okay, here it is.  Sorry for the delay.
> 
>  drivers/ata/libata-core.c |   32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)

Thanks.  Maybe Gregor can confirm this fixes his problem?

I'll ACK and push upstream then...


