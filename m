From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/7] ata: blacklist FUJITSU MHW2160BH PL
Date: Thu, 31 Jul 2008 01:45:27 -0400
Message-ID: <48915177.3060703@garzik.org>
References: <E1KKl4I-00068E-Ob@swissweb.swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52592 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbYGaFpb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 01:45:31 -0400
In-Reply-To: <E1KKl4I-00068E-Ob@swissweb.swissdisk.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Short <zulcss@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Chuck Short wrote:
> Reference: https://launchpad.net/bugs/175834
> 
> CC: linux-ide@vger.kernel.org
> Signed-off-by: Chuck Short <zulcss@ubuntu.com>
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> Signed-off-by: Ben Collins <ben.collins@canonical.com>
> ---
>  drivers/ata/libata-core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 9bef1a8..2664082 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3935,6 +3935,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
>  	{ "HTS541080G9SA00",    "MB4OC60D",     ATA_HORKAGE_NONCQ, },
>  	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ, },
> +	{ "FUJITSU MHW2160BH PL", "0084001E",   ATA_HORKAGE_NONCQ, },

This is outdated -- spurious completion code is long gone


