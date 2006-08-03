From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata question
Date: Thu, 03 Aug 2006 16:58:25 +0900
Message-ID: <44D1ACA1.2040809@gmail.com>
References: <1154445491.18593.111.camel@acme>  <44CF7447.300@gmail.com>	 <1154457583.4665.5.camel@shark.pacific>  <44CFA15C.8080109@gmail.com>	 <1154458981.4665.9.camel@shark.pacific>  <44CFA618.2090204@gmail.com>	 <1154502301.5691.23.camel@acme>  <44D0522E.6030905@gmail.com>	 <1154529340.25611.75.camel@acme>  <44D0BE99.8010809@gmail.com> <1154589962.25611.102.camel@acme>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.206]:16715 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932380AbWHCH6L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Aug 2006 03:58:11 -0400
Received: by wx-out-0102.google.com with SMTP id s14so967363wxc
        for <linux-ide@vger.kernel.org>; Thu, 03 Aug 2006 00:58:11 -0700 (PDT)
In-Reply-To: <1154589962.25611.102.camel@acme>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Oberholtzer <roger@opq.se>
Cc: linux-ide@vger.kernel.org

Roger Oberholtzer wrote:
> If I switch two disks around and do a scan, nothing changes. I need
> to delete the disks and then scan to have the change noted. Is this
> expected behavior?

No, issuing scan makes libata reset the channel and revalidate all 
attached devices.  Swap as you want and issue scan to all controllers 
should always do the job as long as hardware is okay with it.

> Does this mean I must delete a disk with a command when it it removed?
> This is problematic in that I do not know which disk may have been
> removed!
> The old /proc/scsi interface would allow you to update the idea of which
> things are attached without knowing which they were and (key point)
> without
> messing up a device that is unchanged and mounted.
> 
> Is this possible with libata?

Yes, just issue scan to all suspected interfaces.

> I know you want logs. But I really feel that if the intended use is
> unclear,
> I can waste lots of time here sending in logs when trying to do things
> that the driver does not intend I do. Step 1 must surely be to tell the
> driver's expectations/limits first.

To me, surplus info is always better than insufficient info.  I can 
filter libata messages pretty well and explain it to you.  Trust me.

> If I remove or insert a disk, there is nothing at all added to the
> kernel log. There only seems to be activity when I echo something to
> a file in /sys.

Hardware limitation of ata_piix.  PHY registers are inaccessible and 
there's no phy status changed interrupt.

> If I remove disks (but run no commands on the computer) and then do a
> scan, I get this in the log:
> 
> Aug  3 08:16:43 aies1 kernel: ata1.00: qc timeout (cmd 0xec)
> Aug  3 08:16:43 aies1 kernel: ata1.00: failed to IDENTIFY (I/O error,
> err_mask=0                           x4)
> Aug  3 08:16:43 aies1 kernel: ata1.00: revalidation failed (errno=-5)
> Aug  3 08:16:43 aies1 kernel: ata1: failed to recover some devices,
> retrying in                            5 secs
> Aug  3 08:16:45 aies1 kernel: ata2.00: qc timeout (cmd 0xec)
> Aug  3 08:16:45 aies1 kernel: ata2.00: failed to IDENTIFY (I/O error,
> err_mask=0                           x4)
> Aug  3 08:16:45 aies1 kernel: ata2.00: revalidation failed (errno=-5)
> Aug  3 08:16:45 aies1 kernel: ata2: failed to recover some devices,
> retrying in                            5 secs
> Aug  3 08:16:55 aies1 kernel: ata1: port is slow to respond, please be
> patient
> Aug  3 08:16:57 aies1 kernel: ata2: port is slow to respond, please be
> patient
> Aug  3 08:17:18 aies1 kernel: ata1: port failed to respond (30 secs)
> Aug  3 08:17:18 aies1 kernel: ata1: soft resetting port
> Aug  3 08:17:20 aies1 kernel: ata2: port failed to respond (30 secs)
> Aug  3 08:17:20 aies1 kernel: ata2: soft resetting port
> Aug  3 08:17:25 aies1 kernel: ata1: port is slow to respond, please be
> patient
> Aug  3 08:17:27 aies1 kernel: ata2: port is slow to respond, please be
> patient
> Aug  3 08:17:48 aies1 kernel: ata1: port failed to respond (30 secs)

For both ata1 and ata2, libata is trying to scan the channels by

1. issuing reset
2. revalidate existing devices, if they fail remove.
3. discover new devices

ata_piix doesn't provide phy status regs, so libata cannot know whether 
device is attached to the port or not.  libata does traditional device 
detection by writing and reading back certain TF regs but in most SATA 
controllers this method results in false positive.  During boot, BIOS 
marks which ports are occupied, so this doesn't really matter.

So, libata assumes device is attached to the port and issues reset.  Of 
course, device isn't there so it times out.  After several tries (which 
can take a few minutes), libata will give up and disable the devices and 
ports.  If you connect device to the ports and issue scan, libata will 
retry and discover new devices.  Or, just replace disks and issue scan, 
libata will know that devices have changed immediately and detach old 
ones and attach new ones.

The problem is that ata_piix can't really do hotplug.  It can do 
warmplug with some help from user but if you don't tell it which device 
to remove precisely, it may need quite some timeouts and retries as 
you've seen.

I don't know your usage model but my recommendation is...

* If you're gonna do a lot of hotplugging, just get a sil3114 or 3124, 
they're cheap and hotplug works well on those controllers.

* If you're gonna stick with ata_piix, find a way to exactly find which 
device is removed or issue scan after attaching new device.

-- 
tejun
