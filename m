Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE120C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 08:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C557E61AE2
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 08:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhKSIwY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:52:24 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58535 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKSIwY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2021 03:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637311759; x=1668847759;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=39cewCFS7BvdVE3wDHC9yVpL3VZfNMA0Acy7pnrnanA=;
  b=JRvJ+URs7PBPxBBbyXqMycUGmhHk3aa42d2Dcnqc24wh6K6WTioRQle3
   t/bKRwQldD5GlIEbH+FG6g1fB82TckjYNmCOqfikKyNTIwyWhJEkXCK0q
   0h+fP2LzlLeu3zRsT19BUX3Pd/7JY9TxVKHKwH8jsQzT9qQ36/5RZop4M
   zcM1yfmH8ZRxE7EBye4f59y+0oSRAiak2mdzKLOy7IgQPn5ta+xP40DEg
   BTKbO6tfaG9JgTmgfi336BbTo8SEkeRye4XRUZ421Fys5rgE13ZIFKwge
   OXKE3lttL0MNffqRVM8uKdbu9OiUYagTPbHUmBEdptmin8wC6A1FkQVlI
   A==;
X-IronPort-AV: E=Sophos;i="5.87,246,1631548800"; 
   d="scan'208";a="186074412"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2021 16:49:18 +0800
IronPort-SDR: 0WMYiPVDuEqmWRbndfA425XVUuqFsUGUi5ZH+RhZX1/bdnCYL7qeSbPc6V+YdYj+Hn1B1kYJno
 ZgF6vKlpp+vBz3/lhjshyL/gm1duTQcQM3JOpE08+TeAu20bLgfqCb5y2IoJueci1AU1lgBTnu
 4uScslP7ViFcAMt+VgC5l3ipH+YM6KsIhs15BQlpsiAh0hkkc+nJz5ljakvvLLXZ3gieSa7TsD
 Ht0lweuyfWMQ84qIicyqZBat6nwOxs/gWN7MFLel9AX5dKRm3Tp9Uo59EWte9I8A+Bc7uQHYWc
 5xtT8DkHiBBed4DRLUxKop1C
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 00:24:21 -0800
IronPort-SDR: qEBtTEv4qLOmpLzF5kfANKupOh8HUS/kh0QT0W2uNofCtxI3JGgJHWjozXVWbfcAmUJEKAIQ09
 JFea1/0hqwRVtw8a2pPNB74SuG34oMR2pudxoZKu655pcELWrq2R4v2A0ZGoqvtWNQoliBm54a
 /iVuhwgK3Zi4lnZsXXA/1tOhC19miRVUD912dWw0wu9j3UcUMsdpQLhX94fAINRwrSyBThevQe
 JbUckmfXz0i0wnMQLdq/ZuOhrm61leWGhukzf7jspKegpMD4qdws8hXL9QXHYvqJBx5CBZp6rS
 Hd8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 00:49:22 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HwVhd4Fzmz1RtVm
        for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2021 00:49:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1637311761;
         x=1639903762; bh=39cewCFS7BvdVE3wDHC9yVpL3VZfNMA0Acy7pnrnanA=; b=
        tfoikcWjb3nnrZW8lpq2b8Zc4rH+NCnspc7KlEYbUWTh2Xd3iVK+xqP++6f2/TBO
        qT/FjR0BI6+YDodOhICMHrLiTFVPKkekIsa5UckidwNPutYe4qj5SHyB2TjLs1S4
        t//waeaJbNko6LzKKi8Zsm/ziLp92Ia0m29H1/lampaE+B0/IqmrlQJdu8KvyJR2
        sTgfOgHhrc4YtlNIZ2KJrz7whn0D1XtqMOLiR28FbSENbYK8GUS4jw3ysq30I+yJ
        D3z8FR+FN0D3w0kXyCxVemyevYSiu/G8y4kcdc94tpMlqCzwI81NGjGWksXOwbQk
        oxYzSy1h/ROHt0gKoSS6Cg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 606bbL2u6ngy for <linux-ide@vger.kernel.org>;
        Fri, 19 Nov 2021 00:49:21 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HwVhc5msTz1RtVl;
        Fri, 19 Nov 2021 00:49:20 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] libata fixes for 5.16-rc2
Date:   Fri, 19 Nov 2021 17:49:19 +0900
Message-Id: <20211119084919.83906-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0d=
bf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/libata-5.16-rc2

for you to fetch changes up to 6873c30c1b797997f302fe1707bee9a7f247dfe2:

  sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl (2021-11=
-19 13:57:18 +0900)

----------------------------------------------------------------
libata fixes for 5.16-rc2

* Prevent accesses to unsupported log pages as that causes device scan
  failures with LLDDs using libsas (from me).
* A couple of fixes for AMD AHCI adapters handling of low power modes
  and resume (from Mario).
* Fix a compilation warning (from me).
* Fix sata_fsl driver problems on PPC64 (from Baokun).

----------------------------------------------------------------

Baokun Li (2):
      sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
      sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl

Damien Le Moal (3):
      ata: libata: improve ata_read_log_page() error message
      ata: libata: add missing ata_identify_page_supported() calls
      ata: libata-sata: Declare ata_ncq_sdev_attrs static

Mario Limonciello (2):
      ata: ahci: Add Green Sardine vendor ID as board_ahci_mobile
      ata: libahci: Adjust behavior when StorageD3Enable _DSD is set

 drivers/ata/ahci.c        |  1 +
 drivers/ata/libahci.c     | 15 +++++++++++++++
 drivers/ata/libata-core.c | 11 ++++++++---
 drivers/ata/libata-sata.c |  2 +-
 drivers/ata/sata_fsl.c    | 21 +++++++++++++++------
 5 files changed, 40 insertions(+), 10 deletions(-)
