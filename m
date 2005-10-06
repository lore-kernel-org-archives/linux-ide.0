From: Ravi Wijayaratne <ravi_wija@yahoo.com>
Subject: Reading SATA command/status register (lib-ata)
Date: Thu, 6 Oct 2005 09:55:44 -0700 (PDT)
Message-ID: <20051006165544.71775.qmail@web32512.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751149AbVJFQzp@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi all

I am calling libata-core.c:sata_phy_reset(port) from a kernel thread
to reset the hot plugged SATA drive. My machine locks up at the place
where it reads the status from the device in ata_busy_sleep(..).

1494         while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
1495                 msleep(50);
1496                 status = ata_chk_status(ap);
1497         }

ata_chk_status simply does a readl(status_register). It is not clear to me 
where the hang is. My machine locks up before I call msleep or ata_chk_status.
(determined by printks) after iterating the above routine a few times. When it 
locks up nothing responds. I cant even get to kdb to debug.

But what I noted is that every time it seem to lock up the when the ATA_BUSY status is
removed. (State changes from 0xd0 to 0x50 in ATA Status register). The ATA spec says
that each time this register is read any interrupts are cleared. I wander whether this
would cause the machine to hang ? 

Some insight will be much appreciated.

Thanks
Ravi
 



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
