From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_sil24: fix mwdma_mask setting
Date: Sun, 05 Mar 2006 11:11:50 -0500
Message-ID: <440B0DC6.2030907@pobox.com>
References: <20060305140342.GA7702@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:29907 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932178AbWCEQLw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 11:11:52 -0500
In-Reply-To: <20060305140342.GA7702@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> mwdma_mask was not copied from port_info to probe_ent.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
> This bug is probably introduced by following ahci.c without thinking
> (by me).
> 
>  drivers/scsi/sata_sil24.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

applied


