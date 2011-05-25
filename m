From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Wed, 25 May 2011 11:41:27 +0200
Message-ID: <20110525094127.GF10146@htj.dyndns.org>
References: <20110423005610.GC1576@mtj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32C775549E4@gretna.indigovision.com>
 <20110425162242.GB30828@mtj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32C77554BDC@gretna.indigovision.com>
 <20110426135027.GI878@htj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32C77554C70@gretna.indigovision.com>
 <20110426155229.GM878@htj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32C77554C91@gretna.indigovision.com>
 <20110430140109.GJ29280@htj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32C777089B2@gretna.indigovision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C1438B59050E1B4C9482FF3266AD6BA32C777089B2@gretna.indigovision.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bruce Stenning <b.stenning@indigovision.com>
Cc: Mark Lord <kernel@teksavvy.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello, sorry about the long delay.

On Tue, May 17, 2011 at 04:30:20PM +0100, Bruce Stenning wrote:
> __ata_port_freeze: ata4 port frozen
> ata4: hard resetting link
> sata_link_hardreset: ENTER
> ata4: COMRESET failed (errno=-32)
> sata_link_hardreset: EXIT, rc=-32
> ata4: reset failed (errno=-32), retrying in 33 secs
> __ata_port_freeze: ata4 port frozen
> ata4: hard resetting link
> sata_link_hardreset: ENTER
> ata4: COMRESET failed (errno=-32)
> sata_link_hardreset: EXIT, rc=-32
> ata4: reset failed, giving up
> ata_eh_recover: EXIT, rc=-32
> ata4.00: disabled
> ata4: EH complete
> ata_scsi_error: EXIT
> 
> The IRQ for that port is masked off afterwards.

This is a different issue.  libata EH plugs the port if reset fails
repeatedly.  This behavior was implemented to avoid causing continuous
resets on a port in case it has flaky PHY state reporting; however, it
seems to cause more trouble than fixing issues - ie. plugging in a
broken device may end up plugging the port even after the offending
device is removed until manual rescan or reboot.  I've been pondering
about changing the behavior like the following.

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index dfb6e9d..05797fe 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2885,8 +2885,17 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	    sata_scr_read(link, SCR_STATUS, &sstatus))
 		rc = -ERESTART;
 
-	if (rc == -ERESTART || try >= max_tries)
+	if (rc == -ERESTART || try >= max_tries) {
+		/*
+		 * Thaw host port even if reset failed, so that the port
+		 * can be retried on the next phy event.  This risks
+		 * repeated EH runs but seems to be a better tradeoff than
+		 * shutting down a port after a botched hotplug attempt.
+		 */
+		if (ata_is_host_link(link))
+			ata_eh_thaw_port(ap);
 		goto out;
+	}
 
 	now = jiffies;
 	if (time_before(now, deadline)) {
