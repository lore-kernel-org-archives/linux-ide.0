From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 19:54:47 -0400
Message-ID: <446914C7.1030702@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:4052 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750831AbWEOXyu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 19:54:50 -0400
In-Reply-To: <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Avuton Olrich <avuton@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

Avuton Olrich wrote:
> On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
>> * sata_sil and ata_piix also need healthy re-testing of all basic
>> functionality.
> 
> I'm testing it right now, but with 2.6.17-rc4-git2 I was getting:

Testing what?  sata_sil?  Please provide full dmesg, there's a lot of 
missing information.


> May 15 15:42:57 shapeshifter ata2: command 0x25 timeout, stat 0x58 
> host_stat 0x1
> May 15 15:42:57 shapeshifter ata2: translated ATA stat/err 0x58/00 to
> SCSI SK/ASC/ASCQ 0xb/47/00
> May 15 15:42:57 shapeshifter ata2: status=0x58 { DriveReady
> SeekComplete DataRequest }
> May 15 15:42:57 shapeshifter sd 1:0:0:0: SCSI error: return code = 
> 0x8000002
> May 15 15:42:57 shapeshifter sda: Current: sense key=0xb
> May 15 15:42:57 shapeshifter ASC=0x47 ASCQ=0x0
> May 15 15:42:57 shapeshifter end_request: I/O error, dev sda, sector 
> 974708575
> 
> (sector varies)
> 
> After large ssh transfers. I moved to 2.6.17-rc4-git2 because
> 2.6.16.16 was doing the same. This is a new 500gb sata2 drive on
> sata_sil so I guess this could be hardware, but I wanted to make sure
> before I go returning this thing. After this obviously I have to sysrq
> sync, ro and reboot. This also causes(?) a NETDEV WATCHDOG: eth2:
> transmit timed out, sometimes this ata timeout doesn't yet occur and I
> just get the netdev watchdog. This has not yet happened with the new
> patch, though I'm only 1 hr into testing with it.

Yes, its entirely possible that the new patch will address this.  Please 
do keep us posted.

Thanks,

	Jeff



