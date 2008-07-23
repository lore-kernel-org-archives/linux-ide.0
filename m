From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/7] ata: add missing ATA_CMD_* defines
Date: Wed, 23 Jul 2008 16:46:40 -0400
Message-ID: <488798B0.4080205@garzik.org>
References: <200807232040.18264.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52595 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581AbYGWUqp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Jul 2008 16:46:45 -0400
In-Reply-To: <200807232040.18264.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>

Bartlomiej Zolnierkiewicz wrote:
> Add missing ATA_CMD_* defines to <linux/ata.h>.  Also add
> ATA_EXABYTE_ENABLE_NEST, SETFEATURES_AAM_* and ATA_SMART_*
> defines while at it.
> 
> Partially based on earlier work by Chris Wedgwood.
> 
> Cc: Chris Wedgwood <cw@f00f.org>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  include/linux/ata.h |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

ACK patches 1-2, feel free to send upstream alongside patches 3-7


