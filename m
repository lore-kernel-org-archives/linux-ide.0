From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] libata-dev: Convert pdc2027x from PIO to MMIO
Date: Wed, 10 Aug 2005 23:03:08 -0400
Message-ID: <42FABFEC.8080600@pobox.com>
References: <42F24DBE.0@tw.ibm.com> <42F25114.1050009@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:56738 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932228AbVHKDDW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2005 23:03:22 -0400
In-Reply-To: <42F25114.1050009@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Jeff,
> 
> Patch 1/3: Convert pdc2027x from PIO to MMIO
> 
> Description:
>     Indexed registers need two PIO accesses: one access writes to the 
> index register and the other access
> reads/writes the indexed register. Using MMIO can access the register 
> directly and simplify the code.
> 
> Changes:
>   - Use MMIO instead of PIO and indexed registers.
>   - Minor fix such as add ata_host_stop hook and indent beautification, 
> etc.

Comments:

1) port_mmio() and dev_mmio() should be static inline

2) The -only- valid way to flush a write to the device across the PCI 
bus is with a corresponding read[bwl]().  wmb() is not sufficient.

	Jeff


