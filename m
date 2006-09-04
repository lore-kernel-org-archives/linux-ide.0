From: jon@alumni.caltech.edu
Subject: Help diagnosing an SATA vs. Sil3112 error on NF7-S 2.0 +
     FC5/2.6.17 ?
Date: Sun, 3 Sep 2006 19:46:20 -0700 (PDT)
Message-ID: <60994.66.92.14.158.1157337980.squirrel@mail.alumni.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from posteaux1.caltech.edu ([131.215.239.119]:14740 "EHLO
	mail.alumni.caltech.edu") by vger.kernel.org with ESMTP
	id S1751319AbWIDCqY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Sep 2006 22:46:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

    Hi,

    I found a page on the Sil m15w bug at

http://home-tj.org/wiki/index.php/Sil_m15w

    I'm having a Sil3112 vs. Seagate SATA drive problem and am hoping
you can help me narrow down the possibilities as to what's happening.
Specifics:

    FC5 Linux running on an Abit NF-7 S 2.0, upgraded to
        kernel-2.6.17-1.2174_FC5
    Seagate ST3400633AS Rev 3.AA boot disk
    (and also a couple of older PATA disks on the IDE ports).

    So far I've seen two sorts of errors. They both seem to be preceded
by a sort of "chirp" from the drive. The first case resulted in journal
failure and remounting of the partition that occurred on R/O, the second
appeared to be more of a transient failure - after locking up the
machine for a minute, things resumed. The syslogs looked like this:

    First error:
> Sep  2 23:07:56 rocky kernel: ata1: command 0x25 timeout, stat 0x50
host_stat 0x1
> Sep  2 23:07:56 rocky kernel: ata1: status=0x50 { DriveReady SeekComplete }
> Sep  2 23:07:56 rocky kernel: ata1: error=0x01 { AddrMarkNotFound }
> Sep  2 23:07:56 rocky kernel: sda: Current: sense key: No Sense
> Sep  2 23:07:56 rocky kernel:     Additional sense: No additional sense
information
> Sep  2 23:07:56 rocky kernel: EXT3-fs error (device sda4):
ext3_free_blocks: Freeing blocks not in datazone - block = 1977993469,
count = 1
> Sep  2 23:07:56 rocky kernel: Aborting journal on device sda4.
> Sep  2 23:07:56 rocky kernel: ext3_abort called.
> Sep  2 23:07:56 rocky kernel: EXT3-fs error (device sda4):
ext3_journal_start_sb: Detected aborted journal
> Sep  2 23:07:56 rocky kernel: Remounting filesystem read-only
> Sep  2 23:07:56 rocky kernel: EXT3-fs error (device sda4):
ext3_free_blocks: Freeing blocks not in datazone - block = 1499238360,
count = 1
> Sep  2 23:07:56 rocky kernel: EXT3-fs error (device sda4):
ext3_free_blocks: Freeing blocks not in datazone - block = 1092876199,
count = 1
  [... and many, many more of the last line - there were hundreds of
   blocks recovered into lost+found after fsck, although their contents
   may all have been from previously deleted files]

    Second error:
> Sep  3 00:02:18 rocky kernel: ata1: command 0xca timeout, stat 0x50
host_stat 0x1
> Sep  3 00:02:18 rocky kernel: ata1: status=0x50 { DriveReady SeekComplete }
> Sep  3 00:02:18 rocky kernel: ata1: error=0x01 { AddrMarkNotFound }
> Sep  3 00:02:18 rocky kernel: sda: Current: sense key: No Sense
> Sep  3 00:02:18 rocky kernel:     Additional sense: No additional sense
information
> Sep  3 00:02:18 rocky kernel: Info fld=0x1

    Is either of these related to the "m15w" error? Or would you have
any other suggestions as to a known cause of the problem? I looked in
sata_sil.c, and the ST3400633AS is not on the blacklist in this kernel.

    So far I've upgraded the BIOS to the latest from Abit, which
includes a more recent SATA BIOS from Silicon Image, and fiddled with
some of the BIOS settings - particularly changing Ext-P2P Discard from
30us to 1ms, as suggested in a much older NVIDIA/Abit bug dialogue. I
don't know if any of this is actually helping yet, though.

    Thanks very much for any advice you may be able to offer!

    Jon Leech
    jon@alumni.caltech.edu




-- 
VGER BF report: U 0.672189
