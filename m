From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: add ST3160023AS / 3.42 to NCQ
 blacklist
Date: Mon, 17 Dec 2007 20:37:37 -0500
Message-ID: <47672461.400@garzik.org>
References: <475BC753.7090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60143 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757696AbXLRBhj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Dec 2007 20:37:39 -0500
In-Reply-To: <475BC753.7090108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Matheus Izvekov <mizvekov@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, "Eric D. Mudama" <edmudama@gmail.com>

Tejun Heo wrote:
> Like ST380817AS / 3.42, ST3160023AS / 3.42 times out commands if NCQ
> is used.  Blacklist it.  This is reported by Matheus Izvekov in the
> following thread.
> 
>   http://thread.gmane.org/gmane.linux.ide/24202
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Matheus Izvekov <mizvekov@gmail.com>
> ---
> It could be that all devices with 3.42 firmware have this problem.
> I'll ask around.  Thanks.
> 
>  drivers/ata/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e4dea86..e080b07 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4149,6 +4149,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "HITACHI HDS7250SASUN500G*", NULL,    ATA_HORKAGE_NONCQ },
>  	{ "HITACHI HDS7225SBSUN250G*", NULL,    ATA_HORKAGE_NONCQ },
>  	{ "ST380817AS",		"3.42",		ATA_HORKAGE_NONCQ },
> +	{ "ST3160023AS",	"3.42",		ATA_HORKAGE_NONCQ },

applied #upstream-fixes


