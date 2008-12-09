From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 1/3] pata_hpt366: fix clock detection
Date: Tue, 09 Dec 2008 00:49:58 -0500
Message-ID: <493E0706.8020900@garzik.org>
References: <493CED7A.2010505@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33469 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbYLIFuD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Dec 2008 00:50:03 -0500
In-Reply-To: <493CED7A.2010505@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

Tejun Heo wrote:
> pata_hpt366 had its clock detection wrong and detected 25Mhz as 40Mhz
> and vice-versa.  Fix it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/pata_hpt366.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: work/drivers/ata/pata_hpt366.c
> ===================================================================
> --- work.orig/drivers/ata/pata_hpt366.c
> +++ work/drivers/ata/pata_hpt366.c
> @@ -382,10 +382,10 @@ static int hpt36x_init_one(struct pci_de
>  	/* PCI clocking determines the ATA timing values to use */
>  	/* info_hpt366 is safe against re-entry so we can scribble on it */
>  	switch((reg1 & 0x700) >> 8) {
> -		case 5:
> +		case 9:
>  			hpriv = &hpt366_40;
>  			break;
> -		case 9:
> +		case 5:
>  			hpriv = &hpt366_25;

applied #upstream-fixes

Avoiding patch #2 in this series b/c the thread seemed to indicate it 
needed more work

Avoiding patch #3 in this series awaiting Alan's ack (did I miss it?)


