From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] libata: call ata_check_atapi_dma() with qc better
 prepared
Date: Wed, 27 Jun 2007 02:50:20 -0400
Message-ID: <468208AC.1000004@garzik.org>
References: <20070626174735.GR29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38059 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758246AbXF0GuX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Jun 2007 02:50:23 -0400
In-Reply-To: <20070626174735.GR29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com

Tejun Heo wrote:
> In atapi_xlat(), prepare qc better before calling
> ata_check_atapi_dma() such that ata_check_atapi_dma() can use info
> from qc.  While at it, reformat weird looking if/else block in the
> function.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-scsi.c |   20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)

applied 1-3


