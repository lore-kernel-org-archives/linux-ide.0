Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F276C33CB3
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 08:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661C724684
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 08:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="a9LVcchX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgA1IzS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:55:18 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:36031 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgA1IzS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 03:55:18 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jan 2020 03:55:17 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580201716;
        s=strato-dkim-0002; d=xenosoft.de;
        h=Date:Message-ID:Subject:From:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=DV6ARq2F9g1ctCaD9h1nabvILbdYjY6XmfD/T0ZFLy0=;
        b=a9LVcchXOI19iMIhTb5WRmz6pNm27uoy5/htUwzqubEOyPVJZrntSurNkHQcoca0Sl
        QJx4+0c4vOMhA7pA9mub5Z34UyAWkQB60s8ij1/nGArLi5E5SIgMBMBKVw6+2YsCN2J9
        sIXLN/XNLN2K+HMtbCUzE4z9tn2IioFQgkfMOTX9wzWI9fS3ZRVy0LxoAzp5JIBFaYUm
        a6RXoqgLxXkJPwdVrnho8C/6dR0RZ/7qTf1iHWji74S72vNuT/DJDIbDo2q8E7YOiQFe
        Ne7JAdfWgk/L/l5QAxss9G6JN80wZmC2fMucO508JSjnHQ3q3HqFoSqg8DBSt9Se0vAI
        19Bg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhQIm3EseWh4IuTiRKK0dhKoJuKag=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:34b8:6e34:7a4d:c0db]
        by smtp.strato.de (RZmta 46.1.7 AUTH)
        with ESMTPSA id k0b198w0S8nDLhr
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 28 Jan 2020 09:49:13 +0100 (CET)
To:     linux-ide@vger.kernel.org, Christian Zigotzky <info@xenosoft.de>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH] Using of new SanDisk High (>8G) CF cards with the pata_pcmcia
 driver
Message-ID: <c88372ea-1cb7-6ae4-21dd-ff67304c7885@xenosoft.de>
Date:   Tue, 28 Jan 2020 09:49:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add new SanDisk High (>8G) CF cards to the pata_pcmcia driver.

Signed-off-by: Christian Zigotzky <chzigotzky@xenosoft.de>

diff -rupN a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
--- a/drivers/ata/pata_pcmcia.c    2019-06-23 01:01:36.000000000 +0200
+++ b/drivers/ata/pata_pcmcia.c    2019-06-24 05:43:41.283993351 +0200
@@ -309,6 +309,7 @@ static const struct pcmcia_device_id pcm
      PCMCIA_DEVICE_MANF_CARD(0x0098, 0x0000),    /* Toshiba */
      PCMCIA_DEVICE_MANF_CARD(0x00a4, 0x002d),
      PCMCIA_DEVICE_MANF_CARD(0x00ce, 0x0000),    /* Samsung */
+    PCMCIA_DEVICE_MANF_CARD(0x00f1, 0x0101),        /* SanDisk High 
(>8G) CFA */
      PCMCIA_DEVICE_MANF_CARD(0x0319, 0x0000),    /* Hitachi */
      PCMCIA_DEVICE_MANF_CARD(0x2080, 0x0001),
      PCMCIA_DEVICE_MANF_CARD(0x4e01, 0x0100),    /* Viking CFA */
