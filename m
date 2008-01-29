From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 17:48:43 +0100
Message-ID: <18335.22763.625990.528217@alkaid.it.uu.se>
References: <200801272122.21823.gene.heskett@gmail.com>
	<200801290951.55492.gene.heskett@gmail.com>
	<20080129154752.3d7758f1@core>
	<200801291132.41657.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1766006AbYA2Qtg@vger.kernel.org>
In-Reply-To: <200801291132.41657.gene.heskett@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Richard Heck <rgheck@bobjweil.com>, Daniel Barkalow <barkalow@iabervon.org>, Zan Lynx <zlynx@acm.org>, Calvin Walton <calvin.walton@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Gene Heskett writes:
 > On Tuesday 29 January 2008, Alan Cox wrote:
 > >> As slight change here, I was going to use the same .config as 2.6.24-rc8,
 > >> but just discovered that neither rc8 nor final is finding the drivers for
 > >> my
 > >
 > >If it is not finding a driver that is nothing to do with libata. It means
 > >it's not being loaded by the distribution, or the distribution kernel is
 > >too old (2.6.22) for the hardware - in which case see the Fedora respins
 > >which are on 2.6.23.something right now.
 > >
 > >Alan
 > 
 > Home built kernel Alan.  But you are as good as anyone to tell me what I 
 > need to turn on in order for this dvdwriter to be enabled:
 > [   28.862478] ata2.00: ATAPI: LITE-ON DVDRW SHM-165H6S, HS06, max UDMA/66
 > ....
 > [   28.908647] ata2.00: limited to UDMA/33 due to 40-wire cable
 > [   29.081253] ata2.00: configured for UDMA/33
 > ....
 > it has had several 80 wire cables tried, hasn't fixed this, and does not
 > seem to effect its operation when it does work.
 > ....
 > [   29.132405] scsi 1:0:0:0: CD-ROM            LITE-ON  DVDRW SHM-165H6S HS06 PQ: 0 ANSI: 5
 > ....
 > [   43.450795] scsi 1:0:0:0: Attached scsi generic sg1 type 5
 > -------
 > No further mention of it in dmesg, and k3b cannot find the drive at any 
 > /dev/sgX address.
 > 
 > .config attached, what else do I need to turn on?

...

 > # CONFIG_BLK_DEV_SR is not set

For starters, enable CONFIG_BLK_DEV_SR.
