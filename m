Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A969C2D0DB
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D630D24686
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YecqYh7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgA1NeN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:13 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58857 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgA1NeN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:13 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133411euoutp01562208ddeb58303d56d863c3fdaf7aba~uEE81nCad0284402844euoutp01Q
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133411euoutp01562208ddeb58303d56d863c3fdaf7aba~uEE81nCad0284402844euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218451;
        bh=4q5wGp+osIANNAP2q1wsT1/hCu6rF+qnF+bHVNuG780=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YecqYh7dFtGAcMHQGjLxW4zxef/douW6UAkovxdoqausdiprVnxikr2rE7/IXCwoz
         CoDFgZ2D7XGrJJVfS2NmnJr2nKOyeQVv4iusbX+sphzs/ywUjSzjmes6pJ+VggXLFv
         /ZS9OgJqMwum0deeeFUzpnTzmJsHGtEW5HoD8d3c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200128133411eucas1p2108e807ee0da083055ef26fd105490e0~uEE8WlejJ2264122641eucas1p28;
        Tue, 28 Jan 2020 13:34:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 84.DA.60698.258303E5; Tue, 28
        Jan 2020 13:34:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133410eucas1p19fb97c9696596da07181e0c630fb6c6b~uEE71QqwE1375613756eucas1p17;
        Tue, 28 Jan 2020 13:34:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133410eusmtrp2141b5f4d74206c1f5aecb5f7282ea6b7~uEE70stIO0330003300eusmtrp2m;
        Tue, 28 Jan 2020 13:34:10 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-a9-5e30385229e6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6C.72.07950.258303E5; Tue, 28
        Jan 2020 13:34:10 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133410eusmtip293c9c60fb799b8856758b90faeae0798~uEE7dMnnr0657406574eusmtip2Y;
        Tue, 28 Jan 2020 13:34:10 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 00/28] ata: optimize core code size on PATA only setups
Date:   Tue, 28 Jan 2020 14:33:15 +0100
Message-Id: <20200128133343.29905-1-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7rBFgZxBivOMVmsvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK2P9yXeMBXvlK7bufsfewLhKsouRk0NCwETi0KZJjF2MXBxCAisYJX53rmCG
        cL4wSrT2/oDKfGaUmD9pLjtMS9v0y6wQieWMEud/9rGCJMBaJv50A7HZBKwkJravYgSxRQQU
        JHp+r2QDaWAWWMMosepwE1hCWMBd4sCK/ywgNouAqsS7b++YQGxeAVuJQ9eXMUFsk5fY+u0T
        K0RcUOLkzCdg9cxA8eats5khal6zSbzYWQhhu0hsa90GFReWeHV8C9TVMhL/d85nAjlCQmAd
        o8TfjhfMEM52Ronlk/+xQVRZS9w59wvI5gDaoCmxfpc+RNhR4sWRFmaQsIQAn8SNt4IQN/BJ
        TNo2HSrMK9HRJgRRrSaxYdkGNpi1XTtXQp3jIXHs6Et2SFjFStzf8oN1AqPCLCSfzULy2SyE
        GxYwMq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITDCn/x3/uoNx35+kQ4wCHIxKPLwO
        SgZxQqyJZcWVuYcYJTiYlUR4O5mAQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJ
        zU5NLUgtgskycXBKNTCuTF9scz1l2rp5XOkiT04nZvCfN1+61nr9K22xg4Y6adfS11mc6t9y
        bnnZNHXfKXy3Hwn0B5x87BZvzt55Vk5FLu1qsNKLf/9W7+Hdtk+6d5kzR/ThjBed/zKrC/JU
        Ix4+e9dnF+auVfNm2qxzgnXn7zxuO5+m5BIY4Ns6r7xg1dmKe3P3f6hSYinOSDTUYi4qTgQA
        Zur0DCwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t/xe7pBFgZxBhsfyFqsvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDVKz6Yo
        v7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2P9yXeMBXvl
        K7bufsfewLhKsouRk0NCwESibfplVhBbSGApo8SmXwZdjBxAcRmJ4+vLIEqEJf5c62KDKPnE
        KHHqWRiIzSZgJTGxfRUjiC0ioCDR83slUA0XB7PABkaJVze/sIAkhAXcJQ6s+A9mswioSrz7
        9o4JxOYVsJU4dH0ZE8QCeYmt3z6xQsQFJU7OfAJWzwwUb946m3kCI98sJKlZSFILGJlWMYqk
        lhbnpucWG+kVJ+YWl+al6yXn525iBAb1tmM/t+xg7HoXfIhRgINRiYfXQckgTog1say4MvcQ
        owQHs5IIbycTUIg3JbGyKrUoP76oNCe1+BCjKdCxE5mlRJPzgRGXVxJvaGpobmFpaG5sbmxm
        oSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB8VwIW5x/sesus2uM4lq/67pkPaJVvr2cYL32
        5leOHwUpX6If7XxhenOLj//7BINVh8RNNBP+2DBPndpabCq+/rjq2iqm7qhvHEdKru5eFalh
        5nBTS2Wl4fnkH4LOUx8vzViisuzwES23WX9/zXZsWNHLv2vO+4b/u+/eNVngWHLyQr+lwuuZ
        rEosxRmJhlrMRcWJAJbFLf+AAgAA
