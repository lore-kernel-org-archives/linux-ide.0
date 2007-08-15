From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] libata: move ata_altstatus() to pio data xfer functions
Date: Wed, 15 Aug 2007 03:19:58 -0400
Message-ID: <46C2A91E.2040002@garzik.org>
References: <468B5930.3070000@tw.ibm.com> <468B5A2D.9030700@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33063 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753072AbXHOHUA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 03:20:00 -0400
In-Reply-To: <468B5A2D.9030700@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Patch 1/2:
>  Move ata_altstatus() out from ata_hsm_move() to the pio data xfer functions
> like ata_pio_sectors() and atapi_pio_bytes() where it makes more sense.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> atapi_send_cdb() already calls ata_altstatus() inside.
> This patch makes ata_pio_sectors() and atapi_pio_bytes() do the same.

applied


