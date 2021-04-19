Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4466C433B4
	for <linux-ide@archiver.kernel.org>; Mon, 19 Apr 2021 16:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA666102A
	for <linux-ide@archiver.kernel.org>; Mon, 19 Apr 2021 16:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhDSQwh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 19 Apr 2021 12:52:37 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:51814 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231674AbhDSQwg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 19 Apr 2021 12:52:36 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2021 12:52:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1618851127; x=1650387127;
  h=mime-version:from:date:message-id:subject:to;
  bh=duHvIeHjpjM4a9oNl5UBo/q1t227OzpBT0SpWquEusM=;
  b=i1OE4GAeLr3tJ/5AeVR8+2u8JC8Z6bIctkSM8clO2h0Di1w7ACHflKlA
   Ybg0Klb24/bRUmLjNjHZ0F162WubuMJG284c9zNbeDkzspO/jWu6ShbI2
   /yXZvCGZsqbYkFTu/AZaPu0ePeDq+GUaxjbYDo7UnuXiuEU/BlwprgaV5
   LpmKIwJBO5Z4+UTqAJCXzvWvGQDBHs+l79SN/qPfaUBAJOL3g7xE9GI0p
   8+qOKam1x2VPJsMhx7zkfAiMlyNDunuqYi627rw5bq0k5ffQa2qbn5UyB
   AdlKzz5DjhAbUjJCB5UdABC0//ibFyJkfM/ch1ipQkoxku+V6/09cek4q
   w==;
IronPort-SDR: HBibJguYbx3FQh64RfrZsnS7NbztagJi03pzr6N7ghaHaOYeFbHWjaEq2sWwv14yQWVIENSfDM
 rAP3OxPAE62Sj+Bnb4VbE8tLHJpbqLVyDAyG19VSEP05euZP7S4LO75191s5rnRSTcLQlulnVl
 qxsnFuTfMuNwTBwaBlKo28+kQNg/Bi8WiTmGfPcgJtBf3t5y1D6C2ur1Z5odEBG6oHy+KFUidM
 JaQ8yw8FTfBhRqBr3luOnQdVFh/Mkr6uvnREpWztYQzb2jr7uC/3W6bLJY9bv2jYEHpxMgdJj9
 Vyg=
X-IPAS-Result: =?us-ascii?q?A2EmAACUsn1gf8jWVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4HAQELAYN3a4RDiCSKW4IQAZIbhTaBfAIJAQEBDzQEAQGGRwIlNAkOAgMBA?=
 =?us-ascii?q?QEDAgMBAQEBAQYBAQEBAQEFBAEBAhABAW6FF0aCOCkBhAQRfA8CJgIkEgEFA?=
 =?us-ascii?q?SIBEiKFVwWdWoEEPYsxgTKBAYgNAQkNgUQSfioBhwKCXYQcgieBEzaCNnSEC?=
 =?us-ascii?q?YNQgmEEgkeBDoN2AQEBnVicLAEGAoJ1GZ0MI6UBAS2PVYUco1MQI4ExghQzG?=
 =?us-ascii?q?iV/BmeBS1AZDp0MJC84AgYKAQEDCYpJgkYBAQ?=
IronPort-PHdr: A9a23:U6yE2xcJOM3j3fHLjJ4vX1u3lGM+W97LVj590bIXzolWe6HmxazJe
 XLljd1ThVPEFb/W9+hDw7KP9fy5CCpaucrK7yBKWacPfidNsd8RkQ0kDZzNImzAB9muURYHG
 t9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oI
 xi6sAHcutMIjYd+Jas9xRnEr3hVcOlK2G1kIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q
 79FAjk4Km45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWTS+6
 qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSXNcUspNSyBNB4WxZ
 JYNAeUcJ+ZVt4byqVsAoxW9GAeiGv/gxyRUhnPqx6A2z/gtHR3E0QEmAtkAsG7UrNLwNKoKU
 ++1zajJzTXeb/NRxDzy64jIfQogofqRWr9xccvQyUk1GAPEklmctYLoMiiI1usRqWiX9fRvW
 v+yi2M+rQx6vzegyNs2hIbTmoIV1k7L9T9/wIstJNC1TFN2bMCqHpVeqiyXKot4Tt0/T212v
 Cs217wLt5G5cSUF1pgqxgDTZvibf4WG/h7uVuifLSp2iX95fL+yiRC/+lWjxO3kTsS4zkpGo
 y5fntTPtn0BzQLf5tWIR/dn4EutxSqD2gbO4e9eO080j7DUK5s5z741kZocrFrMEzftmEXzk
 K+WbkIk+vW06+j/YrXpuJucN4hshwH7KKsum8i/Df0gMggKQmSX4Oq82KP/8UHlWrlKgfo2k
 q7WsJDeO8sXvLK2AwhQ0oo76ha/CSmp0MgAkHUZMF5IfAiLgovpNl3UPvz0EPiyj06ynDt32
 /zKJrjhDY/MLnjHnrfhZ7F960tExQszzNFf54hbCrAdLP7vVEL8r8HYAQMjMwCu3enoFch92
 psEWW2TGq+ZLL/SsViQ6+IrIumMYpIVuTnkJ/gk+vHhk2Q0mUESfaa3x5sbcnO4Eep8I0Wff
 3Xshs0NEWAQvgoxH6TWjwigXDhIL1+iVaUxrmUyGIihAK/AS5qrjbjH0CTtWtVSZ2ZbGhWNH
 XrAaYqJQbEPZTiUL8snlSYLBpa7TIp05BC8tBL9g4hnJ+ucrjwKtZvijIAuz/DYj1c/+SEiX
 JfV6H2EU2whxjBAfDQxxq0q5BUlkj++
