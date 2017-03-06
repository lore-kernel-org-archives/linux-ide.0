From: Tejun Heo <tj@kernel.org>
Subject: Re: ata: WARNING in ata_sff_qc_issue
Date: Mon, 6 Mar 2017 15:32:13 -0500
Message-ID: <20170306203213.GB26127@htj.duckdns.org>
References: <CACT4Y+bXkvevNZU8uP6X0QVqsj6wNoUA_1exfTSOzc+SmUtMOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACT4Y+bXkvevNZU8uP6X0QVqsj6wNoUA_1exfTSOzc+SmUtMOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-ide@vger.kernel.org

Hello,

Applied the following to libata/for-4.11-fixes.

Thanks.

------ 8< ------
>From 0580b762a4d6b70817476b90042813f8573283fa Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 6 Mar 2017 15:26:54 -0500
Subject: [PATCH] libata: drop WARN from protocol error in ata_sff_qc_issue()

ata_sff_qc_issue() expects upper layers to never issue commands on a
command protocol that it doesn't implement.  While the assumption
holds fine with the usual IO path, nothing filters based on the
command protocol in the passthrough path (which was added later),
allowing the warning to be tripped with a passthrough command with the
right (well, wrong) protocol.

Failing with AC_ERR_SYSTEM is the right thing to do anyway.  Remove
the unnecessary WARN.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Link: http://lkml.kernel.org/r/CACT4Y+bXkvevNZU8uP6X0QVqsj6wNoUA_1exfTSOzc+SmUtMOA@mail.gmail.com
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 2bd92dc..274d6d7 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1482,7 +1482,6 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		break;
 
 	default:
-		WARN_ON_ONCE(1);
 		return AC_ERR_SYSTEM;
 	}
 
-- 
2.9.3
