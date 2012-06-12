From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [PATCH 1/7] drivers/ide/ide-cs.c: adjust suspicious bit
 operation
Date: Tue, 12 Jun 2012 10:17:25 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1206121016090.1795@hadrien>
References: <1339018901-28439-2-git-send-email-Julia.Lawall@lip6.fr> <20120607.144616.2224976714259476349.davem@davemloft.net> <alpine.DEB.2.02.1206080712510.1793@hadrien> <20120611.164316.2252454788889367611.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail4-relais-sop.national.inria.fr ([192.134.164.105]:8256 "EHLO
	mail4-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751074Ab2FLORb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jun 2012 10:17:31 -0400
In-Reply-To: <20120611.164316.2252454788889367611.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com

From: Julia Lawall <Julia.Lawall@lip6.fr>

IO_DATA_PATH_WIDTH_8 is 0, so a bit-and with it is always false.  The
value IO_DATA_PATH_WIDTH covers the bits of the IO_DATA_PATH constants, so
first pick those bits and then make the test using !=.

This problem was found using Coccinelle (http://coccinelle.lip6.fr/).

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
I hope to have fixed the mail client problem.

diff --git a/drivers/ide/ide-cs.c b/drivers/ide/ide-cs.c
index 28e344e..f1e922e 100644
--- a/drivers/ide/ide-cs.c
+++ b/drivers/ide/ide-cs.c
@@ -167,7 +167,8 @@ static int pcmcia_check_one_config(struct pcmcia_device *pdev, void *priv_data)
 {
 	int *is_kme = priv_data;

-	if (!(pdev->resource[0]->flags & IO_DATA_PATH_WIDTH_8)) {
+	if ((pdev->resource[0]->flags & IO_DATA_PATH_WIDTH)
+	    != IO_DATA_PATH_WIDTH_8) {
 		pdev->resource[0]->flags &= ~IO_DATA_PATH_WIDTH;
 		pdev->resource[0]->flags |= IO_DATA_PATH_WIDTH_AUTO;
 	}