IronPort-HdrOrdr: A9a23:d2B8W6hQsY9Iwjo9BL6ZVARQEHBQXlEji2hD6mlwRA09T+Wzkc
 eykPMHkSLlkTp5YgBGpfmsMLSNKEmslqJdzpIWOd6ZPDXOnEuNAMVc4ZD5wzvmcheeysd42b
 17e6ZzTP3cZGIK7/rS2wWzH9Y+zNTvysnB7tv29WtnTg1hdshbnmJEIzuce3cGIDVuNN4WEN
 656tBcrzStPU4LZtm2b0NpY8Hz4/PMkpzibVoqJT4CrDOPgzSh9aLgH3GjtCs2Yndgx7Et9G
 SAqQjl/+GYte2hwBO07QDuxqUTo9fqxttdCMHksKR6FgnR
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="208967637"
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2021 09:45:00 -0700
Received: by mail-pl1-f200.google.com with SMTP id 59-20020a1709020241b02900e8de254a18so14265323plc.14
        for <linux-ide@vger.kernel.org>; Mon, 19 Apr 2021 09:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=606lIc0n/SwfFqg3bcljnuj3xNrVoZ0/M3CCbsQUgDM=;
        b=rR9nZS0Ir1lARG6D3lnv+1SqX1awAfoClEtB/SqkcBiMjG4Lj7ekg8YqzCcqYn9i0S
         EY+uhYMhUvS5sRnsJeMIHhD5oLEFSkSxWeiWk/L4ze0uDqX5+bxKmMzUfSOnmmVc3zy5
         /mJhTG4SDgCUHXGUGbeU0xxJh57wBQQRv62tToLKACE2yhw/jVPBpQERefVBGnPOGYW8
         6dhjOLjbgFoKAWcjplpW7gBbwXq3t+vV35Ds7+xRo5trr1P92jBMCTyQjkXt7FLvdEGS
         RuCGPSuykuGf6yjpPbp0dWZuBu2BRWBoXXwOSc1zlE7lELd7dUG0JQRjXoSB7Ab8kJZQ
         2ong==
X-Gm-Message-State: AOAM533IYyDqLrOWCRsXGXN3ffjrlxBV8Dv/CU0Hxd/gFAByV66A+pIi
        ZtzgBMehjHLe2bkOINvDZD/sb3qrlD4kVa1HPd3xW2eO1MlpKeOUmRvXcXhOjgHER179u5NsHjy
        RlqjaavdxM5gG4gXkN7cQyCaxSuU08qtVHX0QEw==
X-Received: by 2002:a17:902:4c:b029:ec:a39a:41ad with SMTP id 70-20020a170902004cb02900eca39a41admr6722635pla.52.1618850699878;
        Mon, 19 Apr 2021 09:44:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoZtTgnMfhsKwkXBdsJ8fu5y1tpVSfP34IOTs31xByBl8rXi1GtJCyci+1KQloigDhhOUApH69W3a3EH+hrOI=
X-Received: by 2002:a17:902:4c:b029:ec:a39a:41ad with SMTP id
 70-20020a170902004cb02900eca39a41admr6722616pla.52.1618850699690; Mon, 19 Apr
 2021 09:44:59 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 19 Apr 2021 09:44:49 -0700
Message-ID: <CABvMjLQY0RaprCf0TUNpQSY2wsDOp0sZNkkWShm_+c+VeM-4=A@mail.gmail.com>
Subject: [PATCH] ata_piix: Fix uninitialized use in piix_check_450nx_errata()
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Inside function piix_check_450nx_errata(), variable "cfg" could be
uninitialized if pci_bus_read_config_word() returns
PCIBIOS_BAD_REGISTER_NUMBER. However, it is directly used in if
statement, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/ata/ata_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 3ca7720e7d8f..0acc1ba9eae2 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1309,7 +1309,7 @@ static int piix_disable_ahci(struct pci_dev *pdev)
 static int piix_check_450nx_errata(struct pci_dev *ata_dev)
 {
        struct pci_dev *pdev = NULL;
-       u16 cfg;
+       u16 cfg = ~0;
        int no_piix_dma = 0;

        while ((pdev = pci_get_device(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_82454NX, pdev)) != NULL) {
-- 
2.31.1
