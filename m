From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: disable 64bit DMA by default on
 SB600s
Date: Tue, 06 Oct 2009 00:23:34 -0400
Message-ID: <4ACAC646.9050606@garzik.org>
References: <4AC71901.6010005@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55413 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbZJFEYP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Oct 2009 00:24:15 -0400
In-Reply-To: <4AC71901.6010005@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Shane Huang <Shane.Huang@amd.com>, stable@kernel.org, balducci@units.it, maierp@informatik.tu-muenchen.de

On 10/03/2009 05:27 AM, Tejun Heo wrote:
> Till now only one board, ASUS M2A-VM, can do 64bit dma with recent
> BIOSen.  Enabling 64bit DMA by default already broke three boards.
> Enabling 64bit DMA isn't worth these regressions.  Disable 64bit DMA
> by default and enable it only on boards which are known to work.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Gabriele Balducci<balducci@units.it>
> Reported-by: maierp@informatik.tu-muenchen.de
> Cc: Shane Huang<shane.huang@amd.com>
> Cc: stable@kernel.org
> ---
>   drivers/ata/ahci.c |   60 +++++++++++++++++------------------------------------
>   1 file changed, 20 insertions(+), 40 deletions(-)

applied


