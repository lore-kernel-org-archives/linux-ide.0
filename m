From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] sysfs: handle duplicate removal attempts in
 sysfs_remove_group()
Date: Mon, 25 Nov 2013 12:11:54 +0200
Message-ID: <20131125101154.GS2281@intel.com>
References: <1384866598-19716-1-git-send-email-mika.westerberg@linux.intel.com>
 <20131123230701.GA6183@kroah.com>
 <2196420.QNWb3mfseF@vostro.rjw.lan>
 <3805095.rqdZNnA0Ng@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3805095.rqdZNnA0Ng@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "James E.J. Bottomley" <JBottomley@parallels.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Nov 24, 2013 at 02:09:09AM +0100, Rafael J. Wysocki wrote:
> On Sunday, November 24, 2013 12:36:03 AM Rafael J. Wysocki wrote:
> > On Saturday, November 23, 2013 03:07:01 PM Greg Kroah-Hartman wrote:
> > > On Sun, Nov 24, 2013 at 12:12:59AM +0100, Rafael J. Wysocki wrote:
> > > > On Saturday, November 23, 2013 02:53:58 PM Greg Kroah-Hartman wrote:
> 
> [...]
> 
> > > > > 
> > > > > I can revert Mika's patch, as it would be good to catch these kinds of
> > > > > errors.
> > > > 
> > > > Then we'll need to untangle the SATA/SCSI mess triggered by Bjorn in
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=65281. ;-)
> > > 
> > > I have no objection to fixing that, the scsi sysfs handling is "odd" to
> > > say the least...
> > > 
> > > If someone can unwind it, that would be great to see happen...
> > 
> > Well, if I'm bored to death during the xmas holidays, I may look into that.
> 
> In fact, I'm not exactly sure why ata_port_detach() calls ata_tport_delete()
> before scsi_remove_host()?  Is there any particular reason?  Because that
> doesn't seem to be exactly right ...

I tried so that I have your 'PCI: Move device_del() from pci_stop_dev() to
pci_destroy_dev()' applied and then I did following change as you
suggested.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 81a94a3919db..07a03f93d640 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6304,10 +6304,10 @@ static void ata_port_detach(struct ata_port *ap)
 		for (i = 0; i < SATA_PMP_MAX_PORTS; i++)
 			ata_tlink_delete(&ap->pmp_link[i]);
 	}
-	ata_tport_delete(ap);
-
 	/* remove the associated SCSI host */
 	scsi_remove_host(ap->scsi_host);
+
+	ata_tport_delete(ap);
 }
 
 /**

After both patches are applied the warnings are gone :) However, looks like
both are needed since if I only apply one or another, I still get warnings.
