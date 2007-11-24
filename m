From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 07/12] libata: fix ata_acpi_gtm_xfermask()
Date: Fri, 23 Nov 2007 20:16:32 -0500
Message-ID: <47477B70.2000706@garzik.org>
References: <1194327550227-git-send-email-htejun@gmail.com> <1194327551238-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45370 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732AbXKXBQe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 20:16:34 -0500
In-Reply-To: <1194327551238-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_acpi_gtm_xfermask() as separated out from pacpi_discover_modes()
> has various bugs.  Fix them.
> 
> * The wrong comparison operator is used when finding for matching
>   cycle resulting totally bogus result.
> 
> * With the comparion operator fixed, boundary condtion handling is
>   clumsy.
> 
> * Setting of any DMA mask bit set all bits in PIO mask.
> 
> * MWDMA and UDMA blocks are swapped.

shouldn't this be combined with patch #6?


