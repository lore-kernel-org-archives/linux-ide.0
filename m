Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D853C35DF9
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2202469C
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rkK8pFDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgB0SYn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:24:43 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59017 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbgB0SWm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:42 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182239euoutp0219ad08183b5cfdcc3c2da95fe1544917~3VXYAHAUn0821308213euoutp02N
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200227182239euoutp0219ad08183b5cfdcc3c2da95fe1544917~3VXYAHAUn0821308213euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827759;
        bh=m32RqaDou6fupfVccvpGodfjD3VteQqpt6yUMPk2G7M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rkK8pFDpkym1cDrdwWgFmsKwidYTp+d90l9lKu1roefHK0gFoblDV1L8idSaTuMAP
         VrvKuujWDBnAq7XrQBe7vWsfIUajBlNgqch3TUzI5ysrzqCg5CKcT2ZHfp2ld9wro5
         bHsXBTz1RJXIF6KkC+jK3BiDKE1VV6sFAfI5BcfM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182239eucas1p2d42e20f3124ee06e00d142851528d4ac~3VXXyhxwc1998119981eucas1p2e;
        Thu, 27 Feb 2020 18:22:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 35.05.60698.EE8085E5; Thu, 27
        Feb 2020 18:22:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182238eucas1p1a4a5546e46b2385057f41528bd759aea~3VXXYPkzR1937419374eucas1p12;
        Thu, 27 Feb 2020 18:22:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227182238eusmtrp239a07e8eaddccb80f9a9a1084a08b6cf~3VXXXnPix1813218132eusmtrp2f;
        Thu, 27 Feb 2020 18:22:38 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-f3-5e5808ee7d21
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4B.B1.08375.EE8085E5; Thu, 27
        Feb 2020 18:22:38 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182238eusmtip23747169db0376b49b2d1ebe0411ec09e~3VXW7EBlN2149421494eusmtip2E;
        Thu, 27 Feb 2020 18:22:38 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 00/27] ata: optimize core code size on PATA only setups
Date:   Thu, 27 Feb 2020 19:21:59 +0100
Message-Id: <20200227182226.19188-1-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7rvOSLiDBbNYbRYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnv9n5jK1ihV7H/SBNzA+MF1S5GTg4J
        AROJbbevsHcxcnEICaxglGidv5oRwvnCKHF/13GozGdGiWtb/zPBtKzd9YkVIrGcUeLOnXPs
        cC3tl76zglSxCVhJTGxfxQhiiwgoSPT8XskGUsQs8J5RYsWkvSwgCWEBL4mXh6cxg9gsAqoS
        F273gsV5BWwlrk/ZygixTl5i67dPrBBxQYmTM5+A1TADxZu3zmYGGSoh0M8uMf/SNnaIBheJ
        z5cnQDULS7w6vgUqLiPxf+d8JoiGdYwSfzteQHVvZ5RYPvkfG0SVtcSdc7+AbA6gFZoS63fp
        Q4QdJbbt284EEpYQ4JO48VYQ4gg+iUnbpjNDhHklOtqEIKrVJDYs28AGs7Zr50pmCNtDov/D
        XTBbSCBWYumSW+wTGBVmIXltFpLXZiHcsICReRWjeGppcW56arFxXmq5XnFibnFpXrpecn7u
        JkZgMjr97/jXHYz7/iQdYhTgYFTi4V2wIzxOiDWxrLgy9xCjBAezkgjvxq+hcUK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUwNmaK6bxy+FhRsNYvpEpT
        te/TvE9f3ho8WFl0zeuWnER6HquuVfOd3P4F3t/OdUoqi855fNmi+wezyO1PRvWXTKzOfvl3
        ct0dYTvzHu9qzY/szQeKn38yM75VL88ivaOYKTAxvLCk9EPBy+Ypvw749t7ba9Mr6TBt3U6e
        uROnOjUW/Km4+b9XiaU4I9FQi7moOBEAvlgfa0IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e/4Pd13HBFxBmu2qlqsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYx3e7+xFazQq9h/pIm5gfGCahcjJ4eEgInE2l2fWLsYuTiEBJYySsy+
        d4upi5EDKCEjcXx9GUSNsMSfa11sEDWfGCV+tH1iAUmwCVhJTGxfxQhiiwgoSPT8XglWxCzw
        lVFi6aRuZpCEsICXxMvD08BsFgFViQu3e8GaeQVsJa5P2coIsUFeYus3kCtA4oISJ2c+Aath
        Boo3b53NPIGRbxaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI2DbsZ+bdzBe
        2hh8iFGAg1GJh3fBjvA4IdbEsuLK3EOMEhzMSiK8G7+GxgnxpiRWVqUW5ccXleakFh9iNAU6
        diKzlGhyPjA680riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MNpx
        3JMxXNsT8XXKvxdZqScCDx5wmBvlYXCfJYM5puFiMj+zvpHt5HPzns9W/aplfjriq5103V4B
        Gxkzvsfqrw/+4rnfUlR3/++Gx6wnt4rc3Kf4L0zkS2nlJxlJp82rl/X4zOtqn2brqzDzfdpM
        1ffTLC57pMwRFC5V+/RmQgsPk/TVL9tvBSixFGckGmoxFxUnAgDfwRF4lgIAAA==
