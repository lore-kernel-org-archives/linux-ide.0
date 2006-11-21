From: =?ISO-8859-1?Q?Daniel_Schr=F6der?= <mail@dschroeder.info>
Subject: Re: [PMP] sil3132 st6600 problem
Date: Tue, 21 Nov 2006 09:59:47 +0100
Message-ID: <4562C003.8060208@dschroeder.info>
References: <45552660.4050902@dschroeder.info> <456295E7.9080909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:18422 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030741AbWKUJAH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 04:00:07 -0500
In-Reply-To: <456295E7.9080909@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> USB messages seem to be power supply related..  If you have another
> power supply available, try to use it for disks (using power supply w/o
> motherboard isn't difficult. just ask google) or buy a better one.
> 
> When PMP detection fails, did you have the first PMP port occupied?
> Sil3726/4726 PMPs fail to initialize if the first port isn't occupied.
> Dunno if it's those hardware's fault or driver's fault yet.
> 

Powersupply is 530W for one CPU, three internal SATA drives and one
7900GT. I think this should not be an issue.
The USB messages do not seem to be related with the eSATA thing. I have
tested the device for the last time and the USB messages were not there.
This time the "first" port was occupied. Finally, i guess, this device
ST6600 by Stardom/Raidsonic has some "teething problems" and i will send
this device back to the seller.

(If someone has trouble with this device also. The "symptoms":

- Only the first blue led, power on, is active.
- The "drive ready leds" are off even though ports are occupied.
- In the back of the device are several leds. A blue, a red and a green
one are active. May be, there could be a meaning in this.

- If you boot Windows XP with this device connected or you plug in the
device while Windows XP is running. XP instantly freezes and dies.
- Under Linux, the output is the following and unlike to XP the system
stays stable.)


Thank you, for your ideas..

Daniel

<power on/off/on>
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x42 frozen
ata1: (irq_stat 0x00b00090, PHY RDY changed)
ata1: waiting for device to spin up (8 secs)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.15: failed to read PMP GSCR[0] (errno=-16)
ata1: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.15: failed to read PMP GSCR[0] (errno=-16)
ata1: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.15: failed to read PMP GSCR[0] (errno=-16)
ata1: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: EH complete
ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0x42 frozen
ata1: (irq_stat 0x01900090, PHY RDY changed)
ata1: soft resetting port
ata1: SATA link down (SStatus 1 SControl 300)
ata1: EH complete
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x42 frozen
ata1: (irq_stat 0x00b00090, PHY RDY changed)
ata1: waiting for device to spin up (8 secs)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.15: failed to read PMP GSCR[0] (errno=-16)
ata1: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.15: failed to read PMP GSCR[0] (errno=-16)
ata1: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.15: failed to read PMP GSCR[0] (errno=-16)
ata1: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: EH complete
</power on/off/on>
