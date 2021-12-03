Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877EDC433F5
	for <linux-ide@archiver.kernel.org>; Fri,  3 Dec 2021 10:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351642AbhLCKoB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:44:01 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46706 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbhLCKoA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Dec 2021 05:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638528035; x=1670064035;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sTunFnjjffe/bejpwOZjAc0JHuZC3nZFIzTNCqTTDfw=;
  b=EyDd7geotULmdJ4JUe30bl2EiMtvuGNDoJ7eBHxHZVy7EavaEjUhUvh4
   fbZSkyDXc36OSJVXKtvYT2jeIe03WQgM/jeq3u55ndAamxg0UhjmRW/jR
   9GJgwjcAXQLxUIefc3N1RSws+ww7ScGYgXKGZwZmjUAJXLboZm1nVt4BZ
   x1Nri0yrsoobT6dHKeB1R6hH+weNwmopLziF0UhtvMkhcl5K6FVtzTbCh
   Q3QSw+B/IAnu22op8LdbRJlGLDMvlu3VZryro81fWkHnk+BaESEL9B7yA
   YHAQZbgYy8Guuue09xe62BTPYOlk1V+40vTKVtyMP9QvMd2IsSVpYI9bW
   w==;
X-IronPort-AV: E=Sophos;i="5.87,284,1631548800"; 
   d="scan'208";a="192158799"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2021 18:40:35 +0800
IronPort-SDR: ZcwoMUzNJRSHAWTBhBiB7pXn8RAFj5M7nIMyWY5MpS2BY886yYWMpscrZprL2yypU8kYo4EWgb
 DaD//Mvg6tHrpvRWctQB9Qkv4DuoOtqtU8IPW4SFRjuNWvkNYZt8NR0KByqGyaM+KH5qnvk9o0
 2FcFGTos/DKduaZkEDUAfy5U2B8kOYS/TKVmR4suiRu+o3BpjUD8a+MzeHpFiBqDSVguOfQAd/
 e2K0Sa2ScDam6xRnx57IxvW9K4jqvGB58UGrndSW5YM87C7kjGtuHHdilPYCSf/PkOmmfkUPCT
 z2KhJ+ESm9hqc9DpQPzVzhUp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 02:13:46 -0800
IronPort-SDR: 1vGoUoDQrqfrGiST47FJaqKeX1r6FDkNJDpknaAKgSI5KIP7qGOSKRUmMPKAqvePzVnoN5JQKh
 RYGqYVjWAHRbnOeeLcJuVAo9G7zd59Bj+8blgfML9/QhAu8ux1fhMDdFLu4kdN101PBbSRudwZ
 ZSf9Pjlx/9xr/Q8gTfEdym5TBhK1fnJXrh3n/htPWEv4Y+eTzwKsifyDJjDETeEF2KUyHyHz1L
 JLQiPN6050i18zHYRFR98qqXyJJg5kmL4K6X0QJ3FAnJZCWqlZcL2gdPZAwgLX81V90SJiwAvW
 YrA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 02:40:37 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J58VX2MjMz1RvTh
        for <linux-ide@vger.kernel.org>; Fri,  3 Dec 2021 02:40:36 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1638528035;
         x=1641120036; bh=sTunFnjjffe/bejpwOZjAc0JHuZC3nZFIzTNCqTTDfw=; b=
        RIv94VyNjRjbjlbT1ph6FSBRG4jRKHQXtMORe8j6Fw6nQ+y9clH5pugALzyazO2u
        DvG4FjR4L43xfjND5d/mqUO3058T+7zbdTpZ8sQ3b3sK2RVFx1LIQ5Do5MXSd1+F
        yYSQ+ROx9nSZt0I3l15SzjdQN7JrrInh15UvLrpL8ZA3dzu0kteoEWST6ulBR3cb
        7U8uChqItjpikWz/X3LAg9cg+Qnaxj4dPcFDnXse85XzJoXRZW0EPqhYu9QlB1GI
        B01b9odUlqldRNFDtH3Tza5YAvq1zWMqZ1STPFK0frvUNokBaN9s1wsyjZzTYv+P
        IDY9qjUV+NPnNspPp/yQUQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xjqbwEcOOt5Q for <linux-ide@vger.kernel.org>;
        Fri,  3 Dec 2021 02:40:35 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J58VW0kgPz1RtVG;
        Fri,  3 Dec 2021 02:40:34 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] libata fixes for 5.16-rc4
Date:   Fri,  3 Dec 2021 19:40:33 +0900
Message-Id: <20211203104033.656678-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295=
a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/libata-5.16-rc4

for you to fetch changes up to 06d5d558f5a30582546dcbe9327601af867ce1c9:

  ata: replace snprintf in show functions with sysfs_emit (2021-12-02 13:=
13:45 +0900)

----------------------------------------------------------------
libata fixes for 5.16-rc4

Two sparse warning fixes and a couple of patches to fix an issue with
sata_fsl driver module removal:

* A couple of patches to avoid sparse warnings in libata-sata and
  in the pata_falcon driver (from Yang and Finn).
* A couple of sata_fsl driver patches fixing IRQ free and proc
  unregister on module removal (from Baokun).
----------------------------------------------------------------

Baokun Li (2):
      sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
      sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl

Finn Thain (1):
      pata_falcon: Avoid type warnings from sparse

Yang Guang (1):
      ata: replace snprintf in show functions with sysfs_emit

 drivers/ata/libata-sata.c |  2 +-
 drivers/ata/pata_falcon.c | 16 ++++++++--------
 drivers/ata/sata_fsl.c    | 20 +++++++++++++-------
 3 files changed, 22 insertions(+), 16 deletions(-)
