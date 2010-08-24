From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci port hangs while hard resetting link
Date: Tue, 24 Aug 2010 18:27:15 +0200
Message-ID: <4C73F2E3.6030909@kernel.org>
References: <201008230010.48355.anssi.hannula@iki.fi> <4C723FF4.1020208@kernel.org> <201008231811.59828.anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39685 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531Ab0HXQcZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Aug 2010 12:32:25 -0400
In-Reply-To: <201008231811.59828.anssi.hannula@iki.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: linux-ide@vger.kernel.org

On 08/23/2010 05:11 PM, Anssi Hannula wrote:
> On Monday 23 August 2010 12:31:32 Tejun Heo wrote:
>> Hello,
>>
>> On 08/22/2010 11:10 PM, Anssi Hannula wrote:
>>> 22:52:18 : ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0xe
>>> frozen
>>> 22:52:18 : ata6: irq_stat 0x00400040, connection status changed
>>> 22:52:18 : ata6: SError: { RecovComm PHYRdyChg CommWake DevExch }
>>> 22:52:18 : ata6: hard resetting link
>>> 22:52:28 : ata6: softreset failed (device not ready)
>>> 22:52:28 : ata6: hard resetting link
>>> 22:52:38 : ata6: softreset failed (device not ready)
>>> 22:52:38 : ata6: hard resetting link
>>> 22:52:49 : ata6: link is slow to respond, please be patient (ready=0)
>>> 22:53:13 : ata6: softreset failed (device not ready)
>>> 22:53:13 : ata6: limiting SATA link speed to 1.5 Gbps
>>> 22:53:13 : ata6: hard resetting link
>>> =====================
>>> I disconnect the drive for a few moments, but nothing is output by
>>> kernel. I reconnect it again, but again, nothing is output by the
>>> kernel. I run: echo "- - -" >
>>> /sys/devices/pci0000:00/0000:00:1f.2/host5/scsi_host/host5/scan
>>> However, it appeared stuck and still no messages in the kernel log, so
>>> I disconnected the device again. Still nothing is output, and the
>>> following messages started to be output, indicating that the process
>>
>>> had become stuck:
>> Looks like EH got stuck somehow.  Maybe the timeout calculation is
>> wrong?  Can you please trigger sysrq-t while the system is stuck and
>> post the result?
> 
> Ok, here's the output. And the system is not stuck, just the bash process that 
> is writing to 'scan' file.
> 
> In this occasion, the hard reset had been stuck for some 16 hours, and it is 
> on ata5 (scsi4):

Does the following patch fix the problem?

Thanks.

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 666850d..68dc678 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1326,7 +1326,7 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	/* issue the first D2H Register FIS */
 	msecs = 0;
 	now = jiffies;
-	if (time_after(now, deadline))
+	if (time_after(deadline, now))
 		msecs = jiffies_to_msecs(deadline - now);

 	tf.ctl |= ATA_SRST;

