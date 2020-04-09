Return-Path: <SRS0=THTS=5Z=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9E1C2BB54
	for <linux-ide@archiver.kernel.org>; Thu,  9 Apr 2020 09:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB8E21744
	for <linux-ide@archiver.kernel.org>; Thu,  9 Apr 2020 09:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDIJQV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:16:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42201 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgDIJQV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2020 05:16:21 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jMTIJ-0002bH-HF
        for linux-ide@vger.kernel.org; Thu, 09 Apr 2020 09:16:19 +0000
Received: by mail-pl1-f200.google.com with SMTP id w3so7188465plz.15
        for <linux-ide@vger.kernel.org>; Thu, 09 Apr 2020 02:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I/aLOBCPPw94GG/u9hj9C2FG+LS8AZRo+ZKiDRcnxfs=;
        b=OJn7k6LjZayX+kgWIuYEETtRZIgHR4mSoWyqQESUKQ3s3fDDB1mqgL9wJVjIDUwdvz
         fqeeYLBXIZcgvlxTx2ZzKXMS+NsMP8PoeEFe2388W1JdMdnoADQkGeh7m20gAyzylR1H
         ILCHm7xIFGFo3ddaFJ9nbzF/5YNYzQOEjxOkeIDymNOhlOHcE33+btGWAXbFn+CK/QBP
         gsiSFIVcmwJBU8l8neuAZPB3CQPCeELAd+9lNpA4rOwiJHgTpuh1EB2zQPwZcKE9XOl4
         hHputtUyIFtFTlB9Hyo6YhcL+HB2GePpNs8NNWqhgbOX0ZHG9wvMGc+8h7vl9COBhtUt
         hUKw==
X-Gm-Message-State: AGi0PuahF3buSgt3Q9yOSigC7b08oIMTO14PKhu2M4uuEKSDKrR+Eu8s
        yfNTQMGqGkcNKWr26EBFUsETq+l7LX4Ikw80jOPJMtEh9gK2R1/qgJhVjGi7Jy39iCdyZWJQCT8
        jRwhVwBhahczBK7Qbdzx7qDxKrgf8dtn4P0Al1A==
X-Received: by 2002:a17:902:242:: with SMTP id 60mr11378510plc.245.1586423777939;
        Thu, 09 Apr 2020 02:16:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypLJyMKRHAg8InQnK0BXiYiqShBnT1RbYLk74TbMNSG8JiX0/iAUbWhQOBWAi7mt/UsWbh2v1w==
X-Received: by 2002:a17:902:242:: with SMTP id 60mr11378491plc.245.1586423777606;
        Thu, 09 Apr 2020 02:16:17 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 6sm18624250pfx.69.2020.04.09.02.16.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 02:16:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] ahci: Add Intel Comet Lake PCH RAID PCI ID
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20191128081041.6948-1-jian-hong@endlessm.com>
Date:   Thu, 9 Apr 2020 17:16:14 +0800
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, linux@endlessm.com
Content-Transfer-Encoding: 8BIT
Message-Id: <EF580FD3-2C0F-4268-8B39-8B339D590353@canonical.com>
References: <20191128081041.6948-1-jian-hong@endlessm.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Jian-Hong Pan <jian-hong@endlessm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Jens,

> On Nov 28, 2019, at 16:10, Jian-Hong Pan <jian-hong@endlessm.com> wrote:
> 
> Intel Comet Lake should use the default LPM policy for mobile chipsets.
> So, add the PCI ID to the driver list of supported devices.
> 
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>

Would it be possible to also merge this patch?
We also have some system that use this controller.

Kai-Heng

> ---
> drivers/ata/ahci.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ec6c64fce74a..d9b3a9f7a4ee 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -405,6 +405,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
> 	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_mobile }, /* Cherry Tr. AHCI */
> 	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_mobile }, /* ApolloLake AHCI */
> 	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_mobile }, /* Ice Lake LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_mobile }, /* Comet Lake PCH RAID */
> 
> 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
> 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> -- 
> 2.20.1
> 

