Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDB9EB64DC
	for <linux-ide@archiver.kernel.org>; Tue, 18 Jul 2023 09:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGRJNB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 Jul 2023 05:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGRJMy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jul 2023 05:12:54 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC26E186
        for <linux-ide@vger.kernel.org>; Tue, 18 Jul 2023 02:12:52 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4tX20PBPzBQslD
        for <linux-ide@vger.kernel.org>; Tue, 18 Jul 2023 17:12:50 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689671569; x=1692263570; bh=wY7exn7O8/75pPLXp4GPcV17LqA
        3JdtXsrjYJFcOJv4=; b=vkDAPT1dW2JHYhf7B198dzviIOkyyRRK9i6wVZv+n8l
        bwV8dVQdRGJUPFCpDqrFKmxztgHEnw/f7QSDdDiBctAPXKDvAdQAq7HzeeRHB+Ss
        ZE+Vs3Y4S46tQMDcSXpJNHgfuLnVBsBJPCsaqIHzwuutFUy2dxCOw6no/GNeS4lv
        BxHxQdxcvDiMTCnbAMFD/aJxgEokMwpqKkrKHEX+Wsvq3FgbX9nEA2pNOQqGY7MX
        a42C0Tk7M5QwXixkDxXQwyiivPzpnx+LRrV3eioYzpfkjfTM+6dl+8krZlttZWpE
        sL3aXMOTF4CG+QW6vsS8Tl6CLZDWhRmHDu4UJNJ78sQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kuoidlbefgqT for <linux-ide@vger.kernel.org>;
        Tue, 18 Jul 2023 17:12:49 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4tX161GzzBJBfd;
        Tue, 18 Jul 2023 17:12:49 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 17:12:49 +0800
From:   hanyu001@208suo.com
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: ata: Added missing spaces
In-Reply-To: <tencent_BF5CCE8322052C3E2AE2861606F1D8AE740A@qq.com>
References: <tencent_BF5CCE8322052C3E2AE2861606F1D8AE740A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <c34db7fdcd7ac86046fe481cb91a9a48@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Added spaces needed in the proper places to address:

./drivers/ata/pata_triflex.c:88: ERROR: space required after that ';' 
(ctx:VxV)
./drivers/ata/pata_triflex.c:90: ERROR: space required after that ';' 
(ctx:VxV)
./drivers/ata/pata_triflex.c:92: ERROR: space required after that ';' 
(ctx:VxV)
./drivers/ata/pata_triflex.c:96: ERROR: space required after that ';' 
(ctx:VxV)
./drivers/ata/pata_triflex.c:98: ERROR: space required after that ';' 
(ctx:VxV)
./drivers/ata/pata_triflex.c:100: ERROR: space required after that ';' 
(ctx:VxV)
./drivers/ata/pata_triflex.c:102: ERROR: space required after that ';' 
(ctx:VxV)
./drivers/ata/pata_triflex.c:104: ERROR: space required after that ';' 
(ctx:VxV)
./drivers/ata/pata_triflex.c:106: ERROR: space required after that ';' 
(ctx:VxV)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  drivers/ata/pata_triflex.c | 18 +++++++++---------
  1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 26d448a..e75bf93 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -85,25 +85,25 @@ static void triflex_load_timing(struct ata_port *ap, 
struct ata_device *adev, in
      switch(speed)
      {
          case XFER_MW_DMA_2:
-            timing = 0x0103;break;
+            timing = 0x0103; break;
          case XFER_MW_DMA_1:
-            timing = 0x0203;break;
+            timing = 0x0203; break;
          case XFER_MW_DMA_0:
-            timing = 0x0808;break;
+            timing = 0x0808; break;
          case XFER_SW_DMA_2:
          case XFER_SW_DMA_1:
          case XFER_SW_DMA_0:
-            timing = 0x0F0F;break;
+            timing = 0x0F0F; break;
          case XFER_PIO_4:
-            timing = 0x0202;break;
+            timing = 0x0202; break;
          case XFER_PIO_3:
-            timing = 0x0204;break;
+            timing = 0x0204; break;
          case XFER_PIO_2:
-            timing = 0x0404;break;
+            timing = 0x0404; break;
          case XFER_PIO_1:
-            timing = 0x0508;break;
+            timing = 0x0508; break;
          case XFER_PIO_0:
-            timing = 0x0808;break;
+            timing = 0x0808; break;
          default:
              BUG();
      }
