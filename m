From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/3] libata ata_data_xfer() fix
Date: Mon, 01 Aug 2005 14:36:51 -0400
Message-ID: <42EE6BC3.1040401@pobox.com>
References: <42EE37AB.2000006@tw.ibm.com> <42EE392B.8000405@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:58849 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261155AbVHASgz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Aug 2005 14:36:55 -0400
In-Reply-To: <42EE392B.8000405@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Jeff,
> 
> PATCH 2/3: ata_data_xfer() fix
> 
> Changes:
>   - Add ATA_FLAG_IO_32BIT to libata.h for hosts with 32-bit data register.
>   - Modify ata_mmio_data_xfer() and ata_pio_data_xfer() to handle buffer 
> length
>     not aligned to 32-bit boundary.
> 
> This patch does not reuse ap->pad as alignment buffer since
> four bytes of local variable seems good enough.

32-bit IO needs to be a separate patch.

I made a design decision to -not- support 32bit IO, since it is not 
universally supported by all host controllers.  It is much easier to say 
"use DMA" instead.

libata would need additional checks, following similar logic in 
drivers/ide, to do 32-bit IO.

	Jeff


