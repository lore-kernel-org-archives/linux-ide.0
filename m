From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/4] ata_piix: The Sony TZ90 needs the cable type hardcoding
Date: Mon, 11 May 2009 14:33:34 -0400
Message-ID: <4A086F7E.2080404@garzik.org>
References: <20090506160612.24191.90737.stgit@t61.ukuu.org.uk> <20090506160859.24191.881.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51863 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755325AbZEKSdf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 May 2009 14:33:35 -0400
In-Reply-To: <20090506160859.24191.881.stgit@t61.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> The Sony TZ90 needs the cable type hardcoding. See bug #12734
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/ata/ata_piix.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 2b5700a..d51a17c 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -605,6 +605,7 @@ static const struct ich_laptop ich_laptop[] = {
>  	{ 0x24CA, 0x1025, 0x003d },	/* ICH4 on ACER TM290 */
>  	{ 0x266F, 0x1025, 0x0066 },	/* ICH6 on ACER Aspire 1694WLMi */
>  	{ 0x2653, 0x1043, 0x82D8 },	/* ICH6M on Asus Eee 701 */
> +	{ 0x27df, 0x104d, 0x900e },	/* ICH7 on Sony TZ-90 */
>  	/* end marker */

applied 1-2 to #upstream-fixes


