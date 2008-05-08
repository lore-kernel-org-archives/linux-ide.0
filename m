From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
Subject: Re: [PATCH] Re: [git patches] libata updates - (improve post-reset
 device ready test) regression
Date: Thu, 8 May 2008 23:43:00 +0200
Message-ID: <20080508234300.3c2a38af@werewolf.home>
References: <20080506154847.GA15299@havoc.gtf.org>
	<20080507145616.GA2210@gentoox2.trippelsdorf.de>
	<48231DAF.7070900@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ono.com ([62.42.230.12]:18545 "EHLO resmaa05.ono.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932636AbYEHVnK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 May 2008 17:43:10 -0400
In-Reply-To: <48231DAF.7070900@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linus-IDE <linux-ide@vger.kernel.org>

On Thu, 08 May 2008 11:35:11 -0400, Jeff Garzik <jeff@garzik.org> wrote:

> Markus Trippelsdorf wrote:
> >> Tejun Heo (12):
> >>       libata: improve post-reset device ready test
> > 
> > This commit (78ab88f04f44bed566d51dce0c7cbfeff6449a06) causes a long
> > boot delay with my onboard Promise controller. It seems like libata
> > probes for a nonexisting PATA drive...
> > 

I also had this patch collected from LKML, that still applies to -git6.
Is it really needed ?
ref: http://marc.info/?l=linux-ide&m=120913178617926&w=2

TIA

--- upstream/drivers/ata/libata-eh.c	2008-04-30 17:35:36.000000000 -0400
+++ linux/drivers/ata/libata-eh.c	2008-04-30 17:35:45.000000000 -0400
@@ -1312,8 +1312,7 @@
 		err_mask |= AC_ERR_ATA_BUS;
 		action |= ATA_EH_RESET;
 	}
-	if (serror &
-	    (SERR_DATA_RECOVERED | SERR_COMM_RECOVERED | SERR_DATA)) {
+	if (serror & (SERR_DATA_RECOVERED | SERR_DATA)) {
 		err_mask |= AC_ERR_ATA_BUS;
 		action |= ATA_EH_RESET;
 	}
@@ -1924,7 +1923,7 @@
 	}
 
 	if (ehc->i.serror)
-		ata_port_printk(ap, KERN_ERR,
+		ata_link_printk(link, KERN_ERR,
 		  "SError: { %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s}\n",
 		  ehc->i.serror & SERR_DATA_RECOVERED ? "RecovData " : "",
 		  ehc->i.serror & SERR_COMM_RECOVERED ? "RecovComm " : "",

-- 
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2008.1 (Cooker) for i586
Linux 2.6.23-jam05 (gcc 4.2.2 20071128 (4.2.2-2mdv2008.1)) SMP PREEMPT
