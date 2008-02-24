From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: automatically use DMADIR if drive/bridge requires
 it
Date: Sun, 24 Feb 2008 00:29:37 -0500
Message-ID: <47C100C1.5070605@garzik.org>
References: <47B9D64C.3000705@rtr.ca> <47B9F05A.1060207@rtr.ca> <47BC6100.9020906@pobox.com> <47BC7727.1090508@rtr.ca> <47BCFD4E.4070100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36097 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759144AbYBXF3o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Feb 2008 00:29:44 -0500
In-Reply-To: <47BCFD4E.4070100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Albert Lee <albertcc@tw.ibm.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Tejun Heo wrote:
> Back in 2.6.17-rc2, a libata module parameter was added for atapi_dmadir.
> 
> That's nice, but most SATA devices which need it will tell us about it
> in their IDENTIFY PACKET response, as bit-15 of word-62 of the
> returned data (as per ATA7, ATA8 specifications).
> 
> So for those which specify it, we should automatically use the DMADIR bit.
> Otherwise, disc writing will fail by default on many SATA-ATAPI drives.
> 
> This patch adds ATA_DFLAG_DMADIR and make ata_dev_configure() set it
> if atapi_dmadir is set or identify data indicates DMADIR is necessary.
> atapi_xlat() is converted to check ATA_DFLAG_DMADIR before setting
> DMADIR.
> 
> Original patch is from Mark Lord.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Mark Lord <mlord@pobox.com>
> ---
> I don't have a bridge which sets DMADIR but so only checked atapi_dmadir
> parameter.  Thanks.
> 
>  drivers/ata/libata-core.c |   11 +++++++++--
>  drivers/ata/libata-scsi.c |    3 ++-
>  include/linux/ata.h       |    5 +++++
>  include/linux/libata.h    |    1 +
>  4 files changed, 17 insertions(+), 3 deletions(-)

applied

