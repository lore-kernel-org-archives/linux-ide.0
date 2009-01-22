From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 04/05] sata_mv: msi masking fix (v2)
Date: Thu, 22 Jan 2009 10:02:29 +0900
Message-ID: <4977C5A5.8070202@gmail.com>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca> <49750774.1070005@rtr.ca> <49773FD1.3040101@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:54998 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645AbZAVBCa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jan 2009 20:02:30 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1805504qwe.37
        for <linux-ide@vger.kernel.org>; Wed, 21 Jan 2009 17:02:28 -0800 (PST)
In-Reply-To: <49773FD1.3040101@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Mark.

Mark Lord wrote:
> Enable reliable use of Message-Signaled Interrupts (MSI) in sata_mv
> by masking further chip interrupts within the main interrupt handler.
> 
> Based upon a suggestion by Grant Grundler.
> MSI is working reliably in all of my test systems here now.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

Generally looks good, but...

> +    /* Enable message-switched interrupts, if requested */
> +    if (msi && 0 == pci_enable_msi(pdev))
> +        hpriv->hp_flags |= MV_HP_FLAG_MSI;

I just don't like CONSTANT OP EXPRESSION construct.  The only possible
upside it has is that it would make the compiler fail if '=' is used
instead of '==' but compiler has been smart enough to whine about
LVALUE = EXPRESSION for a very long time now.  How about plain
!pci_enable_msi(pdev) or pci_enable_msi(pdev) == 0?

Thanks.

-- 
tejun
