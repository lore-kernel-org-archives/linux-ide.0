From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: reimplement suspend/resume support and fix spindown
 on poweroff
Date: Fri, 04 May 2007 21:26:36 +0200
Message-ID: <463B88EC.1080304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:20744 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423066AbXEDT07 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 15:26:59 -0400
Received: by nz-out-0506.google.com with SMTP id o1so966933nzf
        for <linux-ide@vger.kernel.org>; Fri, 04 May 2007 12:26:58 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Mark Lord <lkml@rtr.ca>, hancockr@shaw.ca, cebbert@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, emisca.ml@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Stephen.Clark@seclark.us, fabio.comolli@gmail.com, a.p.zijlstra@chello.nl

Hello,

This is another take at using sdev->manage_start_stop to reimplement
suspend/resume and fix spindown on poweroff.  As Robert pointed out in
the other thread[1], sadly, ATA spec does NOT require cache flush on
standby and some distros don't flush cache prior to put the drive into
standby mode during shutdown.  This means that we can't skip cache flush
in the kernel shutdown path because data loss is possible.  Also, we
just can't switch to new method because there are drives which spin up
if told to spin down while it's already spun down.

So, that leaves us with migrating to new behavior (kernel side
sync/shutdown) while maintaining backward compatibility.  This patchset
tries to do that by supplying a scheduled-to-be-removed module parameter
libata.spindown_compat which defaults to 1.  When set, it makes libata
skip spindown during shutdown sequence thus maintaining the old behavior
of issuing only cache flush on shutdown.

So, distros should update their shutdown(8) to do the followings.

  * Check whether /sys/modules/libata/parameters/spindown_compat
    exists.  If it does, write 0 to it.

  * For each libata harddisk {
	* Check whether /sys/class/scsi_disk/h:c:i:l/manage_start_stop
	  exists.  Iff it doesn't, synchronize cache and spin the disk
	  down as before.
  }

If shutdown(8) does the above, nothing will change on older kernels
(some drives will spin up and have to do emergency unload but they
aren't too many) and everything should work properly on kernels with
spindown_compat or later ones which won't have it.  If shutdown(8) isn't
updated, the kernel will behave the same way as older kernels would.

To accelerate userland update, if shutdown(8) isn't updated
(spindown_compat not cleared), libata will complain loudly about it,
point the user to http://linux-ata.org/shutdown.html (which should be
written) and pause for 5 seconds during shutdown.  Hopefully, this makes
the users bug distros sufficiently so that userland tools can be updated
quickly.  Note that the pausing happens only during shutdown not during
reboot or suspend, so it shouldn't be too much of annoyance.

This change requires sdev->manage_start_stop updates from scsi-misc-2.6.
 The merged git tree can be found at...

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=spindown
  git://htj.dyndns.org/libata-tj spindown

Thanks.

-- 
tejun

[1] http://thread.gmane.org/gmane.linux.ide/18167
