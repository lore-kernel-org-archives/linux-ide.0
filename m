From: Eric Eikenberry <eric.eikenberry@psi.ch>
Subject: filesystem corruption with sata_sx4 driver
Date: Mon, 11 Oct 2004 12:41:33 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0410111233580.3966-100000@ganymede.psi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from psi12.psi.ch ([129.129.190.112]:38415 "HELO psi12.psi.ch")
	by vger.kernel.org with SMTP id S268767AbUJKKmL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2004 06:42:11 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Dear Jeff & collaborators,

As described in my previous e-mail, I experience filesystem corruption
with the sata_sx4 driver.  The syslog shows many messages of the form:

Oct 10 18:43:21 pc4868 kernel: EXT2-fs error (device md0): ext2_new_block:
        Allocating block in system zone - block = 133726230

and eventually:

Oct 10 18:57:33 pc4868 kernel: Unable to handle kernel paging request at
  virtual address ffa48000

The system is:
Dual Xeon box from Fujitsu-Siemens
root=/dev/hda1 (ext3), a separate 120 GB  EIDE disk
Promise FastTrak S150 SX4 controller configured as RAID0
3 MaxTor Max Line plus II 250 GB SATA drives
Suse 9.1 with kernnel updated to:  linux-2.6.9-rc3-mm3
ext2 filesystem on /dev/md0

Any help would be greatly appreciated.

Many thanks in advance.

Regards,
Eric


-------------------------------------------------------
Eric F. Eikenberry, Ph. D.
Swiss Light Source
Paul Scherrer Institute
CH-5232 Villigen PSI
Switzerland

Tel:  +41 56 / 310 51 28
             / 310 32 05
Fax:  +41 56 / 310 43 62

E-mail: eric.eikenberry@psi.ch
-------------------------------------------------------

