From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] pata_pdc2027x: Restore various updates done on the driver
Date: Thu, 15 Mar 2007 14:04:54 +0800
Message-ID: <45F8E206.2000206@tw.ibm.com>
References: <20070308233920.7371d07d@lxorguk.ukuu.org.uk>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:48865 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422824AbXCOGFN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 02:05:13 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l2F63fSx006471
	for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 02:03:41 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2F65D5t044456
	for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 00:05:13 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2F65BAg001298
	for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 00:05:11 -0600
In-Reply-To: <20070308233920.7371d07d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> - Use of cable_detect method
> - ata_pci_default_filter needed on PATA100 ops
> - Filter for UDMA 133 errata from vendor (not enabled in this diff but
> added ready)
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
 <snip>
>  
>  /**
> + *	pdc2720x_mode_filter	-	mode selection filter
> + *	@adev: ATA device
> + *	@mask: list of modes proposed
> + *
> + *	Block UDMA on devices that cause trouble with this controller.
> + */
> +
> +static unsigned long pdc2027x_mode_filter(struct ata_device *adev, unsigned long mask)
> +{
> +	unsigned char model_num[ATA_ID_PROD_LEN + 1];
> +	struct ata_device *pair = ata_dev_pair(adev);
> +	
> +	if (adev->class != ATA_DEV_ATA || adev->devno == 0 || pair == NULL)
> +		return ata_pci_default_filter(adev, mask);
> +
> +	/* Check for slave of a Maxtor at UDMA6 */
> +	ata_id_c_string(pair->id, model_num, ATA_ID_PROD,
> +			  ATA_ID_PROD_LEN + 1);
> +	/* If the master is a maxtor in UDMA6 then the slave should not use UDMA 6 */
> +	if(strstr(model_num, "Maxtor") == 0 && pair->dma_mode == XFER_UDMA_6)
> +		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));

Some Maxtor drives have "Maxtor" while others have "MAXTOR" in the IDENTIFY data.
Should we check both "Maxtor" and "MAXTOR" here?

--
albert

> +	
> +	return ata_pci_default_filter(adev, mask);
> +}
> +
> +/**


