Return-Path: <SRS0=USNU=YD=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158C3C4360C
	for <linux-ide@archiver.kernel.org>; Thu, 10 Oct 2019 05:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3FF20B7C
	for <linux-ide@archiver.kernel.org>; Thu, 10 Oct 2019 05:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ngOAU/Ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfJJFdQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Oct 2019 01:33:16 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:10580 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfJJFdQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 10 Oct 2019 01:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570685594; x=1602221594;
  h=mime-version:from:date:message-id:subject:to;
  bh=RvB4beOHJ+bh6/+tuaexoTBtxRmUrxcVHhPsG/H7aFw=;
  b=ngOAU/AoYqFedX+OzOL4pm7XtyZLCjUmzV7+xblAINtdPruMNLIBqS8g
   h2Ff6h+phR4T2OV1PCaznTx2Hls6xrW3wnL5lhcnyygJDYPaOpkUBNlzz
   ZrszOUnnnF++fa2UucHBxx+3mTdlDpHT7Gw8wS2ShxyCKBWU9+he3FFdV
   hsvTZIrT9u9keeZzvuyb5RkN8AcL9Nq2X82+08A0rNX98W67Hv23M7ooV
   f4gsYfY9hJj6O9o1GWgIiWvpqFCthYIHazOW7K6kXz7g3Z5lB8yRMSW8B
   Y7IkPgikw6pgs5thZhwwunTZlABQ+GwWQgvwI2GdoVRWOON/39M9thboH
   A==;
IronPort-SDR: Sb0BE4BzRNDEYXiyoNoQB14D64oRs+EFxrs34MJle3GuWT2gUTq72Qcv+WvvqU4+vSlWkNgwho
 xhBqoK78eQSwp7AtM0+Nzl1k5SNcWrGpEQoiGX1MPPrH4v0Omx+tr5Xizrvn7Zx4xKBHuu5EAv
 RczgTklMntuXTvoZnCzQBCe3P3cpjcoiKumOLTpwcWx8aQPSGKW4vsQ5svAUAYJSLLaomJtDWR
 gaGJgldkBz12rPpyL25eyeebsjVeaWfHmKwh1A15N58WX8zBm8xAQLPTITdOYcRWYMPrVqhUsa
 zCY=
IronPort-PHdr: =?us-ascii?q?9a23=3ASHRf5RcjcMi3AXsgjCjwxn5WlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcSyZR7h7PlgxGXEQZ/co6odzbaP6Oa+AydRsd6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twTcutcZjYZmKas61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXSidPAJ6zb5EXAuUOPehWoYrzqUYQoxSiHgSsGP/jxyVUinPqwaE30e?=
 =?us-ascii?q?IsGhzG0gw6GNIOtWzZo9f0NKYTUeC10a7IxijAYPNWwzj96ZXDfxchoPCNXb?=
 =?us-ascii?q?J/a8vRxVUzGw7LlViQtJDqPymP2usTrmeb8vNtWOSygGAkswF8uiajytsoh4?=
 =?us-ascii?q?XThY8YykrI+Th4zYs3P9G1SUp2bNi5G5VKrS6aLZF5QsY6TmFtvyY116MJtI?=
 =?us-ascii?q?agfCgP1JQn3xnfa+Gbc4SQ4hLsSuKRITBgiXJgYr2/hhKy/VGkyu3yS8W4yV?=
 =?us-ascii?q?hKoytBn9XWuXAN0BvT6seDSvRj5EuuxTGP1wXL5uFFJ0A7i7bbJoY/zrIskp?=
 =?us-ascii?q?cfq0fOEy/slEnrjaKbdF8o9+ms5uj/Z7XpvJ6cN4t6igHkNaQun9SyAOQ5Mw?=
 =?us-ascii?q?gORWeb+Piw2KHt8EDiXbVFkuc2nrPHv5/HOMQXvrS5DBNN0oY/9xa/CC+r0N?=
 =?us-ascii?q?AZnXkBMVJEdwuLj4n0NF7QO/34E/i/jEq2kDtxxPDJIKfhApPTIXjHirvheq?=
 =?us-ascii?q?x960EPgDY0mPJS4YkcI6ELJ/+7DkbhvtvVJhw0KQq5x6DrC4M5nocfX3+fR6?=
 =?us-ascii?q?6VPYvMvlKSoOEiOe+BYMkSojm5Y/wk4eP+yHw0g1kQeYG30pYNLnO1BPJrJw?=
 =?us-ascii?q?Oee3WoyuUBEHYXuEIHTeXswAmQUT9CenCrd6knoCwwEsSrAZqVAsiGgLGH0z?=
 =?us-ascii?q?amVqZRYG8OXluXFnHnX46fHeoHcmSfLtI3wRIeUr30eo4z1Qyp/D36wrsvev?=
 =?us-ascii?q?vG+iQZ7cq4/MV+/avemQxkpm88NNiUz2zYFzI8pWgPXTJjmfkn+UE=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GLAwBYwp5dh0WnVdFlDoIzhBGETY5?=
 =?us-ascii?q?bhRcBhniGcYo0AQgBAQEOLwEBhxgjNwYOAgMJAQEFAQEBAQEFBAEBAhABAQE?=
 =?us-ascii?q?IDQkIKYVAgjopAYNVEXwPAiYCJBIBBQEiATSDAIJ4BaQngQM8iyaBMohlAQk?=
 =?us-ascii?q?NgUgSeiiMDoIXgRGDUIdSgl4EgTkBAQGVL5ZXAQYCghAUjFSIRRuCKgGXFS2?=
 =?us-ascii?q?OAJlPDyOBRYF8MxolfwZngU9PEBSBaY1xWySRSwEB?=
