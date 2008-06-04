From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata acer short cable quirks
Date: Wed, 04 Jun 2008 06:29:40 -0400
Message-ID: <48466E94.90609@pobox.com>
References: <1212512342-13374-1-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46830 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754951AbYFDK3m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jun 2008 06:29:42 -0400
In-Reply-To: <1212512342-13374-1-git-send-email-max@stro.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: linux-ide@vger.kernel.org, Colin Ian King <colin.king@canonical.com>

maximilian attems wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Add ICH6 on ACER Aspire 1694WLMi to list of laptops that use short cables
> rather than 80 wire
> 
> OriginalAuthor: Tiago Sousa 
> OriginalLocation: http://launchpadlibrarian.net/11627664/new.ich_laptop.short.cables.diff
> Bug: #187121
> 
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: maximilian attems <max@stro.at>
> ---
>  drivers/ata/ata_piix.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index a9027b8..e02b5e0 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -573,6 +573,8 @@ static const struct ich_laptop ich_laptop[] = {
>  	{ 0x27DF, 0x1043, 0x1267 },	/* ICH7 on Asus W5F */
>  	{ 0x27DF, 0x103C, 0x30A1 },	/* ICH7 on HP Compaq nc2400 */
>  	{ 0x24CA, 0x1025, 0x0061 },	/* ICH4 on ACER Aspire 2023WLMi */
> +	{ 0x24CA, 0x1025, 0x003d },	/* ICH4 on ACER TM290 */
> +	{ 0x266F, 0x1025, 0x0066 },	/* ICH6 on ACER Aspire 1694WLMi */
>  	{ 0x2653, 0x1043, 0x82D8 },	/* ICH6M on Asus Eee 701 */

applied


