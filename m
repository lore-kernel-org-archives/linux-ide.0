From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH] Remove endianness attribute in ata_tf_to_fis
Date: Sat, 31 Aug 2013 09:20:32 -0700
Message-ID: <1377966033-12256-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:52587 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab3HaQVL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Aug 2013 12:21:11 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so2875336oag.28
        for <linux-ide@vger.kernel.org>; Sat, 31 Aug 2013 09:21:11 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Marc Carino <marc.ceeeee@gmail.com>

From: Marc Carino <marc.ceeeee@gmail.com>

This patch cleans up the following build warning:

---
reproduce: make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/ata/libata-core.c:574:19: sparse: restricted __le32 degrades to integer
>> drivers/ata/libata-core.c:575:20: sparse: restricted __le32 degrades to integer
>> drivers/ata/libata-core.c:576:20: sparse: restricted __le32 degrades to integer
>> drivers/ata/libata-core.c:577:20: sparse: restricted __le32 degrades to integer

vim +574 drivers/ata/libata-core.c

   568
   569          fis[12] = tf->nsect;
   570          fis[13] = tf->hob_nsect;
   571          fis[14] = 0;
   572          fis[15] = tf->ctl;
   573
 > 574          fis[16] = aux & 0xff;
   575          fis[17] = (aux >> 8) & 0xff;
   576          fis[18] = (aux >> 16) & 0xff;
   577          fis[19] = (aux >> 24) & 0xff;
   578  }
   579
   580  /**
---

Marc Carino (1):
  libata: Remove unneeded __le32 in ata_tf_to_fis

 drivers/ata/libata-core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
1.8.1.2

