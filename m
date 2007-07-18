From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [git patches 1/2] warnings: attack valid cases spotted by warnings
Date: Tue, 17 Jul 2007 19:46:21 -0700
Message-ID: <adair8io2de.fsf@cisco.com>
References: <20070717214239.GF28448@devserv.devel.redhat.com>
	<ada8x9epuip.fsf@cisco.com> <469D3E66.3010502@garzik.org>
	<adamyxuo2w6.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:14028 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbXGRCqX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jul 2007 22:46:23 -0400
In-Reply-To: <adamyxuo2w6.fsf@cisco.com> (Roland Dreier's message of "Tue, 17 Jul 2007 19:35:05 -0700")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, chas@cmf.nrl.navy.mil, rolandd@cisco.com, dwmw2@infradead.org, gregkh@suse.de

I think this patch (on top of the previous one) actually makes the
code clearer, and also makes it smaller:

add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-41 (-41)
function                                     old     new   delta
mthca_tavor_post_send                       1344    1335      -9
mthca_tavor_post_receive                     792     776     -16
mthca_arbel_post_send                       1481    1465     -16

So I'll test this a bit and probably merge it.
---
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 0e9ef24..186bade 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1590,13 +1590,14 @@ int mthca_tavor_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 	int nreq;
 	int i;
 	int size;
-	int size0 = 0;
 	/*
-	 * f0 is only used if nreq != 0, and f0 will be initialized
-	 * the first time through the main loop, since size0 == 0 the
-	 * first time through.  So nreq cannot become non-zero without
-	 * initializing f0, and f0 is in fact never used uninitialized.
+	 * f0 and size0 are only used if nreq != 0, and they will
+	 * always be initialized the first time through the main loop
+	 * before nreq is incremented.  So nreq cannot become non-zero
+	 * without initializing f0 and size0, and they are in fact
+	 * never used uninitialized.
 	 */
+	int uninitialized_var(size0);
 	u32 uninitialized_var(f0);
 	int ind;
 	u8 op0 = 0;
@@ -1774,11 +1775,11 @@ int mthca_tavor_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 				    mthca_opcode[wr->opcode]);
 		wmb();
 		((struct mthca_next_seg *) prev_wqe)->ee_nds =
-			cpu_to_be32((size0 ? 0 : MTHCA_NEXT_DBD) | size |
+			cpu_to_be32((nreq ? 0 : MTHCA_NEXT_DBD) | size |
 				    ((wr->send_flags & IB_SEND_FENCE) ?
 				    MTHCA_NEXT_FENCE : 0));
 
-		if (!size0) {
+		if (!nreq) {
 			size0 = size;
 			op0   = mthca_opcode[wr->opcode];
 			f0    = wr->send_flags & IB_SEND_FENCE ?
@@ -1828,7 +1829,14 @@ int mthca_tavor_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
 	int nreq;
 	int i;
 	int size;
-	int size0 = 0;
+	/*
+	 * size0 is only used if nreq != 0, and it will always be
+	 * initialized the first time through the main loop before
+	 * nreq is incremented.  So nreq cannot become non-zero
+	 * without initializing size0, and it is in fact never used
+	 * uninitialized.
+	 */
+	int uninitialized_var(size0);
 	int ind;
 	void *wqe;
 	void *prev_wqe;
@@ -1887,7 +1895,7 @@ int mthca_tavor_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
 		((struct mthca_next_seg *) prev_wqe)->ee_nds =
 			cpu_to_be32(MTHCA_NEXT_DBD | size);
 
-		if (!size0)
+		if (!nreq)
 			size0 = size;
 
 		++ind;
@@ -1909,7 +1917,6 @@ int mthca_tavor_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
 
 			qp->rq.next_ind = ind;
 			qp->rq.head += MTHCA_TAVOR_MAX_WQES_PER_RECV_DB;
-			size0 = 0;
 		}
 	}
 
@@ -1951,13 +1958,14 @@ int mthca_arbel_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 	int nreq;
 	int i;
 	int size;
-	int size0 = 0;
 	/*
-	 * f0 is only used if nreq != 0, and f0 will be initialized
-	 * the first time through the main loop, since size0 == 0 the
-	 * first time through.  So nreq cannot become non-zero without
-	 * initializing f0, and f0 is in fact never used uninitialized.
+	 * f0 and size0 are only used if nreq != 0, and they will
+	 * always be initialized the first time through the main loop
+	 * before nreq is incremented.  So nreq cannot become non-zero
+	 * without initializing f0 and size0, and they are in fact
+	 * never used uninitialized.
 	 */
+	int uninitialized_var(size0);
 	u32 uninitialized_var(f0);
 	int ind;
 	u8 op0 = 0;
@@ -1978,7 +1986,6 @@ int mthca_arbel_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 			doorbell[1] = cpu_to_be32((qp->qpn << 8) | size0);
 
 			qp->sq.head += MTHCA_ARBEL_MAX_WQES_PER_SEND_DB;
-			size0 = 0;
 
 			/*
 			 * Make sure that descriptors are written before
@@ -2163,7 +2170,7 @@ int mthca_arbel_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 				    ((wr->send_flags & IB_SEND_FENCE) ?
 				     MTHCA_NEXT_FENCE : 0));
 
-		if (!size0) {
+		if (!nreq) {
 			size0 = size;
 			op0   = mthca_opcode[wr->opcode];
 			f0    = wr->send_flags & IB_SEND_FENCE ?
