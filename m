From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/2] libata PIO fixes (revised)
Date: Fri, 12 Aug 2005 02:45:11 -0400
Message-ID: <42FC4577.7050400@pobox.com>
References: <42FC3D2F.1030803@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:34730 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751057AbVHLGpU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Aug 2005 02:45:20 -0400
In-Reply-To: <42FC3D2F.1030803@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Jeff,
> 
> The PIO fixes revised according to the previous reviews.
> 
> 1/2 pio1.diff:
>   - Modify ata_mmio_data_xfer() and ata_pio_data_xfer() to handle buffer 
> with odd length.
> 
> 2/2 pio2.diff:
>   - Modify __atapi_pio_bytes() to handle the case where device 
> returns/needs extra data.

Applied both patches, thanks much.

	Jeff



