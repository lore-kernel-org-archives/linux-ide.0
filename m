From: Dave Maurer <dcmaurer1@cox.net>
Subject: Intel 5000X ESB2 AHCI PCI Dev ID not recognized by ahci.c (0x2680)
Date: Mon, 18 Sep 2006 12:37:35 -0700
Message-ID: <200609181237.35209.dcmaurer1@cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49904 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932317AbWIRThh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Sep 2006 15:37:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918193736.JAUG13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>
          for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 15:37:36 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a Mac Pro which has an Intel 5000X chipset in it.  On boot, the PCI 
Device ID for the ESB2 SATA/AHCI controller is set to 0x2680.  The last three 
bits of the Dev ID are assigned by the fuse bits.  I can't find anywhere in 
the Intel docs for this chipset what the fuse bits mean, or why the bits are 
different across the chipsets that contain ESB2 chips.

Regardless, the ahci.c file only looks for the AHCI on ESB2 chips if the Dev 
ID is 0x2681, 0x2682, or 0x2683.  So, only the ata_piix.c driver picks up the 
0x2680 Dev ID and treats it as the SATA controller in ICH6.  The side effect 
is that only the first 4 SATA ports are detected and probed, and the last 2 
are ignored.

I added an entry in ahci.c to detect ESB2 on the 0x2680 ID, and all is well. I 
made this change to the 2.0 version of the ahci.c fle. Upon boot with the 
change, all SATA ports were detected and enabled correctly.

So I don't know if the simple patch would be just to add the ID to ahci.c, or 
if this would cause problems with other chipsets, (ICH6, ICH7, etc.)

FYI, here's the device list for the ESB2 SATA controller on the Mac Pros.  
This might be common across all 5000X chipsets, might not.

00:1f.1 0101: 8086:269e (rev 09)  -- Legacy IDE controller
00:1f.2 0101: 8086:2680 (rev 09)  -- SATA/AHCI controller


Thanks!
Dave Maurer

