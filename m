Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232A0C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  2 Dec 2021 08:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbhLBI4A (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Dec 2021 03:56:00 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:58847 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356320AbhLBIzR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Dec 2021 03:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638435115; x=1669971115;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=P2YRearoSh5lznATzjqbQ4dDakgftISqpF9EmsELvEY=;
  b=ect9WxMfDDBRAKZc3HOwBP8hCW06EiOfRCe8Oki/d0iFyoCTCMHwxE4u
   fLKYxrYThBRFuQU4xyoF7lGWVXnuY9Msw6xE/4JE3oZZd7T0hiG5tFGo/
   4Y6ekkii9mQFieeRsC83pUAIysME7rWVuGbKGIudTDPJ/Ka95sxxNqx73
   2y+9qfqH8S6hjblHLdMxkZENEPBLm0U7FGOMVeO60JdF9EJ6IRF6UwWU5
   BwvnezOSDe7HO6inBF8nvFHTIDOlfC9dCe82NIAq/4rftMiHClp5R/j+r
   5+OOpOLg5cT7qmwH10U5TvUPuQC8Bro+ca0MJm70RjEtzBQEpsnZLL5yB
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="186251288"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 16:51:51 +0800
IronPort-SDR: zaXaFfmhGWbHzJiyx3Pf+khvRis/STgbxOFa6RFL75JtXk06RL9oiaZ5F7rV/32RAu4hI9FmCA
 o4HVGDrbqGWuemMAwoi6UYc11PFcYNuApUu0P6nrjwKPgX4YRCjd5G6zJowriHi1vII5ZVcjjS
 s2sywi+WGg3HkzzceEZ0ig5trH7vOiLMSRu8tM9zk8mec7c1Jm/HGsppmexHfY8wUqERRPSAWK
 NLm4ochjMalQdK4ZTj8AoUER0HTDDmXhmgzUQ5dwsALFFWrNYAgZGW5xkF83AJGzRfpjOOOuxz
 GJEz7SJheiEeGqkvlaU+YiMA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:25:02 -0800
IronPort-SDR: Lwu+klz7wr5460CN2KYI8J4MeZm3UqRBXYR6yPfWUnUypDpENld+7/z2q571efUXCA611/OHLt
 Y5NvY8YHcx2Xlqpldgp9VUNdh1f3tQIRA2AO5/C3uzbUWcppMn4qzx66ZwORCWTDbJGkjFJI0m
 O7oav/Ea3AxJ63R1S/pH0vCXtJvMEh5+xYAD9+qYH5OpIDRwYLT+QDwfArF3AIv/+78LT1vuNW
 AwTMOY1dPbntnq8zpbmR/Zu/tisx8Ka9fUG22NoOEz4S9It2W2oOhnoLa0Rm97nHYZBM5jUYo0
 ELY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:51:52 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4TqG275bz1RtVt
        for <linux-ide@vger.kernel.org>; Thu,  2 Dec 2021 00:37:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1638434266; x=1641026267; bh=P2YRearoSh5lznATzj
        qbQ4dDakgftISqpF9EmsELvEY=; b=VEzML1JkXr9NaLl3F9aNWtgM01BqOGkBhR
        Hj2wkJ/8i3HjmgZaqmFgLRcSBShNWWLvLLv3sX6+EiefiAOMfIE2uXXbYq81SSur
        ERHxOR3Wtob6sJiuuncTELc9GVdDNyR4GvFq9x+wnpWu43myPulzCMHi5klwztyj
        jVQP9H1v6qNEUUAxyCP+ILV0Q2FI2L0SdoMZNz3fNMyMKr7OduzRVkokUXjCwxMT
        bDwM5k2oJ8dV/13/6ImXK10QqajTtqW0FeXF3k0An00Z3pXKpkk1bZMdkoYIOQ66
        m05WnkCVxO/Z0yNw/xEWAR2MJLivlyv+gbopgIjROYwUJbScilzg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xKTAgixKK6NR for <linux-ide@vger.kernel.org>;
        Thu,  2 Dec 2021 00:37:46 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4TqF53vLz1RtVm
        for <linux-ide@vger.kernel.org>; Thu,  2 Dec 2021 00:37:45 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 1/4] ata: libata-sata: use sysfs_emit()
Date:   Thu,  2 Dec 2021 17:37:40 +0900
Message-Id: <20211202083743.645391-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202083743.645391-1-damien.lemoal@opensource.wdc.com>
References: <20211202083743.645391-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use sysfs_emit() instead of snprintf() in sysfs attibute show()
functions.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-sata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index b9c77885b872..eddd33a3cb5f 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -876,7 +876,7 @@ static ssize_t ata_ncq_prio_enable_show(struct device=
 *device,
 		ncq_prio_enable =3D dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLE;
 	spin_unlock_irq(ap->lock);
=20
-	return rc ? rc : snprintf(buf, 20, "%u\n", ncq_prio_enable);
+	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_enable);
 }
=20
 static ssize_t ata_ncq_prio_enable_store(struct device *device,
@@ -972,7 +972,7 @@ ata_scsi_em_message_type_show(struct device *dev, str=
uct device_attribute *attr,
 	struct Scsi_Host *shost =3D class_to_shost(dev);
 	struct ata_port *ap =3D ata_shost_to_port(shost);
=20
-	return snprintf(buf, 23, "%d\n", ap->em_message_type);
+	return sysfs_emit(buf, "%d\n", ap->em_message_type);
 }
 DEVICE_ATTR(em_message_type, S_IRUGO,
 		  ata_scsi_em_message_type_show, NULL);
--=20
2.31.1

