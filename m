From: Mark Lord <liml@rtr.ca>
Subject: Re: [git patches] libata fixes
Date: Tue, 14 Nov 2006 11:32:50 -0500
Message-ID: <4559EFB2.1000809@rtr.ca>
References: <20061114150454.GA11900@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:52485 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S966187AbWKNQcw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Nov 2006 11:32:52 -0500
In-Reply-To: <20061114150454.GA11900@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7af2a4b..5c1fc46 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1612,9 +1612,9 @@ early_finish:
 
 err_did:
 	ata_qc_free(qc);
-err_mem:
 	cmd->result = (DID_ERROR << 16);
 	done(cmd);
+err_mem:
 	DPRINTK("EXIT - internal\n");
 	return 0;

This doesn't look correct to me, but I did miss out on the original discussion(?).

Any time we return 0 from queuecommand, the SCSI mid-layer expects us
to also take care of invoking the done() function.  Where does this now
happen for this case (err_mem) ???

Cheers
