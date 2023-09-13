Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF5DEE020F
	for <linux-ide@archiver.kernel.org>; Wed, 13 Sep 2023 22:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjIMWUn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 13 Sep 2023 18:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjIMWUm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 13 Sep 2023 18:20:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584E6E0
        for <linux-ide@vger.kernel.org>; Wed, 13 Sep 2023 15:20:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-500bbe3ef0eso426362e87.1
        for <linux-ide@vger.kernel.org>; Wed, 13 Sep 2023 15:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643636; x=1695248436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmlJkuQehsZq+nIm4WnuUzyOl3bWUtn+JX5OpEXp6+I=;
        b=OH0PjaVgHrqC+8Ve1uTpL+dUJ1HIkjepPhwgiP9cpU9RnlRvhVeuinuKortBXahN3M
         MPdzcaEOVBLki3XQ7pEuP+Cr2m1z6l7N2x1R5EGPbINzV/3etl0i5iSTxP1BtaCUBZrf
         pc827PjvMcPbQ/VDZoAqL5gQQ5yXwp5w7CXwxzYYk4zy96B1293coy2ZoekUEdyI/dIH
         nwsyrvGAlK+w4DGpu+IdgtzV58TdFxyEFeWqqpjiU4JPe3xsLzG33cRAdNScd4AkWRSf
         g+CQXbW1B5xjbDRKvymHvJqVJXB22rk4Gj0l7CZbIe1vSQRbE1zImoU78vXE8MgXK1Fj
         VorA==
X-Gm-Message-State: AOJu0Yw+SRx/ofzinCw6x2qjCvz+p/6OpEPn6nrH9ez9rm4DeUyKBoOU
        p57rq9pZWez5OvbQQO3/o+VMCKMvXeCiXfI/
X-Google-Smtp-Source: AGHT+IE90KoYNG0EoRLOj1Fvz1Mw9vBKBPDx4mhqs9agnatEYbEYTjmYGaMuEoqKEvpxveoOWgUSNA==
X-Received: by 2002:ac2:4e08:0:b0:4ff:af21:442b with SMTP id e8-20020ac24e08000000b004ffaf21442bmr13062lfr.23.1694643636454;
        Wed, 13 Sep 2023 15:20:36 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id v22-20020ac25936000000b00502d9fe08fcsm19735lfi.218.2023.09.13.15.20.35
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 15:20:36 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id D1908B9CA; Thu, 14 Sep 2023 00:20:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1694643634; bh=prOrdWE8C3DZcMSKeArrvjKLg50HfcrvzqL4AB9/bdM=;
        h=From:To:Cc:Subject:Date:From;
        b=JDE+flEurtFYvzpPobzDyYz2zwTAaBFHHVaTqiR6lF8id/gSXWTE3+NlOegsmRuej
         mP9xb4TrSZ+fTW603tEbsqQlRFHMagg/qg39DfrIjivlG+qZI3Jnp0JFvC6ztB3/Dh
         a7HRHmXkgohLSrqTRJFDUpA7IZhjFPhHeQ8rNDsw=
