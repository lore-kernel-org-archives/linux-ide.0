From: "Anthony J. Ciani" <tony@ciani.phy.uic.edu>
Subject: libata / sata_promise badblocks crash
Date: Thu, 6 Jan 2005 17:21:08 -0600 (CST)
Message-ID: <Pine.LNX.4.61.0501061709110.7434@ciani.phy.uic.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ciani.phy.uic.edu ([131.193.191.66]:42880 "EHLO
	ciani.phy.uic.edu") by vger.kernel.org with ESMTP id S263061AbVAFXVL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Jan 2005 18:21:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: tobias.lorenz@gmx.net, linux-ide@vger.kernel.org

Hello,

Using 2.6.9-rc4 with the pata_promise patch (2004-10-02 version) applied 
to libata.c and sata_promise.c.  The controller is a Promise Technology, 
Inc. PDC20376 (rev 02), and the drive is on the PATA port.

Kernel freezes (crashes) are occuring when running e2fsck with the 
badblocks (-c) option.

After some random number of errors such as;

ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
scsi2: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 20 cd 34 00 00 6e 00
Current sda: sense key Medium Error
Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 2149684

the kernel freezes/crashes.

Is this related to the DMA errors which are fixed in the 2.6.10 kernel?
Is it still necessary to apply the sata_promise PATA patch in the 2.6.10 
kernel?


PS:  Is there a way to send hdparm type commands to libata devices?


------------------------------------------------------------
               Anthony Ciani (aciani1@uic.edu)
            Computational Condensed Matter Physics
    Department of Physics, University of Illinois, Chicago
               http://ciani.phy.uic.edu/~tony
------------------------------------------------------------
