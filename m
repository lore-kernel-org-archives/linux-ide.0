From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/1] [v3] Add support 2 SATA ports for Maui and change
 filename from sata_dwc_460ex.c to sata_dwc_4xx.c
Date: Fri, 06 Apr 2012 16:10:29 +0400
Message-ID: <4F7EDD35.3070203@mvista.com>
References: <1333690265-27857-1-git-send-email-tqnguyen@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51397 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598Ab2DFMMC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Apr 2012 08:12:02 -0400
Received: by bkcik5 with SMTP id ik5so2092815bkc.19
        for <linux-ide@vger.kernel.org>; Fri, 06 Apr 2012 05:12:01 -0700 (PDT)
In-Reply-To: <1333690265-27857-1-git-send-email-tqnguyen@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Thang Q. Nguyen" <tqnguyen@apm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Phong Vo <pvo@apm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hello.

On 06-04-2012 9:31, Thang Q. Nguyen wrote:

> Signed-off-by: Thang Q. Nguyen<tqnguyen@apm.com>
> ---
> Changes for v2:
>         - Use git rename feature to change the driver to the newname and for
>           easier review.

> Changes for v3:
> 	- Remove materials not related to 2 SATA ports support. They will
> 	 be added in another patches.

>   drivers/ata/Makefile                             |    2 +-
>   drivers/ata/{sata_dwc_460ex.c =>  sata_dwc_4xx.c} |  820 +++++++++++-----------
>   2 files changed, 430 insertions(+), 392 deletions(-)
>   rename drivers/ata/{sata_dwc_460ex.c =>  sata_dwc_4xx.c} (73%)

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_4xx.c
> similarity index 73%
> rename from drivers/ata/sata_dwc_460ex.c
> rename to drivers/ata/sata_dwc_4xx.c
> index 69f7cde..07e9b36 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_4xx.c
[...]
> @@ -16,6 +14,15 @@
>    * under  the terms of  the GNU General  Public License as published by the
>    * Free Software Foundation;  either version 2 of the  License, or (at your
>    * option) any later version.
> + *
> + * CHANGES:
> + * - Version 1.4:
> + *   + Change filename from sata_dwc_460ex.c to sata_dwc_4xx.c
> + *   + This driver supports more than one SATA port. Each SATA port has its
> + *     own private attribute. Move sata_dwc_host_priv structure to
> + *     sata_dwc_device and sata_dwc_device_port structures.
> + *   + Change to use ata_bmdma_qc_issue and ata_bmdma_error_handler because
> + *     the ata_sff_qc_issue and ata_sff_error_handler no longer support DMA.

    This modification looks like a bug fix, and so should be separated and 
posted before the dual-port patch.

    I'll try to do more deltailed review on the weekend.

MBR, Sergei
