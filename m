From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: add missing ATA_ID_* defines (take 2)
Date: Wed, 23 Jul 2008 16:48:56 -0400
Message-ID: <48879938.8010803@pobox.com>
References: <200807222249.32242.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52634 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913AbYGWUs7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Jul 2008 16:48:59 -0400
In-Reply-To: <200807222249.32242.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Add missing ATA_ID_* defines and update {ata,atapi}_*()
> inlines accordingly.  The currently unused defines are
> needed for the forthcoming drivers/ide/ changes.
> 
> v2:
> Add ATA_ID_SPG.
> 
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> v2 was needed because one define got lost :/
> 
>  include/linux/ata.h |  122 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 76 insertions(+), 46 deletions(-)

ACK, and I'll send this one upstream myself.  It shouldn't conflict with 
the patches just ACK'd.


