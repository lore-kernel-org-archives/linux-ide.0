From: "Fajun Chen" <fajunchen@gmail.com>
Subject: How to synchronize SCSI user scan with SCSI hotplug/rescan
Date: Tue, 24 Apr 2007 17:57:54 -0600
Message-ID: <8202f4270704241657n57866bf0hacc604338c28d100@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:59070 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbXDXX6F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Apr 2007 19:58:05 -0400
Received: by wx-out-0506.google.com with SMTP id h31so32794wxd
        for <linux-ide@vger.kernel.org>; Tue, 24 Apr 2007 16:58:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>

Hi Folks,

In libata EH code, both SCSI hotplug and rescan are executed from a
separate workqueue after EH completes as shown below:
void ata_scsi_error(struct Scsi_Host *host)
{
...
	if (ap->pflags & ATA_PFLAG_LOADING)
		ap->pflags &= ~ATA_PFLAG_LOADING;
	else if (ap->pflags & ATA_PFLAG_SCSI_HOTPLUG)
		queue_work(ata_aux_wq, &ap->hotplug_task);
}

static int ata_eh_revalidate_and_attach()
{
...
queue_work(ata_aux_wq, &(ap->scsi_rescan_task));
}

However SCSI user scan code is synchronized to EH only as shown below:
static int ata_scsi_user_scan()
{
...
	if (rc == 0)
	{
	  ata_port_schedule_eh(ap);
	  spin_unlock_irqrestore(ap->lock, flags);
	  ata_port_wait_eh(ap);
        }
...
}

So SCSI user scan could race with SCSI hotplug/rescan and the
consequence is that   we may not be able to access device right after
user scan.  We can work around the issue by adding timeout in user
space code but this is not a real fix. Can we synchronize SCSI user
scan with SCSI hotplug/rescan?

Thanks,
Fajun
