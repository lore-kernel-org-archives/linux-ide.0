Return-Path: <SRS0=SAhA=BN=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9685C433DF
	for <linux-ide@archiver.kernel.org>; Mon,  3 Aug 2020 16:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96639207FB
	for <linux-ide@archiver.kernel.org>; Mon,  3 Aug 2020 16:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjdiNJ0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgHCQoi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCQoi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 3 Aug 2020 12:44:38 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039CCC06174A
        for <linux-ide@vger.kernel.org>; Mon,  3 Aug 2020 09:44:38 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id t15so30266297iob.3
        for <linux-ide@vger.kernel.org>; Mon, 03 Aug 2020 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=5w4aynaXHSnaX6taQ5Vg60vAcPRg8fB04JsBuXA+8j0=;
        b=AjdiNJ0KSFVoKB8pzCTlJwDOwdOcAyRyazY1hDJI8HhrUXbvYaKX0Oh7tXlVif/b1X
         bSbp1M/Lgy6SKJEBUHScjbHzjq9NHOrR1eg+/QBXRuTR08yZN9mirrQ8cCUajfVrotvH
         7UuHHvFxD2PNUH/RPNBa/yFaSHrYUnwkwxxRMhiglkFHtWtM8Yai/eE/pIudnuwdQux/
         1egcydL7AiSfCJCY1CfoFFxU75vnf4qekcItgfkGXnIFpgHSxYTfXeD8deYF6fl5AW/E
         tO2BDs9bxR5xC23T9DQXwpPFejCNKrDUAanEw5YMjiDCqdeKbZbHiw7x2C87U/7Y+9DJ
         h83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=5w4aynaXHSnaX6taQ5Vg60vAcPRg8fB04JsBuXA+8j0=;
        b=Hk3f7Hrjkd7uDhKVqAuTjL5uC8asBZdXZ7LeBIjGny6Mv0MgPFiCqG21tbsnrRGmqK
         iIBF351UpPFu4eCDqbOaZQAcDmimq8yX8i4KKtJjXoBCOcFw/aJSSvWHfu1/FIwTxHmL
         XSVOVD4WpS7M6+ZxMiAEk21NHUbOcJC0ojtwr9btN+MJynjLljXsPQMSx4R8oVjIWGUc
         1zoMjtMo4D9uzHp9SDXGLi1cE+Oedcz0z8JWRnqUFMYhIb5psLDjrFFoHdxBTF4D6NZ5
         vyBbJ9Mubh8VD38z6b/+mgtS3MsGL5SvqQMx6ipxkdHd6jeow1All98gR5yWhHOaN0fu
         UlhA==
X-Gm-Message-State: AOAM533rQ+rnm1yp7KzV/niqf+7EEi6Zh3CzykQtfgIOZNJVC2Wm9/RY
        sGImGhDjJYfTf1R2+jI7qYtlHhIsHP2DmFBkwtSGcQ==
X-Google-Smtp-Source: ABdhPJxJrIhlYKwrY9wfes8Nu/+zVOn6Sg6TnSeRylAnLtX7F1P6yvGo56khalsCNrWDIoMR8fh/3aEHzhBw2vwLuNE=
X-Received: by 2002:a6b:c88f:: with SMTP id y137mr726608iof.55.1596473077127;
 Mon, 03 Aug 2020 09:44:37 -0700 (PDT)
MIME-Version: 1.0
From:   Akshat Jain <akshatzen@google.com>
Date:   Mon, 3 Aug 2020 09:44:26 -0700
Message-ID: <CACqKpR-5=bDwODQFfMY+o8-XJMCQmtLVAOiCEY8ApFwQr04A8A@mail.gmail.com>
Subject: Question on ata_gen_passthru_sense interpretation of fixed format
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

Hello Jens Tejun,
I have a question regarding the ata_gen_passthru_sense function (libata-scs=
i.c).

This function while generating fixed format sense blocks, puts the
INFORMATION field at offset 8 and COMMAND-SPECIFIC-INFORMATION at
offset 16.
While as per SCSI Primary commands - 4 specification, section 4.5.3
Fixed format sense data Table 53, the INFORMATION field is at offset 3
and COMMAND-SPECIFIC-INFORMATION is at offset 8.

Code snippet:

static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
{
struct scsi_cmnd *cmd =3D qc->scsicmd;
struct ata_taskfile *tf =3D &qc->result_tf;
unsigned char *sb =3D cmd->sense_buffer;
unsigned char *desc =3D sb + 8;
=E2=80=A6.
    if ((cmd->sense_buffer[0] & 0x7f) >=3D 0x72) {
    ....
    } else {
        /* Fixed sense format */
       desc[0] =3D tf->feature;
       desc[1] =3D tf->command; /* status */
       desc[2] =3D tf->device;
       desc[3] =3D tf->nsect;
       desc[7] =3D 0;
       if (tf->flags & ATA_TFLAG_LBA48)  {
           desc[8] |=3D 0x80;
           if (tf->hob_nsect)
               desc[8] |=3D 0x40;
           if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
               desc[8] |=3D 0x20;
       }
       desc[9] =3D tf->lbal;
       desc[10] =3D tf->lbam;
       desc[11] =3D tf->lbah;
    }
}

Link to spec: https://www.t10.org/cgi-bin/ac.pl?t=3Df&f=3Dspc4r37a.pdf

My team has confirmed this observation. Do you believe our
interpretation of the specification is correct and if yes does this
need to be corrected?

Regards,
Akshat Jain
