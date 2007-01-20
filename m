From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.20-rc4] sata_promise: ATAPI cleanup
Date: Fri, 19 Jan 2007 19:12:47 -0500
Message-ID: <45B15E7F.1080005@garzik.org>
References: <200701100832.l0A8WYat017411@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53716 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932617AbXATAMu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Jan 2007 19:12:50 -0500
In-Reply-To: <200701100832.l0A8WYat017411@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> Here's a cleanup for yesterday's sata_promise ATAPI patch:
> - add and use a symbolic constant for the altstatus register
> - check return status from ata_busy_wait()
> - add missing newline in a warning printk()
> - update comment in pdc_issue_atapi_pkt_cmd() to clarify
>   that the maybe-wait-for-INT issue cannot occur in the
>   current driver, but may occur if the driver starts issuing
>   ATAPI non-DMA commands as PDC packets
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

applied


