From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: SATA link power management issues
Date: Tue, 21 Apr 2015 23:44:28 +0200
Message-ID: <23060306.XvNh4Q3UlK@xps13>
References: <3352987.ugV1Ipy7Z5@xps13> <9107428.nVaRUddl4K@xps13> <20150421205608.GF9455@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35593 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932686AbbDUVoc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Apr 2015 17:44:32 -0400
In-Reply-To: <20150421205608.GF9455@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stripathi@apm.com

On Tuesday 21 April 2015 16:56:08 Tejun Heo wrote:
> Hello,
> 
> On Tue, Apr 21, 2015 at 10:29:38PM +0200, Gabriele Mazzotta wrote:
> > Doing some quick tests I found that in some cases it takes 5 or 6
> > seconds for the first interrupt to arrive, so I'd have to use a quite
> > long interval to completely prevent errors.
> 
> Hmm...
> 
> > I am wondering if it would be better using my original solution
> > (i.e. ignore first event), but make it device specific given that it
> > might make no sense on other systems and seems to be more reliable than
> > the time-based one.
> 
> I'm not sure.  What if the extra PHY event isn't that reliable.  It'd
> be pretty confusing if it ends up ignoring a legitimate PHY event
> after, say, two hours, so one way or the other, we'd need to cap how
> long we're gonna be ignoring the event.  Ignore the first PHY event
> for 10s after LPM state change?

I haven't considered that possibility. Something like the following then?

---
 drivers/ata/libahci.c   | 9 ++++++++-
 drivers/ata/libata-eh.c | 3 +++
 include/linux/libata.h  | 3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 61a9c07..452c8f9 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1700,6 +1700,8 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
 	struct ahci_port_priv *pp = ap->private_data;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	int resetting = !!(ap->pflags & ATA_PFLAG_RESETTING);
+	unsigned long lpm_timeout = ap->link.last_lpm_change + 10 * HZ;
+	int ignore_event = 0;
 	u32 qc_active = 0;
 	int rc;
 
@@ -1707,8 +1709,13 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
 	if (unlikely(resetting))
 		status &= ~PORT_IRQ_BAD_PMP;
 
+	if (time_before(jiffies, lpm_timeout) &&
+	    (ap->link.flags & ATA_LFLAG_CHANGED))
+		ignore_event = 1;
+
 	/* if LPM is enabled, PHYRDY doesn't mean anything */
-	if (ap->link.lpm_policy > ATA_LPM_MAX_POWER) {
+	if (ap->link.lpm_policy > ATA_LPM_MAX_POWER || ignore_event) {
+		ap->link.flags &= ~ATA_LFLAG_CHANGED;
 		status &= ~PORT_IRQ_PHYRDY;
 		ahci_scr_write(&ap->link, SCR_ERROR, SERR_PHYRDY_CHG);
 	}
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 07f41be..cf0022e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3597,6 +3597,9 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		}
 	}
 
+	link->last_lpm_change = jiffies;
+	link->flags |= ATA_LFLAG_CHANGED;
+
 	return 0;
 
 fail:
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8dad4a3..c30c7aa 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -205,6 +205,7 @@ enum {
 	ATA_LFLAG_SW_ACTIVITY	= (1 << 7), /* keep activity stats */
 	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
 	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
+	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
@@ -788,6 +789,8 @@ struct ata_link {
 	struct ata_eh_context	eh_context;
 
 	struct ata_device	device[ATA_MAX_DEVICES];
+
+	unsigned long		last_lpm_change;
 };
 #define ATA_LINK_CLEAR_BEGIN		offsetof(struct ata_link, active_tag)
 #define ATA_LINK_CLEAR_END		offsetof(struct ata_link, device[0])

