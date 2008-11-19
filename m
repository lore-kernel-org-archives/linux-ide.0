From: Tejun Heo <tj@kernel.org>
Subject: Re: FYI: BUG in SATA Promise 300 TX4 (2.6.24 - 2.6.27-3) w/Linux
Date: Wed, 19 Nov 2008 10:55:00 +0900
Message-ID: <492371F4.7020400@kernel.org>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org> <18719.65298.689618.835202@harpo.it.uu.se> <492059B1.4030708@how.dk> <49205AD7.3080009@how.dk> <4920D093.2030508@kernel.org> <492159E0.1050804@how.dk> <4922165E.9070203@kernel.org> <49230361.2010001@how.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010803010005060201010900"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39709 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbYKSBzS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Nov 2008 20:55:18 -0500
In-Reply-To: <49230361.2010001@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010803010005060201010900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Peter Favrholdt wrote:
> Hi Tejun & list
> 
> Tejun Heo wrote:
>> Peter Favrholdt wrote:
>>> I tried removing sata_promise the nice way using modprobe:
>>>
>>> # modprobe -r -f sata_promise
>>> FATAL: Module sata_promise is in use.
>>>
>>> then the not-so-nice way using rmmod -f and inserting it again. It
>>> doesn't work. Here are the relevant parts from dmesg (removing and
>>> inserting):
>>
>> Oh... you first need to wait for the kernel to be done with the devices.
>>  ie. unmount all filesystems living on those && wait till EH finishes.
> 
> I didn't have any filesystems mounted but learned that the 4 disks
> participate in a md raid5 set. To be sure I tried everything again from
> the beginning (reboot) without enabling md on the four drives. Here are
> the results:
> 
> 1. started the four dd processes which ran to completion without any
> errors. Started them again and this time sda failed as usual.
> 
> 2. modprobe -r sata_promise - no warnings/errors: removed successfully
> 
> 3. modprobe sata_promise - only three drives show up
> 
> 4. modprobe -r sata_promise - no warnings/errors: removed successfully
> 
> 5. modprobe sata_promise - more channels complain - no drives are found
> 
> dmesg:
> 
> [21626.490086] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000
> action 0x6 frozen
> [21626.490096] ata1: SError: { 10B8B Dispar BadCRC TrStaTrns }
> [21626.490105] ata1.00: cmd 25/00:00:00:1f:e6/00:02:01:00:00/e0 tag 0
> dma 262144 in
> [21626.490107]          res 40/00:28:00:00:00/00:00:00:00:00/40 Emask
> 0x4 (timeout)
> [21626.490110] ata1.00: status: { DRDY }
> [21626.490162] ata1: hard resetting link
> [21631.881055] ata1: link is slow to respond, please be patient (ready=-19)
> [21636.500030] ata1: COMRESET failed (errno=-16)
> [21636.500068] ata1: hard resetting link

COMRESETs are failing with EBUSY while ata_sff_check_ready() is
returning ENODEV.  Hmmm... Does the attached patch change anything?

-- 
tejun

--------------010803010005060201010900
Content-Type: text/x-patch;
 name="sata_promise-hrst-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_promise-hrst-debug.patch"

diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index ba9a257..a06af2c 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -709,8 +709,13 @@ static int pdc_pata_softreset(struct ata_link *link, unsigned int *class,
 static int pdc_sata_hardreset(struct ata_link *link, unsigned int *class,
 			      unsigned long deadline)
 {
+	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+	bool online;
+	int rc;
+
 	pdc_reset_port(link->ap);
-	return sata_sff_hardreset(link, class, deadline);
+	rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
+	return online ? -EAGAIN : rc;
 }
 
 static void pdc_error_handler(struct ata_port *ap)

--------------010803010005060201010900--
