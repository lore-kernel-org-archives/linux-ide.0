From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata: kill now unused n_iter and fix sata_fsl
Date: Wed, 06 Feb 2008 07:03:45 -0500
Message-ID: <47A9A221.9050403@garzik.org>
References: <47A7EED3.2050801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40517 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761363AbYBFMDr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Feb 2008 07:03:47 -0500
In-Reply-To: <47A7EED3.2050801@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Li Yang <leoli@freescale.com>

Tejun Heo wrote:
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> qc->n_iter was used for libata's own sg walking before sg chaining
> replaced it.  During conversion, the field and its usage in sata_fsl
> were left behind.  Kill the filed and update sata_fsl.
> 
> tj: This was part of James's libata-use-block-layer-padding patch.
>     Separated out by me.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Li Yang <leoli@freescale.com>

applied


