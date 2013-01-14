From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Fix ahci don't retry commands after a success error handler.
Date: Mon, 14 Jan 2013 13:10:01 -0500
Message-ID: <50F449F9.6090703@pobox.com>
References: <CAPoh-nbV0yc_QH-D3L5ms_n_83BkPFC6ZUJHd=H9t=hqKRKVWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:41068 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379Ab3ANSKE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2013 13:10:04 -0500
Received: by mail-qa0-f44.google.com with SMTP id z4so1671832qan.17
        for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2013 10:10:03 -0800 (PST)
In-Reply-To: <CAPoh-nbV0yc_QH-D3L5ms_n_83BkPFC6ZUJHd=H9t=hqKRKVWw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: y b <ycbzzjlby@gmail.com>
Cc: kernel@teksavvy.com, linux-ide@vger.kernel.org

On 01/06/2013 12:14 AM, y b wrote:
>>From 78c0fb104c9957db682518b97ce6a01ce1bc07b6 Mon Sep 17 00:00:00 2001
> From: Bian Yu <bianyu@kedacom.com>
> Date: Wed, 12 Dec 2012 22:26:58 -0500
> Subject: [PATCH] It should be a mistake introduced by commit 8d899e70c1b3afff.
>   because only qc->flags can't be set AC_ERR_*
>
> Signed-off-by: Bian Yu <bianyu@kedacom.com>
> ---
>   drivers/ata/libata-eh.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index bf039b0..bcf4437 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2094,7 +2094,7 @@ static unsigned int ata_eh_speed_down(struct
> ata_device *dev,
>    */
>   static inline int ata_eh_worth_retry(struct ata_queued_cmd *qc)
>   {
> -       if (qc->flags & AC_ERR_MEDIA)
> +       if (qc->err_mask & AC_ERR_MEDIA)
>                  return 0;       /* don't retry media errors */
>          if (qc->flags & ATA_QCFLAG_IO)

applied, good catch