X-CMS-MailID: 20200227182238eucas1p1a4a5546e46b2385057f41528bd759aea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182238eucas1p1a4a5546e46b2385057f41528bd759aea
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182238eucas1p1a4a5546e46b2385057f41528bd759aea
References: <CGME20200227182238eucas1p1a4a5546e46b2385057f41528bd759aea@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

There have been reports in the past of libata core code size
being a problem in migration from deprecated IDE subsystem on
legacy PATA only systems, i.e.:

https://lore.kernel.org/linux-ide/db2838b7-4862-785b-3a1d-3bf09811340a@gmail.com/

This patchset re-organizes libata core code to exclude SATA
specific code from being built for PATA only setups.

The end result is up to 24% (by 23949 bytes, from 101769 bytes to
77820 bytes) smaller libata core code size (as measured for m68k
arch using modified atari_defconfig) on affected setups.

I've tested this patchset using pata_falcon driver under ARAnyM
emulator.


patches #1-11 are general fixes/cleanups done in the process of
making the patchset (there should be no inter-dependencies between
them except patch #10 which depends on patch #9)

patch #12 separates PATA timings code to libata-pata-timings.c file

patches #13-15 let compiler optimize out SATA specific code on
non-SATA hosts by adding !IS_ENABLED(CONFIG_SATA_HOST) instances

patches #16-22 separate SATA only code from libata-core.c file to
libata-sata.c one

patches #23-24 separate SATA only code from libata-scsi.c file to
libata-sata.c one

patches #25-26 separate SATA only code from libata-eh.c file to
libata-sata.c one

patch #27 makes "libata.force" kernel parameter optional


Changes since v2
(https://lore.kernel.org/linux-ide/20200207142734.8431-1-b.zolnierkie@samsung.com/):
- rebased on top of next-20200227
- added "ata: optimize ata_scsi_rbuf[] size" patch

Changes since v1
(https://lore.kernel.org/linux-ide/20200128133343.29905-1-b.zolnierkie@samsung.com/):
- added Acked-by: tag from Tejun to "ata: remove stale maintainership
  information from core code" patch
- added Reviewed-by: tag from Martin to "ata: make SATA_PMP option
  selectable only if any SATA host driver is enabled" patch
- added Reviewed-by: tag from Christoph to following patches:
  - "ata: simplify ata_scsiop_inq_89()"
  - "ata: use COMMAND_LINE_SIZE for ata_force_param_buf[] size"
  - "ata: optimize struct ata_force_param size"
  - "ata: move EXPORT_SYMBOL_GPL()s close to exported code"
  - "ata: remove EXPORT_SYMBOL_GPL()s not used by modules"
- converted "ata: add CONFIG_SATA_HOST=n version of ata_ncq_enabled()"
  patch to use IS_ENABLED()
- added "ata: let compiler optimize out ata_dev_config_ncq() on
  non-SATA hosts" and "ata: let compiler optimize out ata_eh_set_lpm()
  on non-SATA hosts" patches
- moved "ata: move sata_scr_*() to libata-core-sata.c" patch just
  after "ata: start separating SATA specific code from libata-core.c"
  one
- dropped no longer needed patches (code savings <= 8 bytes):
  - "ata: move ata_do_link_spd_horkage() to libata-core-sata.c"
  - "ata: move ata_dev_config_ncq*() to libata-core-sata.c"
  - "ata: move sata_print_link_status() to libata-core-sata.c"
  - "ata: move sata_down_spd_limit() to libata-core-sata.c"
  - "ata: move sata_link_init_spd() to libata-core-sata.c"
  - "ata: move ata_eh_set_lpm() to libata-core-sata.c"
- removed superfluos ifdefs
- dropped file names in top of file headers
- merged libata-scsi-sata.c and libata-eh-sata.c into libata-sata.c
- emphasised in patch descriptions that atari_defconfig used for
  measurements has been modified (original one is still using
  deprecated IDE subsystem)
- added "ata: make "libata.force" kernel parameter optional" patch

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (27):
  ata: remove stale maintainership information from core code
  ata: expose ncq_enable_prio sysfs attribute only on NCQ capable hosts
  ata: make SATA_PMP option selectable only if any SATA host driver is
    enabled
  sata_promise: use ata_cable_sata()
  ata: simplify ata_scsiop_inq_89()
  ata: use COMMAND_LINE_SIZE for ata_force_param_buf[] size
  ata: optimize struct ata_force_param size
  ata: optimize ata_scsi_rbuf[] size
  ata: move EXPORT_SYMBOL_GPL()s close to exported code
  ata: remove EXPORT_SYMBOL_GPL()s not used by modules
  ata: fix CodingStyle issues in PATA timings code
  ata: separate PATA timings code from libata-core.c
  ata: add CONFIG_SATA_HOST=n version of ata_ncq_enabled()
  ata: let compiler optimize out ata_dev_config_ncq() on non-SATA hosts
  ata: let compiler optimize out ata_eh_set_lpm() on non-SATA hosts
  ata: start separating SATA specific code from libata-core.c
  ata: move sata_scr_*() to libata-sata.c
  ata: move *sata_set_spd*() to libata-sata.c
  ata: move sata_link_{debounce,resume}() to libata-sata.c
  ata: move sata_link_hardreset() to libata-sata.c
  ata: move ata_qc_complete_multiple() to libata-sata.c
  ata: move sata_deb_timing_*() to libata-sata.c
  ata: start separating SATA specific code from libata-scsi.c
  ata: move ata_sas_*() to libata-sata.c
  ata: start separating SATA specific code from libata-eh.c
  ata: move ata_eh_analyze_ncq_error() & co. to libata-sata.c
  ata: make "libata.force" kernel parameter optional

 drivers/ata/Kconfig               |   77 ++
 drivers/ata/Makefile              |    2 +
 drivers/ata/libata-core.c         | 1126 ++--------------------
 drivers/ata/libata-eh.c           |  224 +----
 drivers/ata/libata-pata-timings.c |  192 ++++
 drivers/ata/libata-sata.c         | 1483 +++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c         |  544 +----------
 drivers/ata/libata-sff.c          |    4 -
 drivers/ata/libata.h              |   25 +-
 drivers/ata/sata_promise.c        |    8 +-
 drivers/scsi/Kconfig              |    1 +
 drivers/scsi/libsas/Kconfig       |    1 +
 include/linux/libata.h            |  163 ++--
 13 files changed, 2009 insertions(+), 1841 deletions(-)
 create mode 100644 drivers/ata/libata-pata-timings.c
 create mode 100644 drivers/ata/libata-sata.c

-- 
2.24.1

