From: Mark de Wever <koraq@xs4all.nl>
Subject: [patch][repost] ide-tape build fix
Date: Tue, 7 Oct 2008 20:26:15 +0200
Message-ID: <20081007182615.GA2400@localhost>
References: <20080921185138.GA16310@localhost> <48D79ABD.8060805@ru.mvista.com> <9ea470500809220656j6dfcf4c9q7a5a4185481ec994@mail.gmail.com> <20080922204129.GA3495@localhost> <48D80949.4080901@ru.mvista.com> <20080923074845.GB5656@gollum.tnic> <20080923165914.GA7803@localhost> <9ea470500809231011p5ea37fc4u71eeeddf6ccec45a@mail.gmail.com> <20080923212018.GA3348@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757089AbYJGScQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080923212018.GA3348@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: petkovbb@gmail.com, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Gadi Oxman <gadio@netvision.net.il>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

I never got a reaction on this patch, but please apply it.

In order to compile the kernel with IDETAPE_DEBUG_LOG enabled I had to
apply the following build fix.

Signed-off-by: Mark de Wever <koraq@xs4all.nl>

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 3833189..7258eca 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -978,9 +978,10 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
 	struct request *postponed_rq = tape->postponed_rq;
 	u8 stat;
 
-	debug_log(DBG_SENSE, "sector: %ld, nr_sectors: %ld,"
+	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %ld,"
 			" current_nr_sectors: %d\n",
-			rq->sector, rq->nr_sectors, rq->current_nr_sectors);
+			(unsigned long long)rq->sector, rq->nr_sectors, 
+			rq->current_nr_sectors);
 
 	if (!blk_special_request(rq)) {
 		/* We do not support buffer cache originated requests. */

Regards,
Mark de Wever