Received: from x1-carbon.wdc.com (unknown [129.253.182.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id 0A69F213C;
        Thu, 14 Sep 2023 00:19:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1694643598; bh=prOrdWE8C3DZcMSKeArrvjKLg50HfcrvzqL4AB9/bdM=;
        h=From:To:Cc:Subject:Date:From;
        b=ar2q5PW+TPNL0G2dSyvVQVLHEUwsd+bNDFxRbATXvdh3t6RHuRrK8GoGdrAbUOE9d
         +A8wJUgXseWWPvobTIn66xg606Nzpfr5P7721J5KnUoVTU+qHmAcCsVc4gSuRsA1R7
         N6S6YArX7Zvq9K4S8Jrt+UQ6sLb8/53D8AhJeGpg=
From:   Niklas Cassel <nks@flawful.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Li Nan <linan122@huawei.com>, Li Nan <linan666@huaweicloud.com>,
        linux-ide@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH 1/2] ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()
Date:   Thu, 14 Sep 2023 00:19:16 +0200
Message-ID: <20230913221917.1217856-1-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

ata_scsi_port_error_handler() starts off by clearing ATA_PFLAG_EH_PENDING,
before calling ap->ops->error_handler() (without holding the ap->lock).

If an error IRQ is received while ap->ops->error_handler() is running,
the irq handler will set ATA_PFLAG_EH_PENDING.

Once ap->ops->error_handler() returns, ata_scsi_port_error_handler()
checks if ATA_PFLAG_EH_PENDING is set, and if it is, another iteration
of ATA EH is performed.

The problem is that ATA_PFLAG_EH_PENDING is not only cleared by
ata_scsi_port_error_handler(), it is also cleared by ata_eh_reset().

ata_eh_reset() is called by ap->ops->error_handler(). This additional
clearing done by ata_eh_reset() breaks the whole retry logic in
ata_scsi_port_error_handler(). Thus, if an error IRQ is received while
ap->ops->error_handler() is running, the port will currently remain
frozen and will never get re-enabled.

The additional clearing in ata_eh_reset() was introduced in commit
1e641060c4b5 ("libata: clear eh_info on reset completion").

Looking at the original error report:
https://marc.info/?l=linux-ide&m=124765325828495&w=2

We can see the following happening:
[    1.074659] ata3: XXX port freeze
[    1.074700] ata3: XXX hardresetting link, stopping engine
[    1.074746] ata3: XXX flipping SControl

[    1.411471] ata3: XXX irq_stat=400040 CONN|PHY
[    1.411475] ata3: XXX port freeze

[    1.420049] ata3: XXX starting engine
[    1.420096] ata3: XXX rc=0, class=1
[    1.420142] ata3: XXX clearing IRQs for thawing
[    1.420188] ata3: XXX port thawed
[    1.420234] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

We are not supposed to be able to receive an error IRQ while the port is
frozen (PxIE is set to 0, i.e. all IRQs for the port are disabled).

AHCI 1.3.1 section 10.7.1.1 First Tier (IS Register) states:
"Each bit location can be thought of as reporting a '1' if the virtual
"interrupt line" for that port is indicating it wishes to generate an
interrupt. That is, if a port has one or more interrupt status bit set,
and the enables for those status bits are set, then this bit shall be set."

Additionally, AHCI state P:ComInit clearly shows that the state machine
will only jump to P:ComInitSetIS (which sets IS.IPS(x) to '1'), if PxIE.PCE
is set to '1'. In our case, PxIE is set to 0, so IS.IPS(x) won't get set.

So IS.IPS(x) only gets set if PxIS and PxIE is set.

AHCI 1.3.1 section 10.7.1.1 First Tier (IS Register) also states:
"The bits in this register are read/write clear. It is set by the level of
the virtual interrupt line being a set, and cleared by a write of '1' from
the software."

So if IS.IPS(x) is set, you need to explicitly clear it by writing a 1 to
IS.IPS(x) for that port.

Since PxIE is cleared, the only way to get an interrupt while the port is
frozen, is if IS.IPS(x) is set, and the only way IS.IPS(x) can be set when
the port is frozen, is if it was set before the port was frozen.

However, since commit 94152042eaa9 ("ata: libahci: clear pending interrupt
status"), we clear both PxIS and IS.IPS(x) after freezing the port, but
before the COMRESET, so the problem that commit 1e641060c4b5 ("libata:
clear eh_info on reset completion") fixed can no longer happen.

Thus, revert commit 1e641060c4b5 ("libata: clear eh_info on reset
completion"), so that the retry logic in ata_scsi_port_error_handler()
works once again. (The retry logic is still needed, since we can still
get an error IRQ _after_ the port has been thawed, but before
ata_scsi_port_error_handler() takes the ap->lock in order to check
if ATA_PFLAG_EH_PENDING is set.)

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-eh.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 159ba6ba19eb..5c493b6316eb 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2796,18 +2796,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		}
 	}
 
-	/*
-	 * Some controllers can't be frozen very well and may set spurious
-	 * error conditions during reset.  Clear accumulated error
-	 * information and re-thaw the port if frozen.  As reset is the
-	 * final recovery action and we cross check link onlineness against
-	 * device classification later, no hotplug event is lost by this.
-	 */
+	/* clear cached SError */
 	spin_lock_irqsave(link->ap->lock, flags);
-	memset(&link->eh_info, 0, sizeof(link->eh_info));
+	link->eh_info.serror = 0;
 	if (slave)
-		memset(&slave->eh_info, 0, sizeof(link->eh_info));
-	ap->pflags &= ~ATA_PFLAG_EH_PENDING;
+		slave->eh_info.serror = 0;
 	spin_unlock_irqrestore(link->ap->lock, flags);
 
 	if (ata_port_is_frozen(ap))
-- 
2.41.0

