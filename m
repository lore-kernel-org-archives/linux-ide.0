From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH][2.6.11.12] sata_nv.c patch for new NVIDIA device IDs
Date: Mon, 27 Jun 2005 00:14:01 -0400
Message-ID: <42BF7D09.20605@pobox.com>
References: <1119571630.1819.18.camel@dhcp-174-26.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:63693 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261791AbVF0EOP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2005 00:14:15 -0400
In-Reply-To: <1119571630.1819.18.camel@dhcp-174-26.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Punkunus <rpunkunus@nvidia.com>
Cc: blazara@nvidia.com, acurrid@nvidia.com, achew@nvidia.com, bzolnier@gmail.com, vojtech@suse.cz, gregkh@suse.de, linux-ide@vger.kernel.org

Rob Punkunus wrote:
> Signed-off-by: Rob Punkunus <rpunkunus@nvidia.com>

Can you please resend this patch?  Your mailer (Ximian Evolution?) 
corrupted it:

> 
>   *     - Added generic SATA support by using a pci_device_id that filters =
> on
>   *       the IDE storage class code.
> @@ -48,7 +54,7 @@
>  #include <linux/libata.h>
> =20
>  #define DRV_NAME                       "sata_nv"
> -#define DRV_VERSION                    "0.6"
> +#define DRV_VERSION                    "0.8"
> =20


