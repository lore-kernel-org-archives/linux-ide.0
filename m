Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0658C2D0EE
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F142073E
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IYiJpqi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgCZP6l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:58:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52598 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgCZP6k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155838euoutp028b7ce136c918739cd19f2581225fdbf4~-5doj4BNl0075000750euoutp02K
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200326155838euoutp028b7ce136c918739cd19f2581225fdbf4~-5doj4BNl0075000750euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238318;
        bh=YI0ewHXepVDsIyWlbSo2RWDfuEOtnkbpuTP1vaPKyws=;
        h=From:To:Cc:Subject:Date:References:From;
        b=IYiJpqi1qDmG30q3EwCwaCAw2mtVYmVeMaLCwXFoltwCgc25TAST9W2YFpYna/43a
         CNsa0ZC8U5RsAkOM6a2tSYM5hx/a4WD8KUPE1sJpSP2eJOW39vlxB/GBna7gECkk9A
         hPYc+4I8I0OS9UEqWZrw/ngYZ0ogr9/uxHKO12J0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326155838eucas1p246a9190dbacf90b905eca292048acc28~-5doOjrKq2255222552eucas1p2D;
        Thu, 26 Mar 2020 15:58:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D8.F5.61286.E21DC7E5; Thu, 26
        Mar 2020 15:58:38 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155838eucas1p2a1c1f5c08832410d1e2b5a5ea8226151~-5dn-R2ih3015130151eucas1p2r;
        Thu, 26 Mar 2020 15:58:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155838eusmtrp17dff74e026049b5de1b58f4f0fd4c965~-5dn_qYH_2090020900eusmtrp1O;
        Thu, 26 Mar 2020 15:58:38 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-b1-5e7cd12e7ccb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 36.CA.07950.E21DC7E5; Thu, 26
        Mar 2020 15:58:38 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155837eusmtip1ab01c7dc76a38b7df3d3840af0cd9879~-5dniwOZq0490504905eusmtip1O;
        Thu, 26 Mar 2020 15:58:37 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 00/27] ata: optimize core code size on PATA only setups
Date:   Thu, 26 Mar 2020 16:57:55 +0100
Message-Id: <20200326155822.19400-1-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87p6F2viDLbtl7dYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkLb2xhK5hvVPH2zVHmBsYWzS5GTg4J
        AROJy3tPs3cxcnEICaxglDg8bT4jhPOFUeLMy01MEM5nRollTxeww7Rc3X0Rqmo5o8T3DevY
        4Vqu7N0FVsUmYCUxsX0VI4gtIqAg0fN7JRtIEbPAe0aJFZP2soAkhAW8JPbubmYDsVkEVCV+
        bToNZvMK2ErsWnqWGWKdvMTWb59YIeKCEidnPgHrZQaKN2+dzQwyVEKgn13i0+O5UPe5SBw+
        +BCqWVji1fEtUHEZidOTe1ggGtYxSvzteAHVvZ1RYvnkf2wQVdYSd879ArI5gFZoSqzfpQ8R
        dpRo6ZjLCBKWEOCTuPFWEOIIPolJ26YzQ4R5JTrahCCq1SQ2LNvABrO2a+dKqHM8JJYu/AH2
        i5BArMSU/Y2sExgVZiF5bRaS12Yh3LCAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZG
        YDI6/e/4px2MXy8lHWIU4GBU4uHVaKmJE2JNLCuuzD3EKMHBrCTC+zQSKMSbklhZlVqUH19U
        mpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVAOjxq1dmY6/3Lf65Ig89LLIqwv+
        W+ojf4GBXZMt93DDZNVDrccdM1NOfNJrm3foVkTe8cd+wnI7b06x3OPz5OfvupTNt7gzXT/W
        sFZUdTaFMPCtMq3fX6rnoitxQsBg68tsxo3XXM93zWdkPMfql7lyfb2lwn9l+wnTxMX4lc8/
        /lQwJ1120m8lluKMREMt5qLiRADr/UwNQgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4XV29izVxBhtf81isvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYyFN7awFcw3qnj75ihzA2OLZhcjJ4eEgInE1d0XGbsYuTiEBJYySjxo
        nM3excgBlJCROL6+DKJGWOLPtS42EFtI4BOjxMqOahCbTcBKYmL7KkYQW0RAQaLn90o2kDnM
        Al8ZJZZO6mYGSQgLeEns3d0M1swioCrxa9NpMJtXwFZi19KzzBAL5CW2fvvEChEXlDg58wkL
        iM0MFG/eOpt5AiPfLCSpWUhSCxiZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgSG/7ZjP7fs
        YOx6F3yIUYCDUYmHV6OlJk6INbGsuDL3EKMEB7OSCO/TSKAQb0piZVVqUX58UWlOavEhRlOg
        YycyS4km5wNjM68k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6PK
        6SVBob5/zkz0/jjvwso1xUrbdX+bXzERWW2x/Fuu9/ZX7ut4y3r5LyxsORMt6ugcq7F5atOU
        AI2OX6VTC/atiPqmWq6bwt4uXLmk4St/oN7++8rGGsed9n6pT1O8suOP8GOf4HKGopYDG6v6
        nkZ7t1wJFtP7dyTEWll3gdPXEonjMfd+yCmxFGckGmoxFxUnAgBadmOilQIAAA==
X-CMS-MailID: 20200326155838eucas1p2a1c1f5c08832410d1e2b5a5ea8226151
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155838eucas1p2a1c1f5c08832410d1e2b5a5ea8226151
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155838eucas1p2a1c1f5c08832410d1e2b5a5ea8226151
References: <CGME20200326155838eucas1p2a1c1f5c08832410d1e2b5a5ea8226151@eucas1p2.samsung.com>
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


Changes since v4
(https://lore.kernel.org/linux-ide/20200317144333.2904-1-b.zolnierkie@samsung.com/):
- rebased on top of next-20200326
- added Reviewed-by tags from Christoph

Changes since v3
(https://lore.kernel.org/linux-ide/20200227182226.19188-1-b.zolnierkie@samsung.com/):
- rebased on top of next-20200317
- fixed sdev_attrs initializer entry defined twice issue found by
  kbuild-test-robot/sparse in "ata: expose ncq_enable_prio sysfs
  attribute only on NCQ capable hosts" patch

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
 include/linux/libata.h            |  172 ++--
 13 files changed, 2015 insertions(+), 1844 deletions(-)
 create mode 100644 drivers/ata/libata-pata-timings.c
 create mode 100644 drivers/ata/libata-sata.c

-- 
2.24.1

