Return-Path: <SRS0=lnsX=DG=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78C6C4741F
	for <linux-ide@archiver.kernel.org>; Tue, 29 Sep 2020 12:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4922075F
	for <linux-ide@archiver.kernel.org>; Tue, 29 Sep 2020 12:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601381927;
	bh=578R3508uXdLtwS+PUdl1f3urGkQb5DfZ4IgyloU0lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u++wzNsyGL8T05mMGZOdszh786e7Tn+09stNvp8o10p+70mrAWzpg3zm45xWtubCe
	 IF+y6taeYv94QxzvTXAijwd+BiBgLmpxGcc89nLGoQFyc+ndVY8SiKkahaYDUw1nQ9
	 3aq1uitO5Kpt67jZhsNTJp6TevJs01oU2UG3Ljjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbgI2MS1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 29 Sep 2020 08:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729975AbgI2LgV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 29 Sep 2020 07:36:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9BF823E1B;
        Tue, 29 Sep 2020 11:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601379079;
        bh=578R3508uXdLtwS+PUdl1f3urGkQb5DfZ4IgyloU0lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfbYm4UwglPCMXWsFykgdPdosOTlUgwhtDa3uiwrUCFFckefISL4Y1vEadwvB3olT
         SstuL4MoxfR1d1VID4i3vxrYIIh63E4hRjHfmc09YU/AH5lN+r1LBg+5vLONmkiWe7
         ZEC5NHVraC2pbKF2xBikuGaqeJC6fqH8cKo79/wY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: [PATCH 4.19 242/245] ata: define AC_ERR_OK
Date:   Tue, 29 Sep 2020 13:01:33 +0200
Message-Id: <20200929105958.775606983@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929105946.978650816@linuxfoundation.org>
References: <20200929105946.978650816@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

commit 25937580a5065d6fbd92d9c8ebd47145ad80052e upstream.

Since we will return enum ata_completion_errors from qc_prep in the next
patch, let's define AC_ERR_OK to mark the OK status.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/libata.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -503,6 +503,7 @@ enum hsm_task_states {
 };
 
 enum ata_completion_errors {
+	AC_ERR_OK		= 0,	    /* no error */
 	AC_ERR_DEV		= (1 << 0), /* device reported error */
 	AC_ERR_HSM		= (1 << 1), /* host state machine violation */
 	AC_ERR_TIMEOUT		= (1 << 2), /* timeout */


