Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D472C74A5B
	for <linux-ide@archiver.kernel.org>; Sun, 26 Mar 2023 20:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjCZUO1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 26 Mar 2023 16:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCZUO1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 26 Mar 2023 16:14:27 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AE555599
        for <linux-ide@vger.kernel.org>; Sun, 26 Mar 2023 13:14:17 -0700 (PDT)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 89DA97A0280;
        Sun, 26 Mar 2023 22:14:16 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 2/2] ata: pata_parport-bpck6: Declare mode_map as static
Date:   Sun, 26 Mar 2023 22:14:14 +0200
User-Agent: KMail/1.9.10
Cc:     linux-ide@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20230323033836.352672-1-damien.lemoal@opensource.wdc.com> <20230323033836.352672-3-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230323033836.352672-3-damien.lemoal@opensource.wdc.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202303262214.14655.linux@zary.sk>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thursday 23 March 2023 04:38:36 Damien Le Moal wrote:
> Compilation C=1 of the bpck6 protocol module generates the following
> message:
> 
> drivers/ata/pata_parport/bpck6.c:62:5: warning: symbol 'mode_map' was
> not declared. Should it be static?
> 
> Fix this by declaring mode_map as static.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Ondrej Zary <linux@zary.sk>

> ---
>  drivers/ata/pata_parport/bpck6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
> index 295dbe5cdaa4..76febd07a9bb 100644
> --- a/drivers/ata/pata_parport/bpck6.c
> +++ b/drivers/ata/pata_parport/bpck6.c
> @@ -59,8 +59,8 @@
>  #define PPCMODE_EPP_WORD	5
>  #define PPCMODE_EPP_DWORD	6
>  
> -int mode_map[] = { PPCMODE_UNI_FW, PPCMODE_BI_FW, PPCMODE_EPP_BYTE,
> -		   PPCMODE_EPP_WORD, PPCMODE_EPP_DWORD };
> +static int mode_map[] = { PPCMODE_UNI_FW, PPCMODE_BI_FW, PPCMODE_EPP_BYTE,
> +			  PPCMODE_EPP_WORD, PPCMODE_EPP_DWORD };
>  
>  static void bpck6_send_cmd(struct pi_adapter *pi, u8 cmd)
>  {


-- 
Ondrej Zary
