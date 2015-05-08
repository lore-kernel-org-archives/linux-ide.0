From: Jonathan Bagg <jbagg@lenbrook.com>
Subject: Re: imx6 sata cdrom driver issue
Date: Fri, 8 May 2015 15:45:56 -0400
Message-ID: <554D1274.70804@lenbrook.com>
References: <5539101D.1020909@lenbrook.com> <3757889.IHh7sEV0GH@wuerfel> <5547DEA7.8080009@lenbrook.com> <2901871.Bfl6KrJo7t@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------080607020405050002090204"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lenbrook.com ([206.191.95.214]:10185 "EHLO
	mail.lenbrook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbbEHTp6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 May 2015 15:45:58 -0400
In-Reply-To: <2901871.Bfl6KrJo7t@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: linux-ide@vger.kernel.org

--------------080607020405050002090204
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

On 15-05-05 06:48 AM, Arnd Bergmann wrote:
> On Monday 04 May 2015 17:03:35 Jonathan Bagg wrote:
>> On 15-05-04 02:37 PM, Arnd Bergmann wrote:
>>> On Friday 01 May 2015 11:32:49 Jonathan Bagg wrote:
>>>> On 15-04-24 03:58 AM, Arnd Bergmann wrote:
>>>>> On Thursday 23 April 2015 11:30:37 Jonathan Bagg wrote:
>>>>>
>>>>> Do you have two SATA ports on one controller, with the other one being
>>>>> conneced to a disk drive?
>>>> Not when this error happened, but the CD-ROM was connected through a
>>>> port multiplier.  One time I noticed sda device appear so I mounted it
>>>> and it was the CD-ROM filesystem!
>>> Very strange, I'm sure something went wrong there and either the SATA
>>> host or the CDROM driver does not work well with a port multiplier.
>>>
>>> Is there a way for you to reproduce the problem without the multiplier?
>>>
>>>>> My best guess is that something in the error handling of
>>>>> drivers/ata/ahci_imx.c causes a reset of the entire bus and that
>>>>> triggers the other bugs. Can you instrument that error handling to
>>>>> see what's going on?
>>>>>
>>>> Also tried a cubox
>>>> <https://www.solid-run.com/products/cubox-i-mini-computer/>, (imx6)
>>>> running  Linux OpenELEC 3.14.18 #1 SMP Sun Sep 14 12:22:14 EDT 2014
>>>> armv7l GNU/Linux
>>> Can you find out if there is a port multiplier in that machine?
>> I've tried with and without a multiplier.  I have a port multiplier on a
>> development board that I can connect between the CDROM and Sabre SATA
>> port or connect the CDROM directly to the Sabre SATA port .
>>> Does it list the sda device in /proc/partitions, or just the /dev/sr0?
>> sda is only listed in /proc/partitions if I connect up a HDD.  The issue
>> where the CDROM filesystem mounting as sda1 has never reproduced.
>>
>> I've also discovered, and it is 100% reproducible, that with the HDD and
>> CDROM connected using the port multiplier, the kernel never lists the
>> partition on the HDD.  If I connect the HDD directly to the Sabre or
>> connect the HDD to the Sabre using the multiplier without the CDROM,
>> /dev/sda1 will exist.
> Ok, interesting. Does the same happen if you connect that port
> multiplier to a PC?
I don't think the host sata port on the PC I tried supported 
multipliers.  I tried the port multiplier on a imx53 Quick Start Board 
and it worked fine.  We've also discovered that cdparanoia (audio CD 
ripper) fails to recognize the CDROM drive 100% of the time on imx6 with 
or without the port multiplier.  On the imx53 Quick Start Board, running 
the same kernel, just a different device tree, cdparanoia works great 
with and without the port multiplier. If you apply the attached patch to 
enable sata debug output, the imx6 output is different than the imx53's....

cdparanoia -vsQ
dmesg | grep CDB

imx53

ata_scsi_dump_cdb: CDB (1:0,0,-571258880) 00 00 4a 01 00 00 10 00 00
CDB rbuf: [4a 01 00 00 10 00 00 00 08]
CDB rbuf: 00000000: 00 06 04 56 00 02 00 00

imx6 - third line is always zeros

ata_scsi_dump_cdb: CDB (1:0,0,-1122908160) 00 00 4a 01 00 00 10 00 00
CDB rbuf: [4a 01 00 00 10 00 00 00 08]
CDB rbuf: 00000000: 00 00 00 00 00 00 00 00

We also tried kernel versions 3.12, 3.14, 3.19 and most recent 4.x, all 
are effected.  imx6 sata support didn't exists in 3.10, so we couldn't 
go further back.

https://community.freescale.com/message/514169#514169



-- 
Jonathan Bagg
Embedded Systems Developer
NAD Electronics | Lenbrook Industries Limited
633 Granite Court, Pickering, Ontario, Canada L1W 3K1 | 905-831-0799 ext 4478 | http://www.nadelectronics.com


--------------080607020405050002090204
Content-Type: text/x-patch; name="ata_debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ata_debug.patch"

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 6abd17a..cb3a705 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2712,6 +2712,26 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 		}
 
 		cmd->result = SAM_STAT_GOOD;
+
+		if(1)
+		{
+			unsigned long flags;
+			u8 *buf, *scsicmd;
+			int len;
+
+			buf = ata_scsi_rbuf_get(cmd, true, &flags);
+			len = scsi_bufflen(cmd);
+			scsicmd = cmd->cmnd;
+
+			printk(KERN_INFO "CDB rbuf: [%02x %02x %02x %02x %02x %02x %02x %02x %02x]\n",
+				scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
+				scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
+				scsicmd[8]);
+
+			print_hex_dump(KERN_INFO, "CDB rbuf: ", DUMP_PREFIX_OFFSET, 16, 1, buf, len, true);
+
+			ata_scsi_rbuf_put(cmd, true, &flags);
+		}
 	}
 
 	qc->scsidone(cmd);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 91f705d..4373982 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -53,8 +53,8 @@
  * compile-time options: to be removed as soon as all the drivers are
  * converted to the new debugging mechanism
  */
-#undef ATA_DEBUG		/* debugging output */
-#undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
+#define ATA_DEBUG		/* debugging output */
+#define ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
 

--------------080607020405050002090204--