X-CMS-MailID: 20200128133410eucas1p19fb97c9696596da07181e0c630fb6c6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133410eucas1p19fb97c9696596da07181e0c630fb6c6b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133410eucas1p19fb97c9696596da07181e0c630fb6c6b
References: <CGME20200128133410eucas1p19fb97c9696596da07181e0c630fb6c6b@eucas1p1.samsung.com>
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

The end result is up to 17% (by 17246 bytes, from 101787 bytes to
84541 bytes) smaller libata core code size (as measured for m68k
arch using atari_defconfig) on affected setups.

I've tested this patchset using pata_falcon driver under ARAnyM
emulator.


patches #1-9 are general fixes/cleanups done in the process of
making the patchset (there should be no inter-dependencies between
them except patch #9 which depends on patch #8)

patch #10 separates PATA timings code to libata-pata-timings.c file

patch #11 optimizes ata_ncq_enable() inline for PATA only setups

patches #12-22 separate SATA only code from libata-core.c file to
libata-core-sata.c one

patches #24-25 separate SATA only code from libata-scsi.c file to
libata-scsi-sata.c one

patches #26-28 separate SATA only code from libata-eh.c file to
libata-eh-sata.c one


Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (28):
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
  ata: separate PATA timings code from libata-core.c
  ata: add CONFIG_SATA_HOST=n version of ata_ncq_enabled()
  ata: start separating SATA specific code from libata-core.c
  ata: move ata_do_link_spd_horkage() to libata-core-sata.c
  ata: move ata_dev_config_ncq*() to libata-core-sata.c
  ata: move sata_print_link_status() to libata-core-sata.c
  ata: move sata_down_spd_limit() to libata-core-sata.c
  ata: move *sata_set_spd*() to libata-core-sata.c
  ata: move sata_link_{debounce,resume}() to libata-core-sata.c
  ata: move sata_link_hardreset() to libata-core-sata.c
  ata: move sata_link_init_spd() to libata-core-sata.c
  ata: move ata_qc_complete_multiple() to libata-core-sata.c
  ata: move sata_scr_*() to libata-core-sata.c
  ata: move sata_deb_timing_*() to libata-core-sata.c
  ata: start separating SATA specific code from libata-scsi.c
  ata: move ata_sas_*() to libata-scsi-sata.c
  ata: start separating SATA specific code from libata-eh.c
  ata: move ata_eh_analyze_ncq_error() & co. to libata-core-sata.c
  ata: move ata_eh_set_lpm() to libata-core-sata.c

 drivers/ata/Kconfig               |   61 ++
 drivers/ata/Makefile              |    3 +
 drivers/ata/libata-core-sata.c    | 1077 +++++++++++++++++++++
 drivers/ata/libata-core.c         | 1456 ++---------------------------
 drivers/ata/libata-eh-sata.c      |  349 +++++++
 drivers/ata/libata-eh.c           |  354 +------
 drivers/ata/libata-pata-timings.c |  180 ++++
 drivers/ata/libata-scsi-sata.c    |  523 +++++++++++
 drivers/ata/libata-scsi.c         |  542 +----------
 drivers/ata/libata-sff.c          |    4 -
 drivers/ata/libata.h              |   69 +-
 drivers/ata/sata_promise.c        |    8 +-
 drivers/scsi/Kconfig              |    1 +
 drivers/scsi/libsas/Kconfig       |    1 +
 include/linux/libata.h            |  176 ++--
 15 files changed, 2496 insertions(+), 2308 deletions(-)
 create mode 100644 drivers/ata/libata-core-sata.c
 create mode 100644 drivers/ata/libata-eh-sata.c
 create mode 100644 drivers/ata/libata-pata-timings.c
 create mode 100644 drivers/ata/libata-scsi-sata.c

-- 
2.24.1

