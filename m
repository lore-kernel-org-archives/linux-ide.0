Return-Path: <SRS0=Rzt2=6V=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DC8C38A2A
	for <linux-ide@archiver.kernel.org>; Thu,  7 May 2020 18:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F102495D
	for <linux-ide@archiver.kernel.org>; Thu,  7 May 2020 18:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877596;
	bh=XpmnuWyINxI6zEyO54yHC9Og/GemuFdZ9nKETjSbd5U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=r4+PkiQY4m8885AboByBIagWx62a2U4/+m43zSK6ZAUfUqW6mGCEl1qOM6nkhEGX6
	 OCS8eNFNDXcp8NXl/XX/JxNmgfcxFNu+KjU57izXcKeDK3fElHcoMZs4XpivLYx+aJ
	 w/0ujmUKraG3gZ8B4V1VkMgGYDSDLRAIGbofB7PE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgEGSxN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 7 May 2020 14:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgEGSxN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 7 May 2020 14:53:13 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DBDF2495D;
        Thu,  7 May 2020 18:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877592;
        bh=XpmnuWyINxI6zEyO54yHC9Og/GemuFdZ9nKETjSbd5U=;
        h=Date:From:To:Cc:Subject:From;
        b=lMoFYUDydm03VqI+1i1Fb5lKhT2cTh7yj3c4YOCIcJ8r3E4n6lIGTQIUPr9rU8EKt
         82ibY3rkXPCY5nGecchZS1qXr9S4ZFQ4PW3onBme++iRwcllh0FgbG5tcm4EGdIcM0
         6gXhqmXXcaP9YJTiA0VrTbrBMWab8ew8oLRLAAYE=
Date:   Thu, 7 May 2020 13:57:39 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libata: Replace zero-length array with flexible-array
Message-ID: <20200507185739.GA14954@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/libata.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index cffa4714bfa8..cbc95456dd23 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -609,7 +609,7 @@ struct ata_host {
 	struct task_struct	*eh_owner;
 
 	struct ata_port		*simplex_claimed;	/* channel owning the DMA */
-	struct ata_port		*ports[0];
+	struct ata_port		*ports[];
 };
 
 struct ata_queued_cmd {

