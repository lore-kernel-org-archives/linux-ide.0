Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EA3C4332F
	for <linux-ide@archiver.kernel.org>; Mon, 15 Nov 2021 13:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893C161C4F
	for <linux-ide@archiver.kernel.org>; Mon, 15 Nov 2021 13:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhKONa5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Nov 2021 08:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhKONam (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 Nov 2021 08:30:42 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA93DC061746;
        Mon, 15 Nov 2021 05:27:43 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id v3so34693470uam.10;
        Mon, 15 Nov 2021 05:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UI84gXEq/taqEmP0iJw7f5UroV8zjftFeuIKaT8atY4=;
        b=XRwx12hwS8lxd6W7Jzug2NSZ603hFdyicIYhSg6v8Mx00jSa8L2JI9vd4gDAE22Y4U
         Kr1aZCd1fHAl+5ic4RWC7+PXL/qr2XlZdBe3kIDyNiSyWbGghhdxz32y9+2Z3qidwHtM
         /Q2KW6SNuGKXBipgnDoLdi3BWo1pgU/JFwhebwqQqJCR9IkZTtY0JOM/8kUgfAodRbdO
         91mZsttK785xRU6uUCYDWI/rEVCnyhXlmJrmNVgj1uC/Xl9iG86PdRE1GUGDgC+pT0Aq
         hcNwAr6QPjwoeKRf2mHAfRieVWmB7CPg2Nl1pzP1W48Kj2iv+GZrxhdSQG0Z0NCtkYBJ
         adDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UI84gXEq/taqEmP0iJw7f5UroV8zjftFeuIKaT8atY4=;
        b=raBSGtjFRz9DdPIpD2Vf/kMqqoN8NbezM1WWIkH0InujREUERslNIVDOlkro2hdsDb
         CY9uzfSg70kSg7DZqhtD/d6u2Ccy3bwdZjzIIIo9qxhz8kZfoTPNcIc7dmkNmtL0o/Gx
         iz2nDdnBWTtEc2qDBikBBLM4u0+yIdutqdU0x3D46ZGkxK8pzp9OlXcQIugjCPmhY8fn
         7j9SPt6ewVpXQzj/yXPrFKmmPJG05/uJvQ4mTxuSvmolI+T3rOvPUn0kMG0FDX23pn4u
         bkerptG7sfJjC40oE0Dmz1ytIe5Gt4Z3GQ487IlZQ+kUPYYRJoxfK6JvRC1pe6J78L9K
         7qMg==
X-Gm-Message-State: AOAM533Hhn9DqMfhkpzNk2gKV8srPaLTXJzIxJ5sBjobpsctlbjIKV2+
        rbk5OmOwqCpCgD8r5T4B0umcI4lbCohT5OLEjtdPQxyI
X-Google-Smtp-Source: ABdhPJyHLrtGR9CQu1vz/77nXpAr4mTxUdp4uKw7tjLXKYWQmJmCctHcmZgWXS3JJ9yFtV8XhzLdKVu+QaN6QySv7Hg=
X-Received: by 2002:a05:6102:4ac:: with SMTP id r12mr43188605vsa.32.1636982862868;
 Mon, 15 Nov 2021 05:27:42 -0800 (PST)
MIME-Version: 1.0
References: <YZABtvQab/M2CCQd@msi.localdomain> <14b22c98-dc4c-fe3b-fa20-b3dd78afd5cc@opensource.wdc.com>
 <CAMJR_v6igrNZMzXpio27PpA6rQvo+efAVd2nM5GNg2+agQa9=A@mail.gmail.com> <b386bdc4-db27-3160-80ac-ecd9d8d69c9f@opensource.wdc.com>
In-Reply-To: <b386bdc4-db27-3160-80ac-ecd9d8d69c9f@opensource.wdc.com>
From:   "Nikolas L." <knv418@gmail.com>
Date:   Mon, 15 Nov 2021 16:27:30 +0300
Message-ID: <CAMJR_v7Y+o7sFh+ViM-hmZ-AqfEujcTSOYNf8ospvPHuk++wcQ@mail.gmail.com>
Subject: Re: PROBLEM: [drivers/ata] Read log page failed (boot error message)
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

There is no error message with vanilla 5.15.2 + this patch.
Warning message about missing support for
ATA Identify Device Log instead. Seems well.
Relevant dmesg part:
ata1: SATA max UDMA/133 abar m2048@0xd8806000 port 0xd8806100 irq 19
ata2: SATA max UDMA/133 abar m2048@0xd8806000 port 0xd8806180 irq 19
ata3: DUMMY
ata4: DUMMY
ata5: DUMMY
ata6: SATA max UDMA/133 abar m2048@0xd8806000 port 0xd8806380 irq 19
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)
ata6.00: ATA-9: WDC WD5000LPLX-75ZNTT0, 03.01A03, max UDMA/133
ata6.00: ATA Identify Device Log not supported
ata6.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
ata1.00: ATAPI: TSSTcorp CDDVDW TS-L633F, TM02, max UDMA/100
ata6.00: ATA Identify Device Log not supported
ata6.00: configured for UDMA/133
ata1.00: configured for UDMA/100
scsi 0:0:0:0: CD-ROM            TSSTcorp CDDVDW TS-L633F  TM02 PQ: 0 ANSI: 5
scsi 5:0:0:0: Direct-Access     ATA      WDC WD5000LPLX-7 1A03 PQ: 0 ANSI: 5
