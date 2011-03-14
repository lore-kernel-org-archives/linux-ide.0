From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Include WWN ID in inquiry VPD emulation
Date: Mon, 14 Mar 2011 03:00:07 -0400
Message-ID: <4D7DBCF7.3060107@pobox.com>
References: <20110307075644.43CD0F90E1@ochil.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44755 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297Ab1CNHAL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2011 03:00:11 -0400
Received: by vws1 with SMTP id 1so2120584vws.19
        for <linux-ide@vger.kernel.org>; Mon, 14 Mar 2011 00:00:11 -0700 (PDT)
In-Reply-To: <20110307075644.43CD0F90E1@ochil.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On 03/07/2011 02:56 AM, Hannes Reinecke wrote:
>
> As per SAT-3 the WWN ID should be included in the VPD page 0x83
> (device identification) emulation.
>
> Signed-off-by: Hannes Reinecke<hare@suse.de>
> Acked-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/libata-scsi.c |   11 +++++++++++
>   include/linux/ata.h       |    7 +++++++
>   2 files changed, 18 insertions(+), 0 deletions(-)

applied


