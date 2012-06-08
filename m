From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/7] drivers/ide/ide-cs.c: adjust suspicious bit
 operation
Date: Fri, 8 Jun 2012 07:14:03 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1206080712510.1793@hadrien>
References: <1339018901-28439-1-git-send-email-Julia.Lawall@lip6.fr> <1339018901-28439-2-git-send-email-Julia.Lawall@lip6.fr> <20120607.144616.2224976714259476349.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120607.144616.2224976714259476349.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com
List-Id: linux-ide@vger.kernel.org

>From nobody Wed Jun  6 21:48:37 CEST 2012
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org,linux-kernel@vger.kernel.org,joe@perches.com
Subject: [PATCH 1/7] drivers/ide/ide-cs.c: adjust suspicious bit operation

From: Julia Lawall <Julia.Lawall@lip6.fr>

IO_DATA_PATH_WIDTH_8 is 0, so a bit-and with it is always false.  The
value IO_DATA_PATH_WIDTH covers the bits of the IO_DATA_PATH constants, so
first pick those bits and then make the test using !=.

This problem was found using Coccinelle (http://coccinelle.lip6.fr/).

Signed-off-by: Julia Lawall <julia@diku.dk>

---
  drivers/ide/ide-cs.c |    3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

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
