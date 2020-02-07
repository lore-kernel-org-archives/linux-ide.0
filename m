Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640BEC35250
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4ED21775
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FsrPUcDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgBGO3w (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:29:52 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49530 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBGO1y (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:27:54 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142751euoutp0220ca68bdcc65fe903f66a49d3c272378~xJQqoCTIf2564025640euoutp02I
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:27:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142751euoutp0220ca68bdcc65fe903f66a49d3c272378~xJQqoCTIf2564025640euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085671;
        bh=Q0zpKvRNgz/gxJ8iAVrCi7y/xOUkBAMZYSLecc9T6Ro=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FsrPUcDkwlZP/zdX511f3p9NbP8wANgkM1YC50uB7Tykb3j3qhn2O5XimyTI01Y5o
         hOL9XmpcFtaLgaRvJG2QtwcNviqQ1T/0Nva8UOI96w6iXNQX87xjtDbq+2hpRAhCBf
         KCrQohe1FksHa6MB4qfjwlv/fspWMk+ENTp1z/9I=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142751eucas1p1b4b747ebf0521dbbc02ab7d1ea9b9911~xJQqTyXgs1078610786eucas1p1o;
        Fri,  7 Feb 2020 14:27:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DC.C8.60698.7E37D3E5; Fri,  7
        Feb 2020 14:27:51 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142751eucas1p2499d9a7ebbca93fff43c47629ba8b6ce~xJQp4ru1f3055030550eucas1p2-;
        Fri,  7 Feb 2020 14:27:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207142751eusmtrp2a3a47c5c713fc2a091d45c1944fcce05~xJQp4DEnL1102911029eusmtrp20;
        Fri,  7 Feb 2020 14:27:51 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-b0-5e3d73e72224
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FB.C5.07950.7E37D3E5; Fri,  7
        Feb 2020 14:27:51 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142750eusmtip204d34bcf30b4bffe1316f89710009321~xJQpa_Xhp2944029440eusmtip2W;
        Fri,  7 Feb 2020 14:27:50 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 00/26] ata: optimize core code size on PATA only setups
Date:   Fri,  7 Feb 2020 15:27:08 +0100
Message-Id: <20200207142734.8431-1-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djP87rPi23jDO60yFqsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErozv75azFezTqfj1eTJbA2ObShcjJ4eE
        gInE39ZpTF2MXBxCAisYJY7M7YRyvjBK/Dl2B8r5zChx4MwsRpiWpxO2sEMkljNK/D/3jBkk
        Adbyf3YciM0mYCUxsX0VWIOIgIJEz++VbCANzALvGSVWTNrLApIQFvCSWP5lBVgzi4CqxNV3
        k4CKODh4BWwkri7jglgmL7H12ydWEJtXQFDi5MwnYK3MQPHmrbOZQWZKCPSzS8w8OpMJosFF
        4vqNo1CXCku8Og5yKYgtI/F/53wmiIZ1jBJ/O15AdW9nlFg++R8bRJW1xJ1zv8CuYBbQlFi/
        Sx8i7Cjx5/hjZpCwhACfxI23ghBH8ElM2jYdKswr0dEmBFGtJrFh2QY2mLVdO1dClXhINF7h
        gARVrMSChuOsExgVZiH5bBaSz2YhnLCAkXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZG
        YBo6/e/41x2M+/4kHWIU4GBU4uFNcLSJE2JNLCuuzD3EKMHBrCTC26dqGyfEm5JYWZValB9f
        VJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKYLBMHp1QD483fU25apzWxrjk9ya9QTpXX
        4t/3QnWmF5+50z6GHTl7bvOC8yYf7PpPBYsLB74u3SBhf4T7/eRZLisTw7o6RPIsO+765e5P
        /T+PPfah5Okt5x0NWCSiLMVbs2OkmE6V/ma0lHjac/DqdG/Wm9XKJ/XXuzwt7c8/mcWzM2+v
        5GeJKj9xU89qJZbijERDLeai4kQA7tVjTT8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4Pd3nxbZxBp/mMlusvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYzv75azFezTqfj1eTJbA2ObShcjJ4eEgInE0wlb2LsYuTiEBJYySjw6
        08TSxcgBlJCROL6+DKJGWOLPtS42iJpPjBLdHTuZQBJsAlYSE9tXMYLYIgIKEj2/V4IVMQt8
        ZZRYOqmbGSQhLOAlsfzLCjCbRUBV4uq7SWwgC3gFbCSuLuOCWCAvsfXbJ1YQm1dAUOLkzCcs
        IDYzULx562zmCYx8s5CkZiFJLWBkWsUoklpanJueW2ykV5yYW1yal66XnJ+7iREY/tuO/dyy
        g7HrXfAhRgEORiUe3gRHmzgh1sSy4srcQ4wSHMxKIrx9qrZxQrwpiZVVqUX58UWlOanFhxhN
        gW6dyCwlmpwPjM28knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2M
        e+ru1rX4+rk/O806M/zGv+vnJCZva0vZvv7FH6sV89kZsySnHjxhIVkVt07J8278umOK/ssr
        LaVurcg5rCH2eoYs39dPAnpLnp/xm6O4giXfNv0Qc/ulk2KOIYX1f/ztvrEkd5TbuXS+9Zkd
        u+Jc56J3f8q8ew1OfXTZxjIraJGMLevLUzJOSizFGYmGWsxFxYkAes3SUJUCAAA=
X-CMS-MailID: 20200207142751eucas1p2499d9a7ebbca93fff43c47629ba8b6ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142751eucas1p2499d9a7ebbca93fff43c47629ba8b6ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142751eucas1p2499d9a7ebbca93fff43c47629ba8b6ce
References: <CGME20200207142751eucas1p2499d9a7ebbca93fff43c47629ba8b6ce@eucas1p2.samsung.com>
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

The end result is up to 20% (by 20429 bytes, from 101787 bytes to
81358 bytes) smaller libata core code size (as measured for m68k
arch using modified atari_defconfig) on affected setups.

I've tested this patchset using pata_falcon driver under ARAnyM
emulator.


patches #1-10 are general fixes/cleanups done in the process of
making the patchset (there should be no inter-dependencies between
them except patch #9 which depends on patch #8)

patch #11 separates PATA timings code to libata-pata-timings.c file

patches #12-14 let compiler optimize out SATA specific code on
non-SATA hosts by adding !IS_ENABLED(CONFIG_SATA_HOST) instances

patches #15-21 separate SATA only code from libata-core.c file to
libata-sata.c one

patches #22-23 separate SATA only code from libata-scsi.c file to
libata-sata.c one

patches #24-25 separate SATA only code from libata-eh.c file to
libata-sata.c one

patch #26 makes "libata.force" kernel parameter optional


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

Bartlomiej Zolnierkiewicz (26):
  ata: remove stale maintainership information from core code
  ata: expose ncq_enable_prio sysfs attribute only on NCQ capable hosts
  ata: make SATA_PMP option selectable only if any SATA host driver is
    enabled
  sata_promise: use ata_cable_sata()
  ata: simplify ata_scsiop_inq_89()
  ata: use COMMAND_LINE_SIZE for ata_force_param_buf[] size
  ata: optimize struct ata_force_param size
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
 drivers/ata/libata-core.c         | 1124 ++--------------------
 drivers/ata/libata-eh.c           |  224 +----
 drivers/ata/libata-pata-timings.c |  192 ++++
 drivers/ata/libata-sata.c         | 1483 +++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c         |  542 +----------
 drivers/ata/libata-sff.c          |    4 -
 drivers/ata/libata.h              |   25 +-
 drivers/ata/sata_promise.c        |    8 +-
 drivers/scsi/Kconfig              |    1 +
 drivers/scsi/libsas/Kconfig       |    1 +
 include/linux/libata.h            |  163 ++--
 13 files changed, 2007 insertions(+), 1839 deletions(-)
 create mode 100644 drivers/ata/libata-pata-timings.c
 create mode 100644 drivers/ata/libata-sata.c

-- 
2.24.1

