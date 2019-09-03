Return-Path: <SRS0=jKCH=W6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD08C3A5A2
	for <linux-ide@archiver.kernel.org>; Tue,  3 Sep 2019 11:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1AA22CF8
	for <linux-ide@archiver.kernel.org>; Tue,  3 Sep 2019 11:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6lYrl2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfICLVz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:21:55 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:46053 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfICLVz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Sep 2019 07:21:55 -0400
Received: by mail-ed1-f53.google.com with SMTP id f19so4211170eds.12
        for <linux-ide@vger.kernel.org>; Tue, 03 Sep 2019 04:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JZz7wAagt4mlfPayavJhD6O6ohW5ze8Brcqj9LIEeb4=;
        b=D6lYrl2+K9GBK1SQMphuApiyQRqsDfVUfX5pVSYgkdizou2E061j5Gp3Q/VQDprHYg
         +lsskG42byrji6IMDGHSb7Q9TygIk7Z5TZKuCeb/SPXIm/f80TWL3PrvMaSqzys3G85/
         kOgEGhudt9Z6/Msks5WZ2ymQo0Ri/4OQ/Quu8LXVh67v8lWBDbVL6332zVVN+qvkY94u
         M7F4e3u6yvnhns1Nbf9DSHP2WEABBmiqrT8sRO95j/3LCQyI4zGmGafPOfg1s2ijNjl6
         N9N/x6AEEHyV+xFvfNb+MPQFVv4oN1DMfUhwxovBJKE7ofxnjpASCa3OL0XBAxTmD3Xv
         lDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JZz7wAagt4mlfPayavJhD6O6ohW5ze8Brcqj9LIEeb4=;
        b=oSm/2mbgLplI6mKZr+pF2kIdtP2ADvguhRMDOZhnxh1TlLpcHM9TMtyCf5TqdioqjI
         fNjRHePxCNSuyW0jHfR/VJi9/T7j4uWlMMFZ4KDVFYJb5EfoIhCqpj/b8soHRciaf8oA
         GRjQLi0zMkZkPrvXDpLvVer1baLhIVTV7tMQF1M3NDCV6B3SRULAKFpvaWUk/2cXWI8F
         goPq2HlWLzMTpEeeb6af/ATlc+fHIa5pJ387xth0um84TzbSJeSWsvh5gBolq5Ucj8sP
         7r4c0sK5Zh5Voc6JuIpnGrz2xNPwy+QBmsLALfrx8fuQ5gu6WkRO1aLxtQTPXJ2DkiqK
         Ek3g==
X-Gm-Message-State: APjAAAX0OR1EicBmVrKip3n/Y21GoMV9pNwNQHAQPyQfld44elt/YWhN
        VZMfaFXCmwHeKx2OfoiU4TLdInYXaw/IeCOtX2alUzDq
X-Google-Smtp-Source: APXvYqxP9BSs2f9eW19gk//YpIr/mC7i5kIXn7ncraqzN/SfeXYfSH8olKKodwdZrgz6YXA/ADMPRECRS1VaiRFSJBE=
X-Received: by 2002:a50:9f42:: with SMTP id b60mr2584517edf.192.1567509713140;
 Tue, 03 Sep 2019 04:21:53 -0700 (PDT)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Tue, 3 Sep 2019 14:21:41 +0300
Message-ID: <CADUzMVYrdSJYnpS+qiP=cLFshvP7PKYF6CPiufJEaRVmBVFdVA@mail.gmail.com>
Subject: Re: [PATCH v3] libata/ahci: Drop PCS quirk for Denverton and beyond
To:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello guys,

Catching up with the Denverton converstion feels like a deja vu as
this isn't the first time I am looking at datasheets to find out what
engineers have modified this time on intel chipsets.

After carefully reading some datasheets, it is clear that this patch
has a no go. That is because the DNV isn't the only PCH using PCS at
offset 94. The same offset is used at Union Point(200 series) as well
as Lewisburg(C620-series) PCH. As a result, this patch will ensure
offset 92 is used for Lewisburg IDs A182, A186, A202 & A206. In
reality those devices use offset 94 so please be careful here as
things may get nasty. Please assign all devices using offset 94 for
the PCS register to board_ahci_pcs7.

While at it, I have seen that Intel C620 uses device 2822 & 2826.
While 2826 can be added, 2822 has a duplicate entry:
    { PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8 */
    { PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/

This doesn't look good. On ICH8 we need to disable Asynchronous
Notification but which one is applied to Lewisburg? The SNTF one?
It gets more interesting as C620 RSTe 0x2822 uses offset 94 not 92. A
new patch must handle all those chipsets having a different version of
the SATA controller.
