Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2506BC432BE
	for <linux-ide@archiver.kernel.org>; Mon, 30 Aug 2021 14:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3E06023E
	for <linux-ide@archiver.kernel.org>; Mon, 30 Aug 2021 14:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhH3Ook (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237208AbhH3Ooc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Aug 2021 10:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630334617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2mUEVGaDHklyh6ZR9nxnq1+fJDzLMjt6bOsluGTQ+48=;
        b=UGzIQPAnh7280ocXrO/hjh6qA0hO9J5gm/Gh/wIdut0cw2wgro3pcUQiniQI9eni+UtTEh
        Bfeaba8ukmjutVR4bHc8r3gL7TmuKjEF7oFYq4WNTOlVmj5SpZygg77HUwzGSgxP6sIlwX
        NdEz9omrLClBy8l/6CpqOPnXReqcMSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-JHArCordPU6lSo82J9H1QA-1; Mon, 30 Aug 2021 10:43:36 -0400
X-MC-Unique: JHArCordPU6lSo82J9H1QA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50D6587D558;
        Mon, 30 Aug 2021 14:43:35 +0000 (UTC)
Received: from fedora-t480.redhat.com (unknown [10.39.192.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC5E5DEB8;
        Mon, 30 Aug 2021 14:43:27 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v3 0/1] libata: Add ATA_HORKAGE_NONCQ_ON_AMD for Samsung 860 and 870 SSD.
Date:   Mon, 30 Aug 2021 10:42:52 -0400
Message-Id: <20210830144253.289542-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Many users reported the issue when running the system with Samsung 860,
870 SSD, and AMD chipset. Therefore, completely disabling the NCQ can
avoid this issue.

Entire disabling NCQ for Samsung 860/870 SSD will cause I/O performance
drop. In this case, a flag ATA_HORKAGE_NONCQ_ON_AMD is introduced to
used to perform an additional check for these SSDs. If it finds its parent
ATA controller is AMD, the NCQ will be disabled. Otherwise, the NCQ is kept
to enable.

Changes since v3
* Modified the flag from ATA_HORKAGE_NONCQ_ON_ASMEDIA_AMD_MARVELL to
  ATA_HORKAGE_NONCQ_ON_AMD.
* Modified and fixed the code to completely disable NCQ on AMD controller.


Kate Hsuan (1):
  libata: Add ATA_HORKAGE_NONCQ_ON_AMD for Samsung 860 and 870 SSD.

 drivers/ata/libata-core.c | 24 ++++++++++++++++++++++--
 include/linux/libata.h    |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.31.1

