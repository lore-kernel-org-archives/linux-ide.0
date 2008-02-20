From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: implement libata.force module parameter
Date: Wed, 20 Feb 2008 12:13:07 -0500
Message-ID: <47BC5FA3.9050707@garzik.org>
References: <47A3375F.80101@gmail.com> <47B2368D.9080408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56994 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933468AbYBTRNK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Feb 2008 12:13:10 -0500
In-Reply-To: <47B2368D.9080408@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> This patch implements libata.force module parameter which can
> selectively override ATA port, link and device configurations
> including cable type, SATA PHY SPD limit, transfer mode and NCQ.
> 
> For example, you can say "use 1.5Gbps for all fan-out ports attached
> to the second port but allow 3.0Gbps for the PMP device itself, oh,
> the device attached to the third fan-out port chokes on NCQ and
> shouldn't go over UDMA4" by the following.
> 
>  libata.force=2:1.5g,2.15:3.0g,2.03:noncq,udma4
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Okay, the build failure is dependent on compiler version.  4.1.2 fails
> but 4.2.1 is okay.  I was using 4.2.1 so I didn't know about it.
> const is dropped from the offending structure and comment is added.
> 
>  Documentation/kernel-parameters.txt |   35 +++
>  drivers/ata/libata-core.c           |  380 +++++++++++++++++++++++++++++++++++-
>  drivers/ata/libata-eh.c             |    8 
>  drivers/ata/libata.h                |    1 
>  4 files changed, 420 insertions(+), 4 deletions(-)

applied


