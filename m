From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: add missing NULL pointer check to ata_eh_reset()
Date: Tue, 28 Jul 2009 21:10:37 -0400
Message-ID: <4A6FA18D.1070808@pobox.com>
References: <200907261621.01893.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59203 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376AbZG2BKl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 21:10:41 -0400
In-Reply-To: <200907261621.01893.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Dan Carpenter <error27@gmail.com>, corbet@lwn.net, eteo@redhat.com

Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] libata: add missing NULL pointer check to ata_eh_reset()
> 
>>From Dan's list:
> 
> drivers/ata/libata-eh.c +2403 ata_eh_reset(80) warning: variable derefenced before check 'slave'
> 
> Please note that this is _not_ a real bug at the moment since ata_eh_context
> structure is embedded into ata_list structure and the code alwas checks for
> 'slave' before accessing 'sehc'.
> 
> Anyway lets add missing check and always have a valid 'sehc' pointer (which
> makes code easier to understand and prevents introducing some possible bugs
> in the future).
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: corbet@lwn.net
> Cc: eteo@redhat.com
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ata/libata-eh.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to #upstream-fixes


