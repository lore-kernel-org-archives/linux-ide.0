From: Ignacy Gawedzki <lkml@qult.net>
Subject: Re: Hot (un)plugging of a SATA drive with sata_nv (CK8S)?
Date: Mon, 4 Feb 2008 05:41:34 +0100
Message-ID: <20080204044134.GA19900@zenon.in.qult.net>
References: <fa.PdKzY9gi8w+fleyC/mVql2UDhtc@ifi.uio.no> <479AA2E6.8070307@shaw.ca> <20080128111953.GA833@zenon.in.qult.net> <479E66DE.3050705@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756048AbYBDEnD@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <479E66DE.3050705@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Jan 28, 2008 at 05:35:58PM -0600, thus spake Robert Hancock:
> Any ideas guys? When the drive is plugged in, a stream of this shows up. It 
> would seem like the controller is throwing hotplug interrupts but we never 
> seem to get a "SATA link up". This is on nForce3, btw.

I just happened to upgrade to kernel 2.6.24 and the problem is gone.  I just
have a few SError messages that appear to be harmless:

  ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xa frozen
  ata2: SError: { PHYRdyChg CommWake }
  ata2: hard resetting link
  ata2: SATA link down (SStatus 0 SControl 300)
  ata2: EH complete
  ata2: exception Emask 0x10 SAct 0x0 SErr 0x1d0000 action 0xa frozen
  ata2: SError: { PHYRdyChg CommWake 10B8B Dispar }
  ata2: hard resetting link
  ata2: port is slow to respond, please be patient (Status 0x80)
  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  ata2.00: ATA-8: ST3500320AS, SD15, max UDMA/133
  ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
  ata2.00: configured for UDMA/133
  ata2: EH complete
  
and then the usual SCSI messages about the newly seen drive.  The scsiadd -r
command works every time and does stop the disk indeed :

  sd 1:0:0:0: [sdb] Synchronizing SCSI cache
  sd 1:0:0:0: [sdb] Stopping disk
  ata2.00: disabled

and then when I switch the drive off :

  ata2: exception Emask 0x10 SAct 0x0 SErr 0x1990000 action 0xa frozen
  ata2: SError: { PHYRdyChg 10B8B Dispar LinkSeq TrStaTrns }
  ata2: hard resetting link
  ata2: SATA link down (SStatus 0 SControl 300)
  ata2: EH complete

So thanks for the help and sorry for the bother. =)

-- 
Everything is more fun naked except cooking with grease.
