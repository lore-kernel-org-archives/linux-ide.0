Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062FAC46467
	for <linux-ide@archiver.kernel.org>; Wed, 11 Jan 2023 04:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjAKEci (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Jan 2023 23:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjAKEch (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2023 23:32:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAF212AE3
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 20:32:35 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c6so15533121pls.4
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 20:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eO2nJDYhT5GJxHEdBGWFsvi67zSmV874nT01DvMhuq4=;
        b=outEOh82QabNhEiQ1TrZgFNAMf9mYkCkzjsLTDA+BlNK1lEPmT6UiEVvIBBKZ/yQsY
         hJ2S0oeeZFvpRpa6yJ9u9nQzC6tFEupSYt6gUu82ThSpTOLJ7wrOKdrOxRWCVBpDlS9y
         Xiqvm1fgVel3l27ViiaYZvzkk65ycpClBNzLG+h2c2L+z1c7iZtpcbXaamzucDWqXkJ0
         6PN99lkoaxPDpMCX3Y9DUkFl9Mmyad+/tqIDsyA06SY0fYPmTMhM8QtJ1Lo2WCN/OiGi
         46aA+mL2JVDGCLmO0XHHTWF8BI8EmGsUV7DLPj6U7FigkfbD/6SVHIaNssh0+SO4E5xO
         48LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eO2nJDYhT5GJxHEdBGWFsvi67zSmV874nT01DvMhuq4=;
        b=6OyXV2vQainuMzt3qMheGAJypmX03gIbYAe5XxZJ162oYrMn5IEoWGYUBpIICroEk5
         XGqoeB4tz+hLs2O+mfGyhI29zGFrL8OcqrfHd7kDeMPvksmFyuNF4VQ2Dz4KwGPEiGh/
         UwZwePBhyve3TAtcH6fP+/o7+kWSGklSSPRjeIWPP3yineRvUg0Z60TgYC4ahzlKQcYj
         Alihmi1bQr50Fpau9t5kgjouAP+A96OMFpmJzi113ZFOzRTIdOaITFvB3ZUIaoMxGMIj
         iN7Y8OsRwipUZlOWOKZ+X2Tv+Wu08dZTJ5Hm8Lo204nqIKrMM5mQyCO4zBmPcLiuCBBD
         RNnQ==
X-Gm-Message-State: AFqh2kpQqh/bT5Ji84ga763MmM+morAczHHuykRTpUcDtq4hDcJVyIyc
        7NmpP4nTZ4YumytBxxqJaToDtw==
X-Google-Smtp-Source: AMrXdXsRDZ+nyVopkTlB5QMAjMsj66+Frkyrar/TGB/ULwNFDuM+Sicw/MST3pQtKnKZpNzwzNKx7A==
X-Received: by 2002:a05:6a20:a587:b0:a7:c027:f84a with SMTP id bc7-20020a056a20a58700b000a7c027f84amr22724548pzb.1.1673411555266;
        Tue, 10 Jan 2023 20:32:35 -0800 (PST)
Received: from smtpclient.apple ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w67-20020a628246000000b005892ea4f092sm4429975pfd.95.2023.01.10.20.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 20:32:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jens Axboe <axboe@kernel.dk>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v9 1/6] block: add a sanity check for non-write flush/fua bios
Date:   Tue, 10 Jan 2023 21:32:23 -0700
Message-Id: <2544F354-58C0-4E90-8A1E-721AD455D6C8@kernel.dk>
References: <4a278c42-1f7b-f4c2-13c1-06d6fe52997f@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
In-Reply-To: <4a278c42-1f7b-f4c2-13c1-06d6fe52997f@opensource.wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: iPhone Mail (20C65)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Jan 10, 2023, at 2:58 PM, Damien Le Moal <damien.lemoal@opensource.wdc.co=
m> wrote:
>=20
> =EF=BB=BFOn 1/10/23 22:27, Damien Le Moal wrote:
>> From: Christoph Hellwig <hch@infradead.org>
>>=20
>> Check that the PREFUSH and FUA flags are only set on write bios,
>> given that the flush state machine expects that.
>>=20
>> [Damien] The check is also extended to REQ_OP_ZONE_APPEND operations as
>> these are data write operations used by btrfs and zonefs and may also
>> have the REQ_FUA bit set.
>>=20
>> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Christoph, Jens,
>=20
> Are you OK with this patch ?

I already acked a previous version, you just didn=E2=80=99t pick it up.=20

=E2=80=94=20
Jens Axboe

