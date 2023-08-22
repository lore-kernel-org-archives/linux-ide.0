Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE54AEE49AF
	for <linux-ide@archiver.kernel.org>; Wed, 23 Aug 2023 01:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjHWBp1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Aug 2023 21:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjHWBpW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 22 Aug 2023 21:45:22 -0400
X-Greylist: delayed 916 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 18:45:20 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DACE4B
        for <linux-ide@vger.kernel.org>; Tue, 22 Aug 2023 18:45:19 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-8f-64e54c315fd8
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id EA.9C.10987.13C45E46; Wed, 23 Aug 2023 05:00:50 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=FPeHwQymFr9KtTfwpVWkzstRC+g+ALivDbN7xfPDg7ybdr0zpgtD5RxIptnBm4MKG
          Es72MKi+1HvjWvg/ceWzTtVgPFRxGh/S5ob4xjMWUyujCh8e2O/+GsPAL5QZnuknD
          LCCL4hlMvOUQ/JvaGIm6ZjQ70h5XtTADjinS84MFE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=PaMxYC0DQQVHQxMal7TISByB9od33FFXZtV7KIcxxIyzPV51Z8Ae6qDojYnOw3xdv
          pPCCGNJRFcuIkElceMaZg2Eq2zx7rnm7OOP+XZXCyoyYMl7xbPcfEEsP59msCebSu
          rhBEQNSvQ3Qtft3nikSmOeJi7VPOzr77w4sTaYV/w=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:02 +0500
Message-ID: <EA.9C.10987.13C45E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-ide@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:16 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVyyUKGW9fI52mKweVLbBbHdjxicmD0+LxJ
        LoAxissmJTUnsyy1SN8ugStjyboLLAW7mSva+hexNDA+Zupi5OCQEDCROPZPvYuRi0NIYA+T
        xLfJ35lBHBaB1cwSPZuPskM4D5kl+pecZocoa2aUuNfYB1TGycErYC1x+u1lJhCbWUBP4sbU
        KWwQcUGJkzOfsEDEtSWWLXzNDLKOWUBN4mtXCUhYWEBM4tO0ZewgtoiArET/x1NgrWwC+hIr
        vjYzgtgsAqoSr85dA4sLCUhJbLyynm0CI/8sJNtmIdk2C8m2WQjbFjCyrGKUKK7MTQSGWrKJ
        XnJ+bnFiSbFeXmqJXkH2JkZgGJ6u0ZTbwbj0UuIhRgEORiUe3p/rnqQIsSaWAXUdYpTgYFYS
        4ZX+/jBFiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+t0LNkIYH0xJLU7NTUgtQimCwTB6dUA2NQ
        x0OXl7oSeUdtldvfl2z/d8x5+hyx4nzlJVmdwk03lPwm5hzuU/KxU/NpYOwX9rEJvDA3IvBy
        Y7LvTUt/19R17bMavN4ulrB6zXrXMuTW6+Iv7ZNPvbHy+h7EuClW4fz0vy9DN8+69L38pN4B
        g6UG/6dEFp9c9SXqeYpO+qGyG41vJz4XV1ViKc5INNRiLipOBADXr0pOPwIAAA==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

