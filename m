Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A258AC433E6
	for <linux-ide@archiver.kernel.org>; Sat, 30 Jan 2021 18:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC1264DDD
	for <linux-ide@archiver.kernel.org>; Sat, 30 Jan 2021 18:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhA3S5i (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 30 Jan 2021 13:57:38 -0500
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:42118 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230095AbhA3S5i (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jan 2021 13:57:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B46EC182CED5B;
        Sat, 30 Jan 2021 18:56:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: plane06_350769c275b3
X-Filterd-Recvd-Size: 2533
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jan 2021 18:56:55 +0000 (UTC)
Message-ID: <e65adfa0d8a74e06edda822ac42f7c62c8e0af90.camel@perches.com>
Subject: Re: [PATCH 05/29] ata: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 30 Jan 2021 10:56:54 -0800
In-Reply-To: <2a3979b0eab31224e53553ca01759eb072790a65.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
         <2a3979b0eab31224e53553ca01759eb072790a65.1598331148.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> Use semicolons and braces.

ping?
 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/ata/pata_icside.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
> index 08543aeb0093..498383cb6e29 100644
> --- a/drivers/ata/pata_icside.c
> +++ b/drivers/ata/pata_icside.c
> @@ -202,14 +202,19 @@ static void pata_icside_set_dmamode(struct ata_port *ap, struct ata_device *adev
>  	 * Choose the IOMD cycle timing which ensure that the interface
>  	 * satisfies the measured active, recovery and cycle times.
>  	 */
> -	if (t.active <= 50 && t.recover <= 375 && t.cycle <= 425)
> -		iomd_type = 'D', cycle = 187;
> -	else if (t.active <= 125 && t.recover <= 375 && t.cycle <= 500)
> -		iomd_type = 'C', cycle = 250;
> -	else if (t.active <= 200 && t.recover <= 550 && t.cycle <= 750)
> -		iomd_type = 'B', cycle = 437;
> -	else
> -		iomd_type = 'A', cycle = 562;
> +	if (t.active <= 50 && t.recover <= 375 && t.cycle <= 425) {
> +		iomd_type = 'D';
> +		cycle = 187;
> +	} else if (t.active <= 125 && t.recover <= 375 && t.cycle <= 500) {
> +		iomd_type = 'C';
> +		cycle = 250;
> +	} else if (t.active <= 200 && t.recover <= 550 && t.cycle <= 750) {
> +		iomd_type = 'B';
> +		cycle = 437;
> +	} else {
> +		iomd_type = 'A';
> +		cycle = 562;
> +	}
>  
> 
>  	ata_dev_info(adev, "timings: act %dns rec %dns cyc %dns (%c)\n",
>  		     t.active, t.recover, t.cycle, iomd_type);


