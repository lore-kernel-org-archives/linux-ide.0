From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: support for SiS AHCI controller in SiS966/SiS968
Date: Wed, 06 Sep 2006 10:53:05 -0400
Message-ID: <44FEE0D1.90006@pobox.com>
References: <OFD4641DBA.8DD06DEC-ON482571DB.00364E08@sis.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:20953 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751214AbWIFOxI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Sep 2006 10:53:08 -0400
In-Reply-To: <OFD4641DBA.8DD06DEC-ON482571DB.00364E08@sis.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Wang <touch@sis.com>
Cc: "inux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

David Wang wrote:
> diff -up a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
> --- a/drivers/scsi/ahci.c       2006-08-24 05:16:33.000000000 +0800
> +++ b/drivers/scsi/ahci.c       2006-08-31 16:36:03.000000000 +0800
> @@ -296,6 +296,12 @@
>           board_ahci }, /* ATI SB600 non-raid */
>         { PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>           board_ahci }, /* ATI SB600 raid */
> +       { PCI_VENDOR_ID_SI, 0x1184, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +         board_ahci }, /* SiS 966, 1184 RAID */
> +       { PCI_VENDOR_ID_SI, 0x1185, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +         board_ahci }, /* SiS 966, 1185 AHCI */
> +       { PCI_VENDOR_ID_SI, 0x0186, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +         board_ahci }, /* SiS 968, 186 AHCI 3Gbps */
>         { }     /* terminate list */


These are in the #upstream branch, FWIW...

	Jeff


