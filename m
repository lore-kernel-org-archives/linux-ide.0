Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420E2C43214
	for <linux-ide@archiver.kernel.org>; Fri, 27 Aug 2021 05:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2724860560
	for <linux-ide@archiver.kernel.org>; Fri, 27 Aug 2021 05:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244288AbhH0Fer (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 27 Aug 2021 01:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhH0Fer (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 27 Aug 2021 01:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630042438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nDJoWCqAn7xRSrZI8YAG5NUXcyahKOzT6a0Q77ySVoA=;
        b=GNxLfFNRkjJ3HwQJFVtHL30UGKxLvPN9hBn43jMR/jxa2RIoTn3MbFPCd0u1JkjVrhqvft
        lMe0ADdjdugGX0o15Q3HTgXadQ9PUpMhZGgwrQymcKSPMiVOuKw5m/92yh6dHurlfzbZeB
        QlCcgx8vRZDDQ+hl/9GJ3rVBWz55oD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-yamMueV4Nu2FNyxigaUoxg-1; Fri, 27 Aug 2021 01:33:55 -0400
X-MC-Unique: yamMueV4Nu2FNyxigaUoxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59745344AF;
        Fri, 27 Aug 2021 05:33:54 +0000 (UTC)
Received: from fedora-t480.redhat.com (unknown [10.39.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C975160C04;
        Fri, 27 Aug 2021 05:33:49 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v2 0/1] libata: add ATA_HORKAGE_NO_NCQ_TRIM for Samsung 860 and 870 SSDs
Date:   Fri, 27 Aug 2021 01:33:43 -0400
Message-Id: <20210827053344.15087-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Entire disabling NCQ for Samsugn 860/870 SSD will cause I/O performance
drop. In this case, a flag ATA_HORKAGE_NONCQ_ON_ASMEDIA_AMD_MARVELL is
introduced to used to performe additional check for these SSDs. If it
finds it's parent ATA controller is AsMedia/AMD/Marvell, the NCQ will be
disabled. Otherwise, the NCQ is kept to enable.

Kate Hsuan (1):
  libata: libata: add ATA_HORKAGE_NO_NCQ_TRIM for Samsung 860 and 870
    SSDs

 drivers/ata/libata-core.c | 37 ++++++++++++++++++++++++++++++++-----
 include/linux/libata.h    |  3 +++
 2 files changed, 35 insertions(+), 5 deletions(-)

-- 
2.31.1

