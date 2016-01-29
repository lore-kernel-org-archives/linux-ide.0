From: Tejun Heo <tj@kernel.org>
Subject: [PATCH libata/for-4.5-fixes] libata-sff: use WARN instead of BUG on
 illegal host state machine state
Date: Fri, 29 Jan 2016 07:20:57 -0500
Message-ID: <20160129121604.GN32380@htj.duckdns.org>
References: <CACT4Y+b_JsOxJu2EZyEf+mOXORc_zid5V1-pLZSroJVxyWdSpw@mail.gmail.com>
 <20160129115214.GM32380@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160129115214.GM32380@htj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@redhat.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, syzkaller <syzkaller@googlegroups.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: linux-ide@vger.kernel.org

>From a588afc920bc50e894f6ae2874c4281c795e0979 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 29 Jan 2016 07:06:53 -0500

ata_sff_hsm_move() triggers BUG if it sees a host state machine state
that it dind't expect.  The risk for data corruption when the
condition occurs is low as it's highly unlikely that it would lead to
spurious completion of commands.  The BUG occasionally triggered for
subtle race conditions in the driver.  Let's downgrade it to WARN so
that it doesn't kill the machine unnecessarily.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
Applied to libata/for-4.5-fixes.

Thanks.

 drivers/ata/libata-sff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index cdf6215..608677d 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1296,7 +1296,8 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 		break;
 	default:
 		poll_next = 0;
-		BUG();
+		WARN(true, "ata%d: SFF host state machine in invalid state %d",
+		     ap->print_id, ap->hsm_task_state);
 	}
 
 	return poll_next;
-- 
2.5.0
