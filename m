From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH 04/07] sata_mv: update ata_qc_from_tag
Date: Sun, 1 Feb 2009 12:49:02 -0800
Message-ID: <da824cf30902011249r5aa12dc8g39426a39dee41201@mail.gmail.com>
References: <49839107.2040603@rtr.ca> <4983915F.7090705@rtr.ca>
	 <498391A7.1090209@rtr.ca> <498391D9.2000403@rtr.ca>
	 <49839209.9010602@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:51355 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbZBAUtK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 15:49:10 -0500
Received: from spaceape10.eur.corp.google.com (spaceape10.eur.corp.google.com [172.28.16.144])
	by smtp-out.google.com with ESMTP id n11Kn6xO001672
	for <linux-ide@vger.kernel.org>; Sun, 1 Feb 2009 20:49:07 GMT
Received: from wf-out-1314.google.com (wfd27.prod.google.com [10.142.4.27])
	by spaceape10.eur.corp.google.com with ESMTP id n11KmfJW001863
	for <linux-ide@vger.kernel.org>; Sun, 1 Feb 2009 12:49:03 -0800
Received: by wf-out-1314.google.com with SMTP id 27so1428665wfd.17
        for <linux-ide@vger.kernel.org>; Sun, 01 Feb 2009 12:49:02 -0800 (PST)
In-Reply-To: <49839209.9010602@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, Jan 30, 2009 at 3:49 PM, Mark Lord <liml@rtr.ca> wrote:
> Update the logic in ata_qc_from_tag() to match that used
> in similar places elsewhere in libata.
>
> Signed-off-by: Mark Lord <mlord@pobox.com>
>
> --- old/drivers/ata/sata_mv.c   2009-01-30 18:23:22.000000000 -0500
> +++ linux/drivers/ata/sata_mv.c 2009-01-30 18:26:55.000000000 -0500
> @@ -1628,6 +1628,12 @@
>        if (pp->pp_flags & MV_PP_FLAG_NCQ_EN)
>                return NULL;
>        qc = ata_qc_from_tag(ap, ap->link.active_tag);
> +       if (qc) {
> +               if (qc->tf.flags & ATA_TFLAG_POLLING)
> +                       qc = NULL;
> +               else if (!(qc->flags & ATA_QCFLAG_ACTIVE))
> +                       qc = NULL;
> +       }
>        if (qc && (qc->tf.flags & ATA_TFLAG_POLLING))
>                qc = NULL;

Mark,
isn't the second test redudant now and can be removed?
(refering to the test immediately following the code you added).

grant

>        return qc;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
