From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.16.16] sata_sil24: SII3124 sata driver endian problem
Date: Mon, 05 Jun 2006 05:24:29 +0900
Message-ID: <4483417D.8060109@gmail.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DDFF@ismail.innsys.innovsys.com> <DCEAAC0833DD314AB0B58112AD99B93B0189DE08@ismail.innsys.innovsys.com> <20060602163035.05ab7c71.akpm@osdl.org> <20060604161124.GA7587@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:39267 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932073AbWFDUYl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Jun 2006 16:24:41 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1029195nze
        for <linux-ide@vger.kernel.org>; Sun, 04 Jun 2006 13:24:40 -0700 (PDT)
In-Reply-To: <20060604161124.GA7587@martell.zuzino.mipt.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Rune Torgersen <runet@innovsys.com>, jgarzik@pobox.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alexey Dobriyan wrote:
> Are there some other fields that should be marked?

Yeap, prot and rx_cnt of sil24_prb should also be marked __le.  Also, 
all fields of sil24_port_multiplier

Thanks.

> [PATCH] sata_sil24: endian annotations
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/scsi/sata_sil24.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> --- a/drivers/scsi/sata_sil24.c
> +++ b/drivers/scsi/sata_sil24.c
> @@ -37,7 +37,7 @@
>   * Port request block (PRB) 32 bytes
>   */
>  struct sil24_prb {
> -	u16	ctrl;
> +	__le16	ctrl;
>  	u16	prot;
>  	u32	rx_cnt;
>  	u8	fis[6 * 4];
> @@ -47,9 +47,9 @@ struct sil24_prb {
>   * Scatter gather entry (SGE) 16 bytes
>   */
>  struct sil24_sge {
> -	u64	addr;
> -	u32	cnt;
> -	u32	flags;
> +	__le64	addr;
> +	__le32	cnt;
> +	__le32	flags;
>  };
>  
>  /*

-- 
tejun
