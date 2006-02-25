From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/3] sata_sil: clean up and add errata/workaround documentation
Date: Sat, 25 Feb 2006 02:29:19 -0500
Message-ID: <4400074F.3020005@pobox.com>
References: <11408431501105-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:9960 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932437AbWBYH3Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Feb 2006 02:29:25 -0500
In-Reply-To: <11408431501105-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, hellan@acm.org, Carlos.Pardo@siliconimage.com, Raymond.Liu@siliconimage.com

Tejun Heo wrote:
> This patch collects into one place/update errata documentattion and
> adds description of 3114 R_ERR on DMA activate FIS errata.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/sata_sil.c |   97 ++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 75 insertions(+), 22 deletions(-)
> 
> 6b1cc9dff33ae20157946ae8b06f1a11079b4af6
> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
> index 9face3c..75784cd 100644
> --- a/drivers/scsi/sata_sil.c
> +++ b/drivers/scsi/sata_sil.c
> @@ -30,8 +30,79 @@
>   *  Documentation for SiI 3112:
>   *  http://gkernel.sourceforge.net/specs/sii/3112A_SiI-DS-0095-B2.pdf.bz2
>   *
> + *  Documentation for SiI 3114:
> + *  http://gkernel.sourceforge.net/specs/sii/sii-0680a-v1.31.pdf.bz2
> + *
>   *  Other errata and documentation available under NDA.

I'll apply patches 1-2.

For this patch #3, two comments:

* the above URL points to CMD680 docs, not 3114

* I'm unconvinced that long exposition should be in the .c file.  I 
think its far better to put it into Documentation/DocBook/libata.tmpl. 
I have some long term plans to add more hardware details to the docbook 
docs, infact.

	Jeff