X-IPAS-Result: =?us-ascii?q?A2GLAwBYwp5dh0WnVdFlDoIzhBGETY5bhRcBhniGcYo0A?=
 =?us-ascii?q?QgBAQEOLwEBhxgjNwYOAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIKYVAgjopA?=
 =?us-ascii?q?YNVEXwPAiYCJBIBBQEiATSDAIJ4BaQngQM8iyaBMohlAQkNgUgSeiiMDoIXg?=
 =?us-ascii?q?RGDUIdSgl4EgTkBAQGVL5ZXAQYCghAUjFSIRRuCKgGXFS2OAJlPDyOBRYF8M?=
 =?us-ascii?q?xolfwZngU9PEBSBaY1xWySRSwEB?=
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208";a="81861839"
Received: from mail-lf1-f69.google.com ([209.85.167.69])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 22:32:44 -0700
Received: by mail-lf1-f69.google.com with SMTP id z24so1070369lfb.15
        for <linux-ide@vger.kernel.org>; Wed, 09 Oct 2019 22:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BKv+zYAxPAe9xy/3rqyjgE0Q508CSlpep/D1x2EiUB4=;
        b=H3cCVQXTihlRXpoaWFEKjDRz4pV1xk/v+XXW1bBuAxOz7x/gHyvQrWMWwLQjZJfzVO
         n5qKT+/6AvXGtUAu4mje+ILq5CBbWLQdB+D20pOCQcs65yX6xE4mqedOuU6if4Xda4Xo
         HeDzNGLqv1v0maR4vynilDSKLO1mCJtJvHhmo/FCpCCHTMJ/zzv+Aa5hAElmVGNfIuzb
         2PU3t34pJqyjZMRcW89hJoEkH8HH44dsElu/TL35RB6A5VaYmO/xRQqA2+N5sZK8YcGW
         EG6f0oW9Ldh/lk9Hri2ZX0T8or273ZeQEaePN8dM5ZpnNMbG0YeKoGA2quT83RTbPbEd
         eQvA==
X-Gm-Message-State: APjAAAV1lPLhKtqcp+xAnmjo+3CSTXHZrhtep8Nwoa1R3Z9bTCN0ENuz
        s622dNrC8DSuKrPGD8F19DpzltY1c0Pmc+3C5gNbLGmj9D1T0ixO+7fDF8i3gK1lOG9P9nzMpA2
        T9MhFBaSf+0n+rYVrVUb5LclnOar+6NDQJ3F8kA==
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr4878459ljc.97.1570685564167;
        Wed, 09 Oct 2019 22:32:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzXtuaVfh6FwAnhgdZW/B5B3OiSHp4oGbk49Vc2sdQ51k/MQiWe6cExDapm9ByzkBtotjY7eq65bQwlL/tHon4=
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr4878448ljc.97.1570685563972;
 Wed, 09 Oct 2019 22:32:43 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 9 Oct 2019 22:32:18 -0700
Message-ID: <CABvMjLS52a75=WBPvG63xywiMTpGZCYikp6DGFQ-fn8wN_62DQ@mail.gmail.com>
Subject: Potential NULL pointer deference inata: sata_rcar
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi All:
In function sata_rcar_bmdma_fill_sg, macro for_each_sg uses sg_next(),
which could return NULL as "sg", however, there's no check before
dereferencing it (in sg_dma_address()), which is potentially unsafe.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
