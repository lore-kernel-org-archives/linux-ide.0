From: Jim Ramsay <jim.ramsay@gmail.com>
Subject: Re: [PATCH 3/3] Add disk hotswap support to libata RESEND #2
Date: Mon, 29 Aug 2005 13:45:03 -0600
Message-ID: <4789af9e0508291245709eca2f@mail.gmail.com>
References: <355e5e5e05080103021a8239df@mail.gmail.com>
	 <4789af9e050823124140eb924f@mail.gmail.com>
	 <4789af9e050823154364c8e9eb@mail.gmail.com>
	 <430BA990.9090807@mvista.com> <430BCB41.5070206@s5r6.in-berlin.de>
	 <355e5e5e05082407031138120a@mail.gmail.com>
	 <4789af9e05082408111c4a6294@mail.gmail.com>
	 <4789af9e05082409121cc6870@mail.gmail.com>
	 <4789af9e0508291223435f174@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:62750 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751479AbVH2TpE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Aug 2005 15:45:04 -0400
Received: by zproxy.gmail.com with SMTP id r28so687448nza
        for <linux-ide@vger.kernel.org>; Mon, 29 Aug 2005 12:45:03 -0700 (PDT)
In-Reply-To: <4789af9e0508291223435f174@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-ide <linux-ide@vger.kernel.org>

Another interesting issue with hotplug which may need SCSI-layer changes:
 
If you unplug a device that some process already has open (for
example, md), the device is removed, but the internal scsi_device
struct is not actually freed until ALL references to this device
(including that still held by md) release it.
 
When you re-plugin the device at this time (scsi_device has been
marked as 'deleted' but not actually freed), the code properly detects
that while there is still a scsi_device for this host/channel/id/lun
combination, it is marked as "SDEV_DEL" and so should not be used. 
Fine - a new scsi_device struct is allocated and added to  the back of
the Scsi_Host->__devices list.
 
The problem: From now on, whenever someone wants to use this scsi
device, they will end up calling scsi_device_lookup, which calls
__scsi_device_lookup, which will always return the first scsi_device
struct, the one which is now SDEV_DEL, so scsi_device_lookup will
return NULL.  This means that subsequent hot-unplugs will not remove
the most-recently-allocated scsi_device struct, so no hotplug events
are sent and no udev devices are removed.  This is bad -> a memory
leak.
 
The workaround:  This probably has ramifications I'm not considering,
but the following replacement for __scsi_device_lookup in scsi.c seems
to work for me.  It returns the LAST matching scsi_device (and
therefore most-recently allocated), as opposed to the old code which
returned the FIRST matching scsi_device:
 
struct scsi_device *__scsi_device_lookup(struct Scsi_Host *shost,
                 uint channel, uint id, uint lun)
{
         struct scsi_device *found_sdev = NULL;
         struct scsi_device *sdev;
 
         list_for_each_entry(sdev, &shost->__devices, siblings) {
                 printk( "device lookup checking %d:%d:%d:%d against
%d:%d:%d:%d\n",
                                 shost->host_no, channel, id, lun,
                                 shost->host_no, sdev->channel,
sdev->id, sdev->lun );
                 if (sdev->channel == channel && sdev->id == id &&
                                 sdev->lun ==lun)
                 {
                         found_sdev = sdev;
                 }
         }
 
         return found_sdev;
}
 
How else could this be solved?  I suppose adding newly allocated
scsi_device structs to the FRONT of the Scsi_Host->__devices list
would have the same effect as my alternate search routine, but I don't
know which would be better.  I can't think of any solution that
wouldn't touch the existing SCSI layer, though.

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
