Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D529C433B4
	for <linux-ide@archiver.kernel.org>; Mon, 19 Apr 2021 16:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A69861157
	for <linux-ide@archiver.kernel.org>; Mon, 19 Apr 2021 16:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbhDSQv2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 19 Apr 2021 12:51:28 -0400
Received: from mx-lax3-1.ucr.edu ([169.235.156.35]:23073 "EHLO
        mx-lax3-1.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbhDSQvS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 19 Apr 2021 12:51:18 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2021 12:51:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1618851048; x=1650387048;
  h=mime-version:from:date:message-id:subject:to;
  bh=XOX1KABw/CWJsxZ9P10UM6/oI8q4hC2YjSbUTHXmbZs=;
  b=eFqQ7JM+x35riV2zXQG67gmjZg6sH0ORHqGVD5aEuwgmhkFGhtjWxiQ3
   rTQfXhmFSNzC/vRhDgKWqPedaW6hTCiZ8Ue74AssI78JKUgIr7PkWbzvW
   /t60+fOQVuuaaVvrr0MvsP4Qt/6szXwFep9IFwNxPA1fzcforYb14MhIs
   wATjg1Ss9dhdZhEXhJkRrwFpHNdTxUA2S7JI0A83UhlQfRf59gBG+s7yE
   SaP13MBvcDq6t6bUVBuDQJNY0ie/tDktMsDaeWy4TOGO97wmJ77d+eRKt
   DDQg2dF/Tk+nTSO+YRWJHxDBLHYkx7sQGzQdV33o+Poo5x+KUFn85JyMc
   Q==;
IronPort-SDR: JOJE4r7Ukx1dtj1405qPYTcYjgbEvT2O+DJgJbYiWzlROabps8aqkA2VUCwgAdwHcr2aIFNmtl
 r3M2Ckfr+fQ1UyleiFwoSYclY6fQk6kZWnJWIfGOZC4WQnuZnsUqvsSf1BDxc4DF3tmfnlJfnV
 yfS6+bIqoh41HkevB8GXwOSAJyGsE0+oaNYIZA13bLmFviov4oSKmnyUltSmsszAUBqi4Pvx7R
 1IIbKdS7nW59olw3p6beWLLwC5EEnuTPuDWkLFDIA2RYAGGLyqO5ZSNix6JzUtr4BUsjcSMHrj
 hh8=
X-IPAS-Result: =?us-ascii?q?A2E3AAC3sn1ggMfXVdFaHQEBAQEJARIBBQUBQIE+CAELA?=
 =?us-ascii?q?YN3a4RDiCSKXIIQAZIbhTaBfAIJAQEBDzQEAQGGRwIlNAkOAgMBAQEDAgMBA?=
 =?us-ascii?q?QEBAQYBAQEBAQEFBAEBAhABAW6FF0aCOCkBhAQRfAMMAiYCJBIBBQEiARIIG?=
 =?us-ascii?q?oVXnV+BBD2LMYEygQGIDQEJDYFEEn4qAYcCgl2EHIIngRM2gjZ0hAmDUIJhB?=
 =?us-ascii?q?IJHAYENgXCCBgEBAZ1YnCwBBgKCdRmdDCOUI5BeAS2PVYUco1MQI4ExghQzG?=
 =?us-ascii?q?iV/BmeBS1AZDo4rFo5LJC84AgYKAQEDCYpJgkYBAQ?=
IronPort-PHdr: A9a23:DVH6ahUCW3inrxfrDpNNao8186/V8KwSVTF92vIco4ILSbyq+tHYB
 Gea288FpGHAUYiT0f9Yke2e6/mmBTVRp8zZ7DtdINRlbFwssY0uhQsuAcqIWwXQDcXBSGgEJ
 vlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+I
 A+5oAnMssQam5VuJro+xxfGoHZFePldyH91K16Ugxvy/Nq78oR58yRXtfIh9spAXrv/cq8lU
 7FWDykoPn4s6sHzuhbNUQWA5n0HUmULiRVIGBTK7Av7XpjqrCT3sPd21TSAMs33SbA0Ximi7
 7tuRRT1hioLKyI1/WfKgcFrkqlVvAyuqAB+w47MYYGaKvx+fr/GfdgHQWZNR9tdWzBdDo+5a
 YYEEugPMvtCr4TlqFQArRWwCwqxCu3x1jBFnWP20bEg3ug9DQ3KwA4tEtQTu3rUttX1M6ISX
 Pi3w6nJzDTDb+5W2TDg44fLchAuu/CMVq93fMvRyEgvFxnKjlSMpYD5MT6YzfkNvHSB7+Z6S
 +2glnMnphh3rzOyycgilpPHiZgJylDY6yp52oA1KMW5RUN/fNOpDpVeuS+HOoZrQs0uXXxkt
 Dg+x7EbuJO1cyoHxZs5yxPedfCKd5SE7xz/WOuTLzl0mXxoda67ihu890Wr1+7yVtGs3VpUs
 iZIlsPAu3MN2hDJ9MSLV/tw8l281TuL0w3e7PxPL1oumqrBMZEhx6Y9lp8UsUveACD7gF72j
 KqKdkU8/eio9vjnbq3mppCCM490jRnzMqE0lcy+BeQ0KxAOX2eG9eil2r3v4En0TbFQgv05l
 anZt5/aJcAFqaKjHwBV1YMj5w6+DzegztsYgWEKIExZdB+DlYTkOFHDLOrmAfuig1mgiipny
 vTCM7H5B5XCNHnDkLPvfbZn7E5czRI+zNBe5pJUEL4BIe7/VlP/udHDEx82Lxa0z/z5B9pgy
 4MSQXiPDbOBMKPOrV+I4foiI+2NZI8TpTb8JOEp5//zgnAnglIdY6ap0oUNaHyiHfRpPV+ZY
 XzyjdcFC2sKuRA+TOO5wGGFBBJaeXe+F4c94jU2EsryAY7dS4WFjLWf0SK/GZNKIGZLFgbIW
 XPpcZiUHvYAZQqMLcJ71D8JT76sT8kmzx79mhX9zu9WL/jU5ypQh5Lq1ZAh9v/TnBBqrWdcE
 s+HlWyBUjcnzSszWzYq0fUn8gRGwVCZ3P092qQAfeE=
IronPort-HdrOrdr: A9a23:KH8Asqut1SFlXTszwHHuP8wH7skD/dV00zAX/kB9WHVpW+afkN
 2jm+le6A/shF8qKRYdsP2JJaXoewK+ybdb+o8UVI3DYCDDmE+FaL5v9pHjxTqIIUzD38pQz7
 1pfaQ7KPCYNykZse/A7AO1E8ktzbC8mcjCuc7l03xvQQt2ApsQijtRNwDzKDwTeCB2QbQ8UL
 6R/NBOqTblQ2kec8jTPBQ4dtmGidvMmpfrJTMlJzpi0gmBiju09KX3eiLz4j4uFx1Ix7km/S
 z+lxHhop+kr+qwxnbnuFP73tBslNHsysROCaW35qYoFgk=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="35649640"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2021 09:43:39 -0700
Received: by mail-pg1-f199.google.com with SMTP id c19-20020a631c530000b0290209a37c0a62so723106pgm.16
        for <linux-ide@vger.kernel.org>; Mon, 19 Apr 2021 09:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5DoFmLkOugkdGtUuoEp2CJYFnm0jZsYxw/2XjMsW6LA=;
        b=T1BYEPBPOzCZDBbMgGxF/ZIl6U/1ewFNlGThxO3mg3UHHDEKA/wq0sHkUYghHsIboH
         6kATzU2+xpEissNsKRjDjmZ+kIKcbiGy9V+xJR9rsCRc6/9/WvA6VZAdjaW1Db1MCqEd
         4qLbKXapTnCMFbklipcH2X1cWJUbPaPkr3LpD2f4eMNVFDRVMMQ6dB+6itVYBPZ5fxeu
         0ujY0ihMbyrt6hpnkZ+Ny00vwD4IhAXT1QxzAHspFIQe1hmAGQUICwrZfXI9mTsfsGsd
         fTpPiVF0IXVQo6/Wc77qA/feKhikyqcUYU0QINLRmQUxW54n6Svgl2xS6qsKh4GBLzij
         014A==
X-Gm-Message-State: AOAM5336txuTRwOcPc+5TlmfO2W3FdQQkNnfzOMYagy72KMvxxtpjjHm
        AyAAkrKRCcN4xuIVIcs0EBSmuSneC5Lj5cO/uqGnq0QG5sVxJQZmzOQ7PhhLoBw3Z4+9vUOWrEL
        ZIFk08e4QKHVeaP5Lnz1MuFU5OVExhnr4hMj4Lg==
X-Received: by 2002:a17:90b:14c4:: with SMTP id jz4mr25517802pjb.144.1618850618242;
        Mon, 19 Apr 2021 09:43:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv0vLQWLJU9/vs3gSMZaNBRbVETl5lpzmpIMPE3xw6mRrr8SKbaW0WWKReY1MeX12NKZ6ffDWrvBX0/iGWVts=
X-Received: by 2002:a17:90b:14c4:: with SMTP id jz4mr25517786pjb.144.1618850618070;
 Mon, 19 Apr 2021 09:43:38 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 19 Apr 2021 09:43:27 -0700
Message-ID: <CABvMjLSff9jZe4D-vOHrwn4gsgoFEShuJo6qjq9n3cBEjnn5yA@mail.gmail.com>
Subject: [PATCH] piix: Fix uninitialized use in piix_check_450nx()
To:     David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Inside the function piix_check_450nx(), variable "cfg" could be
uninitialized if pci_bus_read_config_word() returns
PCIBIOS_BAD_REGISTER_NUMBER. However, it is directly used in the
if statement, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/ide/piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/piix.c b/drivers/ide/piix.c
index a671cead6ae7..e01266c6cbbc 100644
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -397,7 +397,7 @@ static int piix_init_one(struct pci_dev *dev,
const struct pci_device_id *id)
 static void piix_check_450nx(void)
 {
        struct pci_dev *pdev = NULL;
-       u16 cfg;
+       u16 cfg = ~0;
        while((pdev=pci_get_device(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
        {
                /* Look for 450NX PXB. Check for problem configurations
-- 
2.31.1
