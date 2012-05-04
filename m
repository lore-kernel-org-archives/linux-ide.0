From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH v2] libata: skip old error history when counting probe trials
Date: Fri, 4 May 2012 08:12:48 -0700
Message-ID: <CAMHSBOWqnyo6_7hybjETRYnE1GPSQNVVnLOCf2FA0AhFOB1tAw@mail.gmail.com>
References: <1336054507.5722.6.camel@chief-river-32>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:36507 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751133Ab2EDPMt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 May 2012 11:12:49 -0400
Received: by ghrr11 with SMTP id r11so2860485ghr.19
        for <linux-ide@vger.kernel.org>; Fri, 04 May 2012 08:12:48 -0700 (PDT)
In-Reply-To: <1336054507.5722.6.camel@chief-river-32>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, Grant Grundler <grundler@google.com>

On Thu, May 3, 2012 at 7:15 AM, Lin Ming <ming.m.lin@intel.com> wrote:
> Commit d902747("[libata] Add ATA transport class") introduced
> ATA_EFLAG_OLD_ER to mark entries in the error ring as cleared.
>
> But ata_count_probe_trials_cb() didn't check this flag and it still
> counts the old error history. So wrong probe trials count is returned
> and it causes problem, for example, SATA link speed is slowed down fr=
om
> 3.0Gbps to 1.5Gbps.
>
> Fix it by checking ATA_EFLAG_OLD_ER in ata_count_probe_trials_cb().
>
> Cc: stable <stable@vger.kernel.org> # 2.6.37+
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
>
> v2: update logs, specify the summary of commit d902747
>
> =A0drivers/ata/libata-eh.c | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index c61316e..d1fbd59 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -3501,7 +3501,8 @@ static int ata_count_probe_trials_cb(struct ata=
_ering_entry *ent, void *void_arg
> =A0 =A0 =A0 =A0u64 now =3D get_jiffies_64();
> =A0 =A0 =A0 =A0int *trials =3D void_arg;
>
> - =A0 =A0 =A0 if (ent->timestamp < now - min(now, interval))
> + =A0 =A0 =A0 if ((ent->eflags & ATA_EFLAG_OLD_ER) ||
> + =A0 =A0 =A0 =A0 =A0 (ent->timestamp < now - min(now, interval)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> =A0 =A0 =A0 =A0(*trials)++;
> --
> 1.7.9
>

Acked-by: Gwendal Grignou <gwendal@google.com>
