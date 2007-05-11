From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: ignore EH scheduling during initialization
Date: Fri, 11 May 2007 18:10:05 -0400
Message-ID: <4644E9BD.3070607@garzik.org>
References: <46370D57.1070504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43577 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbXEKWKI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2007 18:10:08 -0400
In-Reply-To: <46370D57.1070504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Berck E. Nash" <flyboy@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> libata enables SCSI host during ATA host activation which happens
> after IRQ handler is registered and IRQ is enabled.  All ATA ports are
> in frozen state when IRQ is enabled but frozen ports may raise limited
> number of IRQs after being frozen - IOW, ->freeze() is not responsible
> for clearing pending IRQs.  During normal operation, the IRQ handler
> is responsible for clearing spurious IRQs on frozen ports and it
> usually doesn't require any extra code.
> 
> Unfortunately, during host initialization, the IRQ handler can end up
> scheduling EH for a port whose SCSI host isn't initialized yet.  This
> results in OOPS in the SCSI midlayer.  This is relatively short window
> and scheduling EH for probing is the first thing libata does after
> initialization, so ignoring EH scheduling until initialization is
> complete solves the problem nicely.
> 
> This problem was spotted by Berck E. Nash in the following thread.
> 
>   http://thread.gmane.org/gmane.linux.kernel/519412
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Berck E. Nash <flyboy@gmail.com>

applied


