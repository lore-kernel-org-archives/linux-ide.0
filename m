From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [2.6 patch] make ata_scsi_lpm_get() static
Date: Sat, 03 Nov 2007 08:48:20 -0400
Message-ID: <472C6E14.5050101@garzik.org>
References: <20071030235023.GT7227@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35155 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680AbXKCMsZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2007 08:48:25 -0400
In-Reply-To: <20071030235023.GT7227@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> ata_scsi_lpm_get() can become static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 380046f657271be470566bb5c762c1599569bac6 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 93bd36c..c4f0c6c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -120,7 +120,7 @@ static const struct {
>  	{ MEDIUM_POWER, "medium_power" },
>  };
>  
> -const char *ata_scsi_lpm_get(enum link_pm policy)
> +static const char *ata_scsi_lpm_get(enum link_pm policy)
>  {
>  	int i;
>  

applied


