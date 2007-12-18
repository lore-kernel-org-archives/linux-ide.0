From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 12/15] libata: make qc->nbytes include extra buffers
Date: Tue, 18 Dec 2007 16:44:03 -0500
Message-ID: <47683F23.4020504@garzik.org>
References: <11968405951262-git-send-email-htejun@gmail.com> <11968405981339-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48171 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010AbXLRVoG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 16:44:06 -0500
In-Reply-To: <11968405981339-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> qc->nbytes didn't use to include extra buffers setup by libata core
> layer and my be odd.  This patch makes qc->nbytes include any extra
> buffers setup by libata core layer and guaranteed to be aligned on 4
> byte boundary.
> 
> This value is to be used to program the host controller.  As this
> represents the actual length of buffer available to the controller and
> the controller must be able to deal with short transfers for ATAPI
> commands which can transfer variable length, this shouldn't break any
> controllers while making problems like rounding-down and controllers
> choking up on odd transfer bytes much less likely.
> 
> The unmodified value is stored in new field qc->raw_nbytes.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   14 ++++++++++----
>  include/linux/libata.h    |    3 ++-
>  2 files changed, 12 insertions(+), 5 deletions(-)

applied 9-12 to #upstream


