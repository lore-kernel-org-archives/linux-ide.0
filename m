From: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 8/29] ide: driver updates
Date: Wed, 2 Feb 2005 11:50:20 +0900
Message-ID: <20050202025020.GI621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from [211.58.254.17] ([211.58.254.17]:60553 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262229AbVBBCuW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Feb 2005 21:50:22 -0500
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> 08_ide_do_identify_model_string_termination.patch
> 
> 	Terminates id->model string before invoking strstr() in
> 	do_identify().


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-probe.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-probe.c	2005-02-02 10:27:15.858207205 +0900
+++ linux-ide-export/drivers/ide/ide-probe.c	2005-02-02 10:28:03.719442099 +0900
@@ -165,11 +165,12 @@ static inline void do_identify (ide_driv
 	ide_fixstring(id->fw_rev,    sizeof(id->fw_rev),    bswap);
 	ide_fixstring(id->serial_no, sizeof(id->serial_no), bswap);
 
+	/* we depend on this a lot! */
+	id->model[sizeof(id->model)-1] = '\0';
+
 	if (strstr(id->model, "E X A B Y T E N E S T"))
 		goto err_misc;
 
-	/* we depend on this a lot! */
-	id->model[sizeof(id->model)-1] = '\0';
 	printk("%s: %s, ", drive->name, id->model);
 	drive->present = 1;
 	drive->dead = 0;
