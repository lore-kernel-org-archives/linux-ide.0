From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: remove superfluous NULL pointer checks
Date: Tue, 28 Jul 2009 21:10:23 -0400
Message-ID: <4A6FA17F.20507@pobox.com>
References: <200907261605.14619.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59197 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbZG2BK2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 21:10:28 -0400
In-Reply-To: <200907261605.14619.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, corbet@lwn.net, eteo@redhat.com

Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] libata: remove superfluous NULL pointer checks
> 
> host->ports[] always contain pointers to valid port structures since
> a "dummy port" structure is used in case if there is no physical port.
> 
> This patch takes care of two entries from Dan's list:
> 
> drivers/ata/sata_sil.c +535 sil_interrupt(13) warning: variable derefenced before check 'ap'
> drivers/ata/sata_mv.c +2517 mv_unexpected_intr(6) warning: variable derefenced before check 'ap'
> 
> and of another needless NULL pointer check in pata_octeon_cf.c.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: corbet@lwn.net
> Cc: eteo@redhat.com
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ata/pata_octeon_cf.c |    3 ++-
>  drivers/ata/sata_mv.c        |    2 +-
>  drivers/ata/sata_sil.c       |    2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)

applied to #upstream-fixes


