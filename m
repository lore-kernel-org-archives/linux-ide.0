From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] When a disk needs to be waken up from sleep, ensure that
	the command is retried by SCSI EH.
Date: Thu, 6 Aug 2009 10:28:01 -0700
Message-ID: <e7510f760908061028o1b005c4wd2552c24fc619d9e@mail.gmail.com>
References: <1249579547-21091-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:4976 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264AbZHFR2F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Aug 2009 13:28:05 -0400
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id n76HS5xp018169
	for <linux-ide@vger.kernel.org>; Thu, 6 Aug 2009 10:28:05 -0700
Received: from bwz22 (bwz22.prod.google.com [10.188.26.22])
	by wpaz21.hot.corp.google.com with ESMTP id n76HRaxK011094
	for <linux-ide@vger.kernel.org>; Thu, 6 Aug 2009 10:28:02 -0700
Received: by bwz22 with SMTP id 22so862499bwz.18
        for <linux-ide@vger.kernel.org>; Thu, 06 Aug 2009 10:28:01 -0700 (PDT)
In-Reply-To: <1249579547-21091-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

The explanation did not go through git-send-email:

 Without this fix, ATA passthrough commands are not resend to the
drive, and no error is
 signalled to the caller because:
 - allowed retry count is 1
 - ata_eh_qc_complete fill the sense data, so result is valid
 - sense data is filled with untouched ATA registers.

Gwendal.

On Thu, Aug 6, 2009 at 10:25 AM, Gwendal Grignou<gwendal@google.com> wr=
ote:
>
> Signed-off-by: Gwendal Grignou <gwendal@google.com>
> ---
> =A0drivers/ata/libata-core.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 8ac98ff..5b7616d 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5145,6 +5145,8 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
> =A0 =A0 =A0 =A0/* if device is sleeping, schedule reset and abort the=
 link */
> =A0 =A0 =A0 =A0if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0link->eh_info.action |=3D ATA_EH_RESET=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (qc->scsicmd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qc->scsicmd->allowed++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ata_ehi_push_desc(&link->eh_info, "wak=
ing up from sleep");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ata_link_abort(link);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> --
> 1.5.4.3
>
>
