From: Andy Warner <andyw@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Thu, 7 Oct 2004 17:14:57 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041007171457.B21662@florence.linkmargin.com>
References: <415DA2C0.3060600@pobox.com> <20041001141244.B23006@florence.linkmargin.com> <415DB03E.5090005@pobox.com> <20041004155647.A9589@florence.linkmargin.com> <4161BB01.5080607@pobox.com> <20041006173656.A18221@florence.linkmargin.com> <416496CC.4090105@pobox.com> <20041006214746.A18793@florence.linkmargin.com> <4164B548.7030700@pobox.com> <4164BDD6.6000404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:37855 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S269851AbUJGWQs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Oct 2004 18:16:48 -0400
Content-Disposition: inline
In-Reply-To: <4164BDD6.6000404@pobox.com>; from jgarzik@pobox.com on Wed, Oct 06, 2004 at 11:53:58PM -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Doug Ledford <dledford@redhat.com>

Jeff Garzik wrote:
> BTW, the SiI folks recommend a debounce timer.

OK, got that. No problem, queue_delayed_work() and some
state handles that. Now I've got the following issue,
calling scsi_remove_device() seems to try and flush
the disk - not a very productive operation:

<drive removed>
ata1: drive not present
Synchronizing SCSI cache for disk sdb: 
ATA: abnormal status 0x7F on port 0xF8A3EC87
ATA: abnormal status 0x7F on port 0xF8A3EC87
ATA: abnormal status 0x7F on port 0xF8A3EC87
ata1: command 0xea timeout, stat 0x50 host_stat 0x0

<drive re-added>
ata1: drive present
  Vendor: ATA       Model: ST3160023AS       Rev: 3.17
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
ATA: abnormal status 0xFF on port 0xF8A3EC87
ATA: abnormal status 0xFF on port 0xF8A3EC87
ata1: command 0x25 timeout, stat 0x50 host_stat 0x1
 unknown partition table
Attached scsi disk sdb at scsi14, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi14, channel 0, id 0, lun 0,  type 0


I'm not too concerned about the errors when the drive
appears yet, but trying to access the disk that just
vanished is never going to work well. Am I missing
something ?

Here's the code (ignore hardcoded values and sloppy error
checking for now):

if (ap->hotplug_task_state == HOTPLUG_ST_PENDING) {
	struct scsi_device *sdev ;
	/*
	 * Need to read the status register to determine
	 * the current drive state.
	 */
	status = ap->ops->scr_read(ap, SCR_STATUS) ;
	if ((status & (SCR_STAT_IPM_MASK | SCR_STAT_DET_MASK)) ==
			(SCR_STAT_IPM_ACTIVE | SCR_STAT_DET_GOOD)) {
		/*
		 * Drive present.
		 */
		printk("ata%u: drive present\n", ap->id) ;

		/*
		 * Add it.
		 */
		sdev = scsi_add_device(ap->host, 0, 0, 0) ;
	} else {
		/*
		 * Drive not present.
		 */
		printk("ata%u: drive not present\n", ap->id) ;

		/*
		 * Remove it.
		 */
		sdev = scsi_device_lookup(ap->host, 0, 0, 0);
		if (sdev) {
			scsi_remove_device(sdev);
			scsi_device_put(sdev) ;
		}
	}
	ap->hotplug_task_state = HOTPLUG_ST_IDLE ;
}

-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
