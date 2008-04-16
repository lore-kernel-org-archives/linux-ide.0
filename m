From: Mark Lord <liml@rtr.ca>
Subject: Re: sda
Date: Tue, 15 Apr 2008 20:21:45 -0400
Message-ID: <48054699.4000605@rtr.ca>
References: <dd18b0c30804021244k1d44a48hc05ea88552104a71@mail.gmail.com>	 <48016F54.5070405@gmail.com> <dd18b0c30804122117hc0cd548v6cbef5d2c0c0ce5e@mail.gmail.com> <48041E2A.9000602@gmail.com> <4804B388.5090509@rtr.ca> <48053BF4.8060809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1418 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbYDPAVr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Apr 2008 20:21:47 -0400
In-Reply-To: <48053BF4.8060809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Justin Mattock <justinmattock@gmail.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Mark Lord wrote:
>> What I did back in 2007 was, implement hot plug/unplug for ICH5,
>> done by polling the PCS bits.
>>
>> It works, and is reportedly quite reliable, even though there is still a
>> tiny theoretical loophole where the chipset could lock up.
>>
>> The glitch on ICH5, at least, is that the PCS bits work fine for 
>> detecting
>> drive insertions, but not drive removals.  To detect a drive removal,
>> one has to first toggle the enable line (1..0..1) in PCS, and then wait
>> for the PHY to try and sync up afterwards (microseconds).
> 
> Having hardreset around is helpful whether hotplugging works or not. Can 
> you please tell me more about the theoretical loophole?
..

Well, I missed out on the early part of this thread,
so I don't really know what you want to do here.

The loophole for hotplug on ICH5, at least, is that an access to
the ATA ctl register (for the SRST bit) will lock up the machine
if a device was very recently hot-removed.

So the reset path has to first check whether the device is still there,
and avoid the SRST sequence if not.  But that's slightly racey,
since the drive could, in theory, disappear between the check
and the subsequent SRST.

Not likely though.  I'm appending my original discovery notes
to the end of this posting (scroll way down).

>> The code didn't go upstream because it conflicted somewhat with the  pending
>> hotplug polling framework you had in development at the time.  :)
>>
>> What's the scoop with that now, anyways?  The sata_mv driver will eventually
>> want hotplug polling to deal with port multiplier ports -- it cannot use AN.
> 
> Heh... That was blocked on sysfs nodes and as time goes by it went down 
> through the rabbit hole.  MV can't do AN?  Have you taken a look at how 
> ahci implements AN?  It doesn't really support AN.  It just looks at 
> what FIS it received and tries to emulate the notification, which BTW 
> isn't 100% accurate as the receive area can be overwritten 
> asynchronously but it works good enough.  Maybe MV can do similar?
..

No, it really cannot do AN at all -- the AN packet gets mixed with whatever
data happens to be flowing through the chip, corrupting the transfer.
So AN has to be turned off for sata_mv, all chipsets.

Here's the original analysis from my ICH5 hot-unplug lockup discovery:

Mark wrote:
> ...
> 
> Mmmm.. with the 2.6.21.1 test kernel I'm using,
> it does hard lockup every time.
> 
> This is not a soft hang: the processor is literally halted.
> 
> It happens at the last line in this sequence below:
> 
>> From drivers/ata/libata-core.c:
>> static unsigned int ata_bus_softreset(struct ata_port *ap,
>>                                       unsigned int devmask)
>> {
>>         struct ata_ioports *ioaddr = &ap->ioaddr;
>>
>>         DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
>>
>>         /* software reset.  causes dev0 to be selected */
>>         iowrite8(ap->ctl, ioaddr->ctl_addr);
>>         udelay(20);     /* FIXME: flush */
>>         iowrite8(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
>>         udelay(20);     /* FIXME: flush */
>>         iowrite8(ap->ctl, ioaddr->ctl_addr);
> 
> That final iowrite8() quite reliably locks up the system every time
> when issued on an ATA port for an unplugged drive.
> 
> I'll continue the investigation later, looking for an alternative
> sequence for performing drive resets, hopefully discovering a combination
> that won't hard lock the hardware.
..

And that combination was eventually found:  poll the PCS register first,
and skip the reset if no device is present.  To do the poll, one needs code
to first toggle the presence detection enable, and then wait long enough
for the PHY to sync up (or not).

The quick hack I did at the time looked like this below,
and a call to it was inserted prior to the SRST sequence:

+/*
+ * Returns 0 if a device appears to be present; 1 otherwise
+ */
+static int ich_port_offline (struct ata_port *ap)
+{
+	struct pci_dev *pdev;
+	u16 pcs, port_bit = (1 << ap->hard_port_no);
+	struct piix_port_priv *pp = ap->private_data;
+	u8 ostatus;
+	unsigned int offline;
+
+	if (!pp || !pp->pcs_hotplug_supported) {
+		u32 sstatus;
+		if (!sata_scr_read(ap, SCR_STATUS, &sstatus) && (sstatus & 0xf) != 0x3)
+			return 1;
+		return 0;
+	}
+
+	/*
+	 * ICH5 with a mostly good/working PCS register.
+	 * The only flaw is, it doesn't seem to detect *removed* drives
+	 * unless we toggle the enable line before checking.
+	 */
+	ostatus = ata_altstatus(ap);
+	pdev = to_pci_dev(ap->dev);
+	pci_read_config_word(pdev, ICH5_PCS, &pcs);
+	offline = ((pcs & (port_bit << 4)) == 0);
+
+	if (!offline) {
+		unsigned int usecs;
+
+		/* Cycle PCS register to force it to redetect devices: */
+		pci_write_config_word(pdev, ICH5_PCS, pcs & ~port_bit);
+		udelay(1);
+		pci_write_config_word(pdev, ICH5_PCS, 0x0003);
+
+		/* Wait for SATA PHY to sync up; typically 5->6 usecs */
+		for (usecs = 0; usecs < 100; ++usecs) {
+			pci_read_config_word(pdev,  ICH5_PCS, &pcs);
+			offline = ((pcs & (port_bit << 4)) == 0);
+			if (!offline)
+				break;
+			udelay(1);
+		}
+		if (!offline) {
+			unsigned int msecs;
+			/* Wait for drive to become not-BUSY, typically 10->62 msecs */
+			for (msecs = 1; msecs < 150; msecs += 3) {
+				u8 status;
+				msleep(3);
+				status = ata_altstatus(ap);
+				if (status && !(status & ATA_BUSY))
+					break;
+			}
+			usecs += msecs * 1000;
+		}
+		printk("ata%u (port %u): status=%02x pcs=0x%04x offline=%u delay=%u usecs\n",
+			ap->id, ap->hard_port_no, ostatus, pcs, offline, usecs);
+	}
+	if (offline)
+		ata_port_disable(ap);
+	return offline;
+}
