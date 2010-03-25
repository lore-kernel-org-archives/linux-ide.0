From: David Milburn <dmilburn@redhat.com>
Subject: Re: ata2.00: failed to set xfermode (err_mask=0x100),ata2.00: disabled, CD-ROM drive dead
Date: Thu, 25 Mar 2010 16:52:42 -0500
Message-ID: <20100325215242.GA9785@localhost.localdomain>
References: <4B9EA02F.2070704@hardwarefreak.com> <4B9EC67A.3020201@gmail.com> <4B9ED027.30800@hardwarefreak.com> <4BAAB080.3010401@kernel.org> <4BAB2A94.8010001@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39282 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753364Ab0CYWA0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Mar 2010 18:00:26 -0400
Content-Disposition: inline
In-Reply-To: <4BAB2A94.8010001@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stan Hoeppner <stan@hardwarefreak.com>
Cc: linux-ide@vger.kernel.org

On Thu, Mar 25, 2010 at 04:19:16AM -0500, Stan Hoeppner wrote:
> Tejun Heo put forth on 3/24/2010 7:38 PM:
> > Hello,
> > 
> > On 03/16/2010 09:26 AM, Stan Hoeppner wrote:
> >> ata2.00: ATAPI: Pioneer CD-ROM ATAPI Model DR-A24X  0102, E1.02, max MWDMA2
> >> ata2.00: failed to set xfermode (err_mask=0x100)
> >> TCP cubic registered
> >> NET: Registered protocol family 17
> >> Using IPI Shortcut mode
> >> rtc_cmos rtc_cmos: setting system clock to 2010-03-10 20:53:54 UTC (1268254434)
> >> ata2.00: failed to set xfermode (err_mask=0x100)
> >> ata2.00: limiting speed to MWDMA2:PIO3
> >> ata2.00: failed to set xfermode (err_mask=0x100)
> > 
> > AC_ERR_OTHER on SETXFER, that's rare.  Maybe the drive needs
> > ATA_HORKAGE_NOSETXFER?  Can you please post boot log with ide driver?
> 
> Hello Tejun,
> 
> Here is the relevant dmesg output for my kernel with the PIIX IDE driver:
> 
> Linux version 2.6.32.9 (root@greer) (gcc version 4.3.2 (Debian 4.3.2-1.1) )
> #1 SMP Wed Mar 17 20:21:58 CDT 2010
> ...
> Uniform Multi-Platform E-IDE driver
> piix 0000:00:07.1: IDE controller (0x8086:0x7111 rev 0x01)
> piix 0000:00:07.1: IDE port disabled
> piix 0000:00:07.1: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf008-0xf00f
> Probing IDE interface ide0...
> hda: Pioneer CD-ROM ATAPI Model DR-A24X 0102, ATAPI CD/DVD-ROM drive
> hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> hda: MWDMA2 mode selected
> ide0 at 0x170-0x177,0x376 on irq 15
> ide-cd driver 5.00
> ide-cd: hda: ATAPI 20X CD-ROM drive, 128kB Cache
> Uniform CD-ROM driver Revision: 3.20
> 
> I must admit the CD-ROM drive is rather old, a late 90's model slot loading
> Pioneer drive, but it works fine with the PIIX IDE driver.  If it is needed
> for success under libata, where would I set ATA_HORKAGE_NOSETXFER?

Hello,

If you are going to try to skip SETXFER, I think you will need an entry in
ata_device_blacklist, something like this.

 drivers/ata/libata-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4a28420..8dfcf85 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4388,6 +4388,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 * device and controller are SATA.
 	 */
 	{ "PIONEER DVD-RW  DVRTD08",	"1.00",	ATA_HORKAGE_NOSETXFER },
+	{ "Pioneer CD-ROM ATAPI Model DR-A24X  0102", "E1.02", ATA_HORKAGE_NOSETXFER },
 
 	/* End Marker */
 	{ }





