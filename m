Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302BDC2BB1D
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67A420752
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KardV7tU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgCQOno (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:43:44 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45844 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCQOnn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144341euoutp01157975159fe1bf48814614d1e24f1f3d~9HonMRMFT2336723367euoutp015
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200317144341euoutp01157975159fe1bf48814614d1e24f1f3d~9HonMRMFT2336723367euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456221;
        bh=W2Rq6UA2YQEI4QPV01/ZXtRXjTEO+v2ZZCZnfGt01Ss=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KardV7tUREnhoR3wTwOPtKIbIz7vEJaOEPsZUS/luyINQiFqWtbCyP3uzowLbjobt
         U68XkmYLkB9oMWeTGQt0EupS7IpqUapGkt1PpZWLCNc0BIRyZrR2XDYsgX99zJh8ZB
         2AGGGrempTkfDVTryyGbTw8qnuOIXSadfu3/CcEk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200317144340eucas1p20968cc46ccb6bed30c5c3d26e7a7b1af~9Hom85WiB0560805608eucas1p2D;
        Tue, 17 Mar 2020 14:43:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3B.E1.60679.C12E07E5; Tue, 17
        Mar 2020 14:43:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144340eucas1p1f6f7a6fbd27cbfeaab2ea97fbccb2836~9HomvBKoS1085210852eucas1p1B;
        Tue, 17 Mar 2020 14:43:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144340eusmtrp20f7f8ff3c8a66b5898077f04f100e0d1~9HomuXNho0147801478eusmtrp2r;
        Tue, 17 Mar 2020 14:43:40 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-2f-5e70e21cab6d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 84.23.07950.C12E07E5; Tue, 17
        Mar 2020 14:43:40 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144340eusmtip186b60297aff3ef5e594bf739736b86b0~9HomSJR550390803908eusmtip1k;
        Tue, 17 Mar 2020 14:43:40 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 00/27] ata: optimize core code size on PATA only setups
Date:   Tue, 17 Mar 2020 15:43:06 +0100
Message-Id: <20200317144333.2904-1-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87oyjwriDPr+GFisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroz+H7/YCl4bVNxad4CpgfGZehcjJ4eE
        gInE4Vv97F2MXBxCAisYJTr/z2OGcL4wSvQdXMQE4XxmlFj+cx4rTMvmozfYQGwhgeWMEk/u
        asF1XPjzkxEkwSZgJTGxfRWYLSKgINHzeyUbSBGzwHtGiRWT9rKAJIQFvCT+fO4AmsrBwSKg
        KvFjCzOIyStgI/F4ogrELnmJrd8+ge3lFRCUODnzCVgnM1C8eetssEslBPrZJSZOeA51nIvE
        +9U9LBC2sMSr41vYIWwZif875zNBNKxjlPjb8QKqezvQa5P/sUFUWUvcOfeLDeQKZgFNifW7
        9CHCjhIPFq5mBwlLCPBJ3HgrCHEEn8SkbdOZIcK8Eh1tQhDVahIblm1gg1nbtXMlM4TtIfFh
        yhOwciGBWInjt1knMCrMQvLZLCSfzUI4YQEj8ypG8dTS4tz01GKjvNRyveLE3OLSvHS95Pzc
        TYzAJHT63/EvOxh3/Uk6xCjAwajEw8uxoSBOiDWxrLgy9xCjBAezkgjv4sL8OCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoY1ybP3n9T6UC6Y+qvCL9d
        GWXpNzl+yc565LvMavbkd+uq5oSqWHNLLOqcMkUt1t/nlI2X/L5nnVt5veYu9pv/OId75ZuV
        c303vShQXOKxpujUrhtLW7MyLu34sLhw4s3OVTf2r3q51/NM8rslsh++6Rltf33g5p8rs8/3
        MfPlHE03C+52io2Ye0uJpTgj0VCLuag4EQDDiPcTPgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e/4XV2ZRwVxBuvuKFqsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYz+H7/YCl4bVNxad4CpgfGZehcjJ4eEgInE5qM32LoYuTiEBJYySiz5
        dIS1i5EDKCEjcXx9GUSNsMSfa11QNZ8YJU5f7mMHSbAJWElMbF/FCGKLCChI9PxeCVbELPCV
        UWLppG5mkISwgJfEn88dYENZBFQlfmxhBjF5BWwkHk9UgZgvL7H12ydWEJtXQFDi5MwnLCA2
        M1C8eets5gmMfLOQpGYhSS1gZFrFKJJaWpybnltspFecmFtcmpeul5yfu4kRGPzbjv3csoOx
        613wIUYBDkYlHl6ODQVxQqyJZcWVuYcYJTiYlUR4FxfmxwnxpiRWVqUW5ccXleakFh9iNAU6
        dSKzlGhyPjAy80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MDLK
        +zdclF5S1ClwfNmvi2nTtY0P3fYze73p25o7fznTBI3yTxYX/s1zndMXv4hpNlNOvNC1fJ+r
        y56cs+kx3Cf/TH/HkQuXtWbI/5vybekru+mWV3LuCHYV1H+f5zq3doa+NtPf2y77Z/Fnme43
        //wnx3QCw0VR32MRsc0Hsh5cTRfcl9YfaKfEUpyRaKjFXFScCABsCeNDlAIAAA==
X-CMS-MailID: 20200317144340eucas1p1f6f7a6fbd27cbfeaab2ea97fbccb2836
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144340eucas1p1f6f7a6fbd27cbfeaab2ea97fbccb2836
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144340eucas1p1f6f7a6fbd27cbfeaab2ea97fbccb2836
References: <CGME20200317144340eucas1p1f6f7a6fbd27cbfeaab2ea97fbccb2836@eucas1p1.samsung.com>
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
 drivers/ata/libata-core.c         | 1229 +++---------------------
 drivers/ata/libata-eh.c           |  224 +----
 drivers/ata/libata-pata-timings.c |  192 ++++
 drivers/ata/libata-sata.c         | 1480 +++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c         |  544 +----------
 drivers/ata/libata-sff.c          |    4 -
 drivers/ata/libata.h              |   25 +-
 drivers/ata/sata_promise.c        |    8 +-
 drivers/scsi/Kconfig              |    1 +
 drivers/scsi/libsas/Kconfig       |    1 +
 include/linux/libata.h            |  174 ++--
 13 files changed, 2066 insertions(+), 1895 deletions(-)
 create mode 100644 drivers/ata/libata-pata-timings.c
 create mode 100644 drivers/ata/libata-sata.c

-- 
2.24.1

