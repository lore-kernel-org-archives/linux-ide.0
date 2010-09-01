From: Siddhartha Jain <siddhartha@siddharthajain.net>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Wed, 1 Sep 2010 12:47:53 -0700
Message-ID: <AANLkTikqxmzQozCOo+7XDSWE4tTniSnYbomEgqA4aB-2@mail.gmail.com>
References: <1283027290.2721.37.camel@myfedorahat>
	<4C7BAA42.2050809@kernel.org>
	<AANLkTimEQEAF7WfCmmSfS_Ryq7HEfqemAnh9BvdKRhqL@mail.gmail.com>
	<AANLkTi=3BVGUSNUZn=QbDciWdhBPmxe0kQgKcBFtkSH7@mail.gmail.com>
	<AANLkTin5uTJA0G+hWxfsGFhyC_N9ZR7rZN9qCjK5VyvU@mail.gmail.com>
	<AANLkTi=mGaNoutyh=iVrGORYjRx_qvnVfMHL63TuY5gY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58363 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab0IATry convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2010 15:47:54 -0400
Received: by qyk36 with SMTP id 36so1010660qyk.19
        for <linux-ide@vger.kernel.org>; Wed, 01 Sep 2010 12:47:53 -0700 (PDT)
In-Reply-To: <AANLkTi=mGaNoutyh=iVrGORYjRx_qvnVfMHL63TuY5gY@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi Tejun,

Was any of this debug info helpful?

Thanks,

- Siddhartha


On Mon, Aug 30, 2010 at 7:03 PM, Siddhartha Jain
<siddhartha@siddharthajain.net> wrote:
> Upgraded to latest stable release - 2.6.35.4. Same errors:
>
> PM: Syncing filesystems ... done.
> PM: Preparing system for mem sleep
> Freezing user space processes ... (elapsed 0.01 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
> PM: Entering mem sleep
> Suspending console(s) (use no_console_suspend to debug)
> eth0: link up.
> scsi 0:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0FUJITSU MJA2250B 0=
081 PQ: 0 ANSI: 5
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> ata2.00: detaching (SCSI 1:0:0:0)
> EXT4-fs error (device sda2): __ext4_get_inode_loc: inode #2885332:
> (comm udevd) unable to read inode block 11534477
> sd 0:0:0:0: [sdc] 488397168 512-byte logical blocks: (250 GB/232 GiB)
> EXT4-fs error (device sda2): ext4_find_entry: inode #2884877: (comm
> udevd) reading directory lblock 0
> sd 0:0:0:0: [sdc] Write Protect is off
> sd 0:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> =A0sdc:
> scsi 1:0:0:0: CD-ROM =A0 =A0 =A0 =A0 =A0 =A0HL-DT-ST DVDRW =A0GS23N =A0=
 =A0 SB03 PQ: 0 ANSI: 5
> EXT4-fs error (device sda2): ext4_find_entry: inode #4456450: (comm
> gnome-panel) reading directory lblock 0
> EXT4-fs error (device sda2): ext4_find_entry: inode #4456489: (comm
> gnome-panel) reading directory lblock 0
> EXT4-fs error (device sda2): ext4_find_entry: inode #3670077: (comm
> gnome-panel) reading directory lblock 0
> EXT4-fs error (device sda2): ext4_find_entry: inode #3670017: (comm
> gnome-panel) reading directory lblock 0
> EXT4-fs error (device sda2): ext4_find_entry: inode #3670068: (comm
> gnome-panel) reading directory lblock 0
> EXT4-fs error (device sda2): ext4_find_entry: inode #10485761: (comm
> gnome-panel) reading directory lblock 0
> EXT4-fs error (device sda2): ext4_find_entry: inode #3670068: (comm
> gnome-panel) reading directory lblock 0
> EXT4-fs error (device sda2): ext4_find_entry: inode #4456450: (comm
> gnome-panel) reading directory lblock 0
> sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda caddy
> sr 1:0:0:0: Attached scsi CD-ROM sr0
> sr 1:0:0:0: Attached scsi generic sg1 type 5
> EXT4-fs error (device sda2): __ext4_get_inode_loc: inode #2885332:
> (comm udevd) unable to read inode block 11534477
> EXT4-fs error (device sda2): __ext4_get_inode_loc: inode #2885332:
> (comm udevd) unable to read inode block 11534477
> EXT4-fs error (device sda2): __ext4_get_inode_loc: inode #2885332:
> (comm udevd) unable to read inode block 11534477
> EXT4-fs error (device sda2): __ext4_get_inode_loc: inode #2885332:
> (comm udevd) unable to read inode block 11534477
> EXT4-fs error (device sda2): __ext4_get_inode_loc: inode #2885332:
> (comm udevd) unable to read inode block 11534477
> =A0sdc1 sdc2 sdc3
> sd 0:0:0:0: [sdc] Attached SCSI disk
>
