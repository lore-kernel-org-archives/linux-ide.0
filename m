Return-Path: <SRS0=rcVg=B3=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71589C433E3
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 17:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F5720657
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 17:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjnl6KYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389716AbgHQRTC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389713AbgHQRSw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 Aug 2020 13:18:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE67C061389
        for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2020 10:18:51 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id g13so4110645ioo.9
        for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2020 10:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Xdj+hUuORxMwHP9jC44Vr1XrPKzYm1UwCEkAFNtPoU=;
        b=rjnl6KYjmV4I4SVZaNBaH7yeuZgH/vxDsNUzC8iYtyMd7RgBHsVuQXzJsjeXU0NFwM
         ZbFbbZycYosygYewPklERPpsq/AwWdTWnCOo0nMiHP2QPU0AmvLQQuyhUSdzTUl7Qvsr
         55y9FVipGe0B9xo5wtO8B0M9UWXGEr8VNNlxY6pqA8YxBRQCQPtEX0pnQzUZ37Onvr7X
         cu4Afec52UocwwPqABosKZLEXBoxyO7bwGM6Qj+SCpa/B0Z6Qn+yO3wxrYJrnM97Ei9w
         I98g53I4zMtRWOdL7rVtPCYgKCDO91yjgWa/z1eD2w8OaUE2fMEeyVsEJ8V8bL8sfnrX
         vefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Xdj+hUuORxMwHP9jC44Vr1XrPKzYm1UwCEkAFNtPoU=;
        b=UhwXQ2sSRguLxrJJvM3S7/WJoxLaoUm2vmsk/HBHa6fhwT50ZNazADf4n/kNPYXJuI
         YjKOjH++JjsPxpWshNyxP7OqwAmVo9yy6XRJH/FW1aT/GsXAxYQdGOZsaRAOaDqcfPGq
         lhdh/njqvm1/F+TTsY5011y3TqnHhBwFK/F5F5XWVkf6pf/kWNzSa1dtAZBnsTPUP6oC
         wP7sSf6z7tJGNM/jlP3UalekofPsbjdcfzscjsDbR68OWLOqtJL31uetO6VmcF32DJQE
         sbRTD6kRz/CfC1RoX/rdpfXg0iu9s7l8xS787B4U8w8IABDc6XJRZYtr6/GLtPrx0MCS
         kNTw==
X-Gm-Message-State: AOAM530YNvv2xMdZBh1sfLI9QtUxsPhi/YikNMKM7u+nOca2xqQZEFyD
        brqUqV6x8tpdkkcH/HtFYH/c2CWV7dcoauIK7REIdQ==
X-Google-Smtp-Source: ABdhPJygLnUFYEkR9Rx0u0jTzGElmGQbI3ovJciZ9b/ImVpmi0yhpFACSpBYbI+olJuJkoyXxJECt5jFuhsNjuZzqJ8=
X-Received: by 2002:a02:bb82:: with SMTP id g2mr15805513jan.54.1597684730880;
 Mon, 17 Aug 2020 10:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <CACqKpR-5=bDwODQFfMY+o8-XJMCQmtLVAOiCEY8ApFwQr04A8A@mail.gmail.com>
In-Reply-To: <CACqKpR-5=bDwODQFfMY+o8-XJMCQmtLVAOiCEY8ApFwQr04A8A@mail.gmail.com>
From:   Akshat Jain <akshatzen@google.com>
Date:   Mon, 17 Aug 2020 10:18:39 -0700
Message-ID: <CACqKpR8CygBi+QAbxDecxm8LDeU5kuDDqspfL=yxfLVDuh7gaA@mail.gmail.com>
Subject: Re: Question on ata_gen_passthru_sense interpretation of fixed format
 sense buffer
To:     Tejun Heo <tj@kernel.org>
Cc:     Vishakha Channapattan <vishakhavc@google.com>,
        linux-ide@vger.kernel.org, John Grass <jgrass@google.com>,
        Thieu Le <thieule@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello Tejun,
Gentle ping if you missed this email.

Regards,
Akshat

On Mon, Aug 3, 2020 at 9:44 AM Akshat Jain <akshatzen@google.com> wrote:
>
> Hello Jens Tejun,
> I have a question regarding the ata_gen_passthru_sense function (libata-s=
csi.c).
>
> This function while generating fixed format sense blocks, puts the
> INFORMATION field at offset 8 and COMMAND-SPECIFIC-INFORMATION at
> offset 16.
> While as per SCSI Primary commands - 4 specification, section 4.5.3
> Fixed format sense data Table 53, the INFORMATION field is at offset 3
> and COMMAND-SPECIFIC-INFORMATION is at offset 8.
>
> Code snippet:
>
> static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> {
> struct scsi_cmnd *cmd =3D qc->scsicmd;
> struct ata_taskfile *tf =3D &qc->result_tf;
> unsigned char *sb =3D cmd->sense_buffer;
> unsigned char *desc =3D sb + 8;
> =E2=80=A6.
>     if ((cmd->sense_buffer[0] & 0x7f) >=3D 0x72) {
>     ....
>     } else {
>         /* Fixed sense format */
>        desc[0] =3D tf->feature;
>        desc[1] =3D tf->command; /* status */
>        desc[2] =3D tf->device;
>        desc[3] =3D tf->nsect;
>        desc[7] =3D 0;
>        if (tf->flags & ATA_TFLAG_LBA48)  {
>            desc[8] |=3D 0x80;
>            if (tf->hob_nsect)
>                desc[8] |=3D 0x40;
>            if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
>                desc[8] |=3D 0x20;
>        }
>        desc[9] =3D tf->lbal;
>        desc[10] =3D tf->lbam;
>        desc[11] =3D tf->lbah;
>     }
> }
>
> Link to spec: https://www.t10.org/cgi-bin/ac.pl?t=3Df&f=3Dspc4r37a.pdf
>
> My team has confirmed this observation. Do you believe our
> interpretation of the specification is correct and if yes does this
> need to be corrected?
>
> Regards,
> Akshat Jain
