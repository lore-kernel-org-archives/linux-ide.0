From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: libata: Implement disk shock protection support
Date: Wed, 17 Feb 2016 22:24:35 +0300
Message-ID: <20160217192435.GA14960@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:25958 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030231AbcBQTYv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Feb 2016 14:24:51 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: eo@nebensachen.de
Cc: linux-ide@vger.kernel.org

Hello Elias Oltmanns,

The patch 45fabbb77bd9: "libata: Implement disk shock protection
support" from Sep 21, 2008, leads to the following Smatch
warning:

  drivers/ata/libata-scsi.c:206 ata_scsi_park_show()
  warn: inconsistent returns 'irqsave:flags'.
	  Locked on:   line 206
	  Unlocked on: line 206

drivers/ata/libata-scsi.c
   170  static ssize_t ata_scsi_park_show(struct device *device,
   171                                    struct device_attribute *attr, char *buf)
   172  {
   173          struct scsi_device *sdev = to_scsi_device(device);
   174          struct ata_port *ap;
   175          struct ata_link *link;
   176          struct ata_device *dev;
   177          unsigned long flags, now;
   178          unsigned int uninitialized_var(msecs);
   179          int rc = 0;
   180  
   181          ap = ata_shost_to_port(sdev->host);
   182  
   183          spin_lock_irqsave(ap->lock, flags);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   184          dev = ata_scsi_find_dev(ap, sdev);
   185          if (!dev) {
   186                  rc = -ENODEV;
   187                  goto unlock;
   188          }
   189          if (dev->flags & ATA_DFLAG_NO_UNLOAD) {
   190                  rc = -EOPNOTSUPP;
   191                  goto unlock;
   192          }
   193  
   194          link = dev->link;
   195          now = jiffies;
   196          if (ap->pflags & ATA_PFLAG_EH_IN_PROGRESS &&
   197              link->eh_context.unloaded_mask & (1 << dev->devno) &&
   198              time_after(dev->unpark_deadline, now))
   199                  msecs = jiffies_to_msecs(dev->unpark_deadline - now);
   200          else
   201                  msecs = 0;
   202  
   203  unlock:
   204          spin_unlock_irq(ap->lock);
                ^^^^^^^^^^^^^^^^^^^^^^^^^

This should almost certainly be spin_unlock_irqrestore().

   205  
   206          return rc ? rc : snprintf(buf, 20, "%u\n", msecs);
   207  }


regards,
dan carpenter
