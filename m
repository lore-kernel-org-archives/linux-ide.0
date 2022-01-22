Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF30C433F5
	for <linux-ide@archiver.kernel.org>; Sat, 22 Jan 2022 00:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiAVAGB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Jan 2022 19:06:01 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54406 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiAVAGA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Jan 2022 19:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642809961; x=1674345961;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iL2r/D/XsMNdzERmZuE2iPFraGQg3voWB+yVQXkwlh0=;
  b=cAI2UzuA3xSdS8aZjAT3UIxizttSaN0rTsrvowaoagE6iEBxmbF5EwLE
   pyOhsta8cJElOqVmrDXg/oRX3fjXMQILKlRWmAFDnnId0Rk5MECcKDh1D
   QSsDcoAQOS1X1FpMiXgsVNb7PzbePKZodMP0Con1xhNfly2eQqcdd4Lcd
   iaCkNHvVHTJQ+YM5zUc7S+Jsoy6Rj8sDE1og+7nGWl7Xg9bZNgcXDXVJH
   umjS4KJcxKbnsLdeM3rD5bVvK108EOHedlWg8Z3tzygni5iwlsNbuZ6+I
   Rd78nSLvM02cyE8OLGbkj8ELAlL1YNTeh26+ZeJpX26giD5I1dgL7zwhr
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,306,1635177600"; 
   d="scan'208";a="192091140"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2022 08:06:00 +0800
IronPort-SDR: MGeaT83W0wZu078fR2Pm7EBF6tMdcSnBjJ8aFahKtlC6bfNBkbhTvSLaNikkLD1VZ1UXYRM6pm
 tsnTGV1Vjoe/pQytG6LhCPcf8Efvg4WbMqBj16s7MpKwId/UjALQPL6KM+0iAuGW5SAhE5OxvN
 Rygwge72ik7akWunpobjV+rbqJw2o2sg3v5LfLytAG4tTk1eS8AnyBIH9Zf2ISlbjPL//EV9sd
 UtDX+QuiiCmC8wqcjoRpxPVdUAkWdE0oPSj3iw8NYg/76R7JRfwvdu9o6A+2xYWVWJbt7pXHls
 H66XNcHRW84JjSsQS/DJvXCc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 15:38:10 -0800
IronPort-SDR: TvvreKv5YPJ0Wi9F+IPMIsmfwV5rdvDpQCv+hrvhYaO1LQlesEtCBhmD/7sF5RdJQD9maoiYHO
 1VGXR8CQHYwkX76o7nzTRZvz4Uy2TMdzzmjiNMCLpzgq9CIIjXe/r6GoHpHiHolkG9YrRoEiSS
 Y7eV4Dw5PwA3xaW3UpvQYGxBi9RhNulooF3KIOhK8uB76TTeqLGDQo2ATPeZNvfjKJkYCixXFb
 BxJur+NR91NBEDOGMFI7X0XjNSuxZ99RStNIXOuTn4JHKoMf28wXZZfVSbdLzBk1hDEcIJ4Ms0
 i6M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 16:06:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jgc3D0HZlz1Rwrw
        for <linux-ide@vger.kernel.org>; Fri, 21 Jan 2022 16:06:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1642809959;
         x=1645401960; bh=iL2r/D/XsMNdzERmZuE2iPFraGQg3voWB+yVQXkwlh0=; b=
        g1cpyrvle8N+4D43BdBbbfcfIl6kNF5yOJ30mjCT5mcsBKLPJas/We1JtrvkZMml
        r0YpdsDjZ7aMtA3Gsqm3h+eqlwEIqv4/ezhsXB0RQ9dsxz21DYSCBjvoCDAmaeyj
        9yf+3X/dTwB6IMviyrxadBg6vpywxqmV4vTw3pssu4LaruvF+8vqAFeEJ3BrudA7
        G0OyZGKJLf13PAPQaHY74mBh2s1WF4Eu0mSCGawcLj2CIu0bF0MCOOEcPojg0gpp
        ef4K5luXtfz50rqCXt3J7LxLXi4sZaw3B4luRNBPCkYJBWnZSEiWncpEJfWUsDJK
        Xdzc6NPYhZA4aXyMNVwb5w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id btW3u_HIn8CK for <linux-ide@vger.kernel.org>;
        Fri, 21 Jan 2022 16:05:59 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jgc3B6LTCz1RvlN;
        Fri, 21 Jan 2022 16:05:58 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata changes for 5.17-rc1, part 2
Date:   Sat, 22 Jan 2022 09:05:56 +0900
Message-Id: <20220122000556.1149852-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 237fe8885a3fdab169bf670790c9f40046af45=
d3:

  ata: pata_ali: remove redundant return statement (2022-01-14 15:17:17 +=
0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.17-rc1-part2

for you to fetch changes up to b875b39e7373dcaccb19a600a52a956061c2c833:

  ata: pata_octeon_cf: fix call to trace_ata_bmdma_stop() (2022-01-21 18:=
39:16 +0900)

----------------------------------------------------------------
ATA changes for 5.17-rc1, part2

A single patch in this pull request to fix a compilation error in the
pata_octeon_cf driver (mips architecture), from me.

----------------------------------------------------------------

Damien Le Moal (1):
      ata: pata_octeon_cf: fix call to trace_ata_bmdma_stop()

 drivers/ata/pata_octeon_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
