From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream-fixes] ata_piix: add another TECRA M3 entry
 to broken suspend list
Date: Tue, 02 Oct 2007 10:54:13 -0400
Message-ID: <47025B95.9000607@pobox.com>
References: <46FF5A28.6060005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37337 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517AbXJBOyP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 10:54:15 -0400
In-Reply-To: <46FF5A28.6060005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Angus Turnbull <angus@twinhelix.com>

Tejun Heo wrote:
> There's a different version of DMI table for TECRA M3 where it has
> proper vendor and product name entry.  Add the entry to the broken
> suspend list.
> 
> Angus Turnbull reported and provided initial patch.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Angus Turnbull <angus@twinhelix.com>
> ---
>  drivers/ata/ata_piix.c |    7 +++++++
>  1 file changed, 7 insertions(+)

applied


