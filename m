From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH RE-UPDATED] libata: add support for ATA_16 on ATAPI
Date: Wed, 15 Aug 2007 03:23:04 -0400
Message-ID: <46C2A9D8.3040003@garzik.org>
References: <20070801075624.GD13674@htj.dyndns.org> <46B091F4.5070704@garzik.org> <46B09494.4080206@gmail.com> <46B1C788.3060201@rtr.ca> <20070807160845.GR13674@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32905 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045AbXHOHXH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 03:23:07 -0400
In-Reply-To: <20070807160845.GR13674@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> From: Mark Lord <liml@rtr.ca>
> 
> Add support for issuing ATA_16 passthru commands to ATAPI devices
> managed by libata.  It requires the previous CDB length fix patch.
> 
> A boot/module parameter, "atapi_scmd85=1" can be used to globally
> disable this feature, if ever desired.
> 
> tj: renamed ata16_passthru module param to atapi_passthru16 and invert
>     its meaning to reduce confusion.
> 
> tj: restructured __ata_scsi_queuecmd() according to Jeff's suggestion.
> 
> Signed-off-by: Mark Lord <liml@rtr.ca>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Alright, the winner is atapi_passthru16.
> 
>  drivers/ata/libata-core.c |    4 +++
>  drivers/ata/libata-scsi.c |   52 +++++++++++++++++++++++++++++++---------------
>  drivers/ata/libata.h      |    1 
>  3 files changed, 41 insertions(+), 16 deletions(-)

applied


