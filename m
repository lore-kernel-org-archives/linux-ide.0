Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1419CC25B08
	for <linux-ide@archiver.kernel.org>; Sat, 20 Aug 2022 16:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiHTQev (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 20 Aug 2022 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiHTQeu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2022 12:34:50 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC386566C
        for <linux-ide@vger.kernel.org>; Sat, 20 Aug 2022 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661013289; x=1692549289;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wo+oVGrs/+p6u0Pp4Ld4dnmAYJG5gVXS7fhJLbJ+6jw=;
  b=Yiv/dm4sAmSiQR+xwLK6hWCR33V0kSn4J8brSaw0CH5mCLOp4/UVF8lW
   CjRKeJchq8mQniUI730oKyd3iIUMJXRmh/WD93AzcJns2Qzez47alWA7l
   9vnjvpadlAKPupMcT8ditiqVPzeT2z/XZ81T+xaBYNaH0RkGbobkkTFKI
   tNJc5MquVEut3OS1P404nJd+ZUJb5LgP7xirAQKiGKcbYo+TNfowbvwqa
   mdKRaQMG458Gqkg4uAcyVUBFBduoDlEqKIqDxOBD9SaFHA/S14prpjXGk
   EUj8wg3eOCdEQyhUXw7CWfUy8w4C7MzLfYfwVT6Pq+P4M+P7ME970NfgH
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654531200"; 
   d="scan'208";a="209733323"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2022 00:34:47 +0800
IronPort-SDR: oSSTFAQFeFzMkIUnkyNIcNcIw9swPGcbLgoJhr94jUvakJaJd+i7r8DpkBe9GVOQfguvjOyT/s
 PNS6Q4UBaZ4L2Zi6KxWhb2cHnepwa61rL+9bLmnnqYFmhO3CxjveYkkt8RF2RzrT3Xyn8B5FNM
 kJ7ojyjmagGRox9GqV7strZr1VLePkQ45Q6cDVZpG8rE0TriR6QuOXv8fCNwveNbQ3TCwtPq3C
 gFISu/mxnZSSgeczfj0qezfkIrggOu/QCUDg+fNryzQYjH6TOp3gEP9jkaTBAnUC9LNt138mHc
 WnhqHoN0Nk+mzIQuKBp47vhe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2022 08:50:10 -0700
IronPort-SDR: X+nXYmHgLf9wzzTNO83pj4sa/2LRG7TFV7RhNHsAGBl4jpu8G8vVPqkF3urMhQPm2sJPfAHThP
 BKEeNKcLGZED2f7sFJcTL/NUQviadlBHZD9BwZ8XF5l2+8c0sXo9CCgvrviWimmQ2+/uO+AQy/
 ALXEPE4tL9nU6NtG6jqp/7vx6sUsSRt9y/muyr/E/HaGBXpgM7h6t6L/deQilHBrnOde1dXqte
 /3/yvKGeq79kNe4VIG8Bh6o/2ytINbeQm5AVo+XHHwoxRgNRJV/MMlHNmALppWqigE0NNtPsW3
 8sI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2022 09:34:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M943B5qQVz1Rwnl
        for <linux-ide@vger.kernel.org>; Sat, 20 Aug 2022 09:34:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1661013286;
         x=1663605287; bh=Wo+oVGrs/+p6u0Pp4Ld4dnmAYJG5gVXS7fhJLbJ+6jw=; b=
        R25G3aUtMyKce6MJapzMqKG1EUgR3yBQ+Scblszkb9VNO9BXD/rta5wAFaGBe1C+
        h2Oy0eYj149PC9XhWbHJZLafA8kv0vMMldWDg8TswSNqha6Mc2lgay/++S1xVP2b
        s20F2y7HfMaUkvS73wflUy9YzgaMGR8JKrWcasdO3C7OOnlKem2Pem3wzeuPLjE4
        LKyWtttKTfv5OSNjWsOaEbnlM6/jCAXN0c2xn+6/bpLdWU7+PLEEcYAY5y5es6Wi
        /WnGmn2nVXL25rgsjNeTK8x/6G7BoiFwouHjyhtY1DqN6PcpkidmzfG+LjrNCK4s
        BPJO8eDt5ZpyaTaHm2yl7g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JGw1vCOjlwZG for <linux-ide@vger.kernel.org>;
        Sat, 20 Aug 2022 09:34:46 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M94396vFqz1RtVk;
        Sat, 20 Aug 2022 09:34:45 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.0-rc2
Date:   Sun, 21 Aug 2022 01:34:44 +0900
Message-Id: <20220820163444.128237-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b8=
68:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.0-rc2

for you to fetch changes up to a357f7b4583ebf81d19c95aef57497ae81c5f63c:

  ata: libata: Set __ATA_BASE_SHT max_sectors (2022-08-21 01:29:50 +0900)

----------------------------------------------------------------
ATA fixes for 6.0-rc2

* Add a missing command name definition for ata_get_cmd_name(), from me.

* A fix to address a performance regression due to the default max_sector=
s queue limit for ATA devices connected
  to AHCI adapters being too small, from John.

----------------------------------------------------------------
Damien Le Moal (1):
      ata: libata-eh: Add missing command name

John Garry (1):
      ata: libata: Set __ATA_BASE_SHT max_sectors

 drivers/ata/libata-eh.c | 1 +
 include/linux/libata.h  | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
