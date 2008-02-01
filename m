From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: implement libata.force module parameter
Date: Fri, 01 Feb 2008 12:28:35 -0500
Message-ID: <47A356C3.3010904@garzik.org>
References: <47A3375F.80101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55422 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756705AbYBAR2h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 12:28:37 -0500
In-Reply-To: <47A3375F.80101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

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
> I guess it's about time we add something like this.  More than
> anything else this should help debugging and can serve as a last
> resort to work around problems.
> 
> Thanks.
> 
>  Documentation/kernel-parameters.txt |   35 +++
>  drivers/ata/libata-core.c           |  375 +++++++++++++++++++++++++++++++++++-
>  drivers/ata/libata-eh.c             |    8 
>  drivers/ata/libata.h                |    1 
>  4 files changed, 415 insertions(+), 4 deletions(-)

ACK, but it breaks the build due to section type conflicts:

drivers/ata/libata-core.c:108: error: ata_force_param_buf causes a 
section type conflict

Given that the data is marked __initdata and the code is marked __init, 
I cannot see the problem.

