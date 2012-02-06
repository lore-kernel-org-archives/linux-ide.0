From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: Regression 3.2 -> 3.3-rc1 10 sec hang at boot and resume,
 COMRESET failed
Date: Mon, 06 Feb 2012 09:36:58 +0800
Message-ID: <1328492218.15079.38.camel@minggr>
References: <20120202051258.GA15550@gamma.logic.tuwien.ac.at>
	 <4F2A4B7E.2090503@linux.vnet.ibm.com> <1328231716.15079.15.camel@minggr>
	 <1328242884.15079.22.camel@minggr>
	 <20120203052452.GC24563@gamma.logic.tuwien.ac.at>
	 <1328247269.15079.26.camel@minggr>
	 <20120203054319.GA25510@gamma.logic.tuwien.ac.at>
	 <1328257660.15079.30.camel@minggr>
	 <20120206004608.GA9413@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120206004608.GA9413@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, jeff@garzik.org, Tejun Heo <tj@kernel.org>, "stern@rowland.harvard.edu >> Alan Stern" <stern@rowland.harvard.edu>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-ide@vger.kernel.org

On Mon, 2012-02-06 at 09:46 +0900, Norbert Preining wrote:
> Hi Lin,
> 
> 
> sorry for the delay, weekend I was off ...
> 
> On Fr, 03 Feb 2012, Lin Ming wrote:
> > > Confirmed. Reverted 7faa33da9b7 on top of 6c073a7ee250 made
> > > the boot delay go away. dmesg from this boot attached.
> > 
> > Dig into the code, but I can't find where the problem is.
> > 
> > Anyway, does below DEBUG patch help?
> > Let's always stop the engine during hard reset.
> 
> If you meant: 
>   "Try that patch on top of HEAD *without* reverting 7faa33da9b7?"
> then I can report that it does NOT help. With *only* this patch I still
> get 10sec delay, and otherwise nothing changes.

Does below help?

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index a72bfd0..33f7333 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -746,6 +746,9 @@ static void ahci_start_port(struct ata_port *ap)
 	/* enable FIS reception */
 	ahci_start_fis_rx(ap);
 
+	/* enable DMA */
+	ahci_start_engine(ap);
+
 	/* turn on LEDs */
 	if (ap->flags & ATA_FLAG_EM) {
 		ata_for_each_link(link, ap, EDGE) {
