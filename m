From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] drivers/ata/libata-eh.c: fix unused variable warning
Date: Thu, 22 Apr 2010 21:54:55 -0400
Message-ID: <4BD0FDEF.1070504@garzik.org>
References: <1271858846-1706-1-git-send-email-antonf@turbolinux.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63692 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab0DWBzA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 21:55:00 -0400
Received: by gyg13 with SMTP id 13so4850596gyg.19
        for <linux-ide@vger.kernel.org>; Thu, 22 Apr 2010 18:54:59 -0700 (PDT)
In-Reply-To: <1271858846-1706-1-git-send-email-antonf@turbolinux.com.cn>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fang Wenqi <anton.fang@gmail.com>
Cc: jgarzik@redhat.com, linux-ide@vger.kernel.org, antonf@turbolinux.com.cn

On 04/21/2010 10:07 AM, Fang Wenqi wrote:
>    CC      drivers/ata/libata-eh.o
> drivers/ata/libata-eh.c: In function =E2=80=98ata_eh_analyze_ncq_erro=
r=E2=80=99:
> drivers/ata/libata-eh.c:1642: warning: =E2=80=98tf.flags=E2=80=99 may=
 be used uninitialized in this function
>
> Signed-off-by: Fang Wenqi<antonf@turbolinux.com.cn>
> ---
>   drivers/ata/libata-eh.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 9f6cfac..125ec25 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1601,7 +1601,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *=
link)
>   	struct ata_eh_context *ehc =3D&link->eh_context;
>   	struct ata_device *dev =3D link->device;
>   	struct ata_queued_cmd *qc;
> -	struct ata_taskfile tf;
> +	struct ata_taskfile uninitialized_var(tf);
>   	int tag, rc;

NAK - the warning reflects an actual bug.


