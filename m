From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error
Date: Thu, 05 Aug 2004 16:50:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <41129D79.9010402@emc.com>
References: <41126458.1050203@emc.com> <1091724300.8043.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267939AbUHEUyw@vger.kernel.org>
In-Reply-To: <1091724300.8043.58.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
> I would make sure you are looking at the right register set in your own
> code. Any code now thats going to exist for most 2.4 users will need to
> do that itself, and after my 2.4 experience with the IDE core I'd advise
> anyone working on it to
> 
> a) Pass it off to another maintainer as fast as possible ;)
> b) Program defensively

Thanks for the reply Alan,

That probably is the best idea, rather than rely upon the code to do the 
right thing in all places.  That being said, I think the following code 
needs to be added to ide_end_drive_cmd(), since ide_error() calls 
ide_end_drive_cmd() after ide_dump_status() has left the registers 
pointing at the high order part of the LBA.  Using the taskfile ioctl 
will then lead to hobRegister[] and subsequently hob_ports[] being 
loaded with the wrong values.

BR


2.6============================================
--- linux-2.6.8-rc3/drivers/ide/ide-io.c        Tue Aug  3 17:28:20 2004
+++ linux/drivers/ide/ide-io.c  Thu Aug  5 16:28:38 2004
@@ -197,6 +197,8 @@
                                 args->hobRegister[IDE_DATA_OFFSET] 
  = (data >> 8) & 0xFF;
                         }
                         args->tfRegister[IDE_ERROR_OFFSET]   = err;
+                       /* Be sure we're looking at the low order bits */
+                       hwif->OUTB(drive->ctl & ~0x80,IDE_CONTROL_REG);
                         args->tfRegister[IDE_NSECTOR_OFFSET] = 
hwif->INB(IDE_NSECTOR_REG);
                         args->tfRegister[IDE_SECTOR_OFFSET]  = 
hwif->INB(IDE_SECTOR_REG);
                         args->tfRegister[IDE_LCYL_OFFSET]    = 
hwif->INB(IDE_LCYL_REG);


2.4============================================
--- linux-2.4.27-rc5/drivers/ide/ide-io.c       Fri Nov 28 13:26:20 2003
+++ linux/drivers/ide/ide-io.c  Thu Aug  5 16:33:15 2004
@@ -165,6 +165,9 @@
 
args->hobRegister[IDE_DATA_OFFSET_HOB] = (data >> 8) & 0xFF;
                                 }
                                 args->tfRegister[IDE_ERROR_OFFSET]   = err;
+                               /* Be sure we're looking at the low 
order bits
+                                */
+                               hwif->OUTB(drive->ctl & 
~0x80,IDE_CONTROL_REG);
                                 args->tfRegister[IDE_NSECTOR_OFFSET] = 
hwif->INB(IDE_NSECTOR_REG);
                                 args->tfRegister[IDE_SECTOR_OFFSET]  = 
hwif->INB(IDE_SECTOR_REG);
                                 args->tfRegister[IDE_LCYL_OFFSET]    = 
hwif->INB(IDE_LCYL_REG);
