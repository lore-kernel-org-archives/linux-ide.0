Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9905EB64DC
	for <linux-ide@archiver.kernel.org>; Wed, 19 Jul 2023 02:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGSCCQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 Jul 2023 22:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGSCCP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jul 2023 22:02:15 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B87210B
        for <linux-ide@vger.kernel.org>; Tue, 18 Jul 2023 19:02:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5Jn96M9yzBRYmF
        for <linux-ide@vger.kernel.org>; Wed, 19 Jul 2023 09:55:41 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689731741; x=1692323742; bh=yKSd7cxWjShDjglwegTmMtByAjU
        2HTzhwkcLswWUnSc=; b=CzQ8R5HaQukQMuwIRnAUJQw/m6yCltyonp+tBI2dKDw
        NWZEuNwr0oNkLk+TuHLDuUAhIrDMM3sVKH5T9QEEQbtyCBf5kvf4f6WBQE66dIF6
        AOKfu3x8wBegS/CNrVIHR/BMzGU/CTzxD4vJDYAYb8vKIl69lbiYWEkjnQRn8xkw
        bMHjzEDYdheRt968wZsNIrm/pBwYMqBU21GwFSfRCWcCYFXoJpMlW/1aTVGmX+9+
        kbh9S78BEl5/l+AGDO+6RpklS5WrAehk8JiWemrHivnqZ8KcqgSktrWwWHjpVFJg
        ltNuqcTv5JDKXBozAeFmfVvR0bek5R5o9sQOM+d32PA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z7hBvI6JUzFu for <linux-ide@vger.kernel.org>;
        Wed, 19 Jul 2023 09:55:41 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5JlY3g0BzBtk6C;
        Wed, 19 Jul 2023 09:54:17 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 09:54:17 +0800
From:   hanyu001@208suo.com
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: pata_serverworks: "foo * bar" should be "foo *bar"
In-Reply-To: <tencent_FAA8D636BA8369FE01896CB144F12E543905@qq.com>
References: <tencent_FAA8D636BA8369FE01896CB144F12E543905@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <fee05ac48ee8c60b0843a7d63260ba1d@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch fixes the checkpatch.pl error:

./drivers/ata/pata_serverworks.c:305: ERROR: "foo * bar" should be "foo 
*bar"

Signed-off-by: 	Yu Han <hanyu001@208suo.com>
---
  drivers/ata/pata_serverworks.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_serverworks.c 
b/drivers/ata/pata_serverworks.c
index b348784..549ff24 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -302,7 +302,7 @@ static int serverworks_fixup_csb(struct pci_dev 
*pdev)

      /* Third Channel Test */
      if (!(PCI_FUNC(pdev->devfn) & 1)) {
-        struct pci_dev *findev = NULL;
+        struct pci_dev * findev = NULL;
          u32 reg4c = 0;
          findev = pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
              PCI_DEVICE_ID_SERVERWORKS_CSB5, NULL);
