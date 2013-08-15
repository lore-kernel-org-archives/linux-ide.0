From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: System fails to connect to iHOS-104 DVD drive with nvidia MCP61 chipset.
Date: Wed, 14 Aug 2013 23:36:28 -0600
Message-ID: <CADLC3L1uR=+mSj5MtgK9hKPjz-wOaVsw3W6woALq6SX4vO6wJQ@mail.gmail.com>
References: <520AB4D8.1000208@1045.ca>
	<520B210B.5040700@gmail.com>
	<520C01E8.9040302@1045.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:43605 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab3HOFg3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Aug 2013 01:36:29 -0400
Received: by mail-qc0-f170.google.com with SMTP id i8so204378qcq.29
        for <linux-ide@vger.kernel.org>; Wed, 14 Aug 2013 22:36:29 -0700 (PDT)
In-Reply-To: <520C01E8.9040302@1045.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Link <Bruce@1045.ca>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, 1063474@bugs.launchpad.net

On Wed, Aug 14, 2013 at 4:17 PM, Bruce Link <Bruce@1045.ca> wrote:
>> These NVIDIA SATA controllers are a pain as they all seem to have a
>> different set of bugs related to hardreset, etc. What happens if you boot up
>> without the drive connected and then plug in the cable after the system
>> boots up?
>
> Roughly the same error is returned. See below for the dmesg output.
>
> root@teevee:/sys/devices/pci0000:00/0000:00:06.0/ata1/host0/scsi_host/host0#
> echo "- - -" > /sys/class/scsi_host/host4/scan
> root@teevee:/sys/devices/pci0000:00/0000:00:06.0/ata1/host0/scsi_host/host0#
> dmesg|grep ata5
> [    1.030224] ata5: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0xc400 irq
> 20
> [    1.354216] ata5: SATA link down (SStatus 0 SControl 300)
> [  944.773288] ata5: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xf
> [  944.773304] ata5: SError: { PHYRdyChg CommWake }
> [  944.773322] ata5: hard resetting link
> [  945.652070] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  945.660176] ata5.00: ATAPI: ATAPI   iHOS104, WL0F, max UDMA/100
> [  945.676165] ata5.00: configured for UDMA/100
> [  950.676049] ata5.00: qc timeout (cmd 0xa0)
> [  950.676056] ata5.00: TEST_UNIT_READY failed (err_mask=0x5)
> [  950.676064] ata5: hard resetting link
> [  950.676066] ata5: nv: skipping hardreset on occupied port
> [  951.144073] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  951.168168] ata5.00: configured for UDMA/100
> [  956.168049] ata5.00: qc timeout (cmd 0xa0)
> [  956.168057] ata5.00: TEST_UNIT_READY failed (err_mask=0x4)
> [  956.168061] ata5: limiting SATA link speed to 1.5 Gbps
> [  956.168064] ata5.00: limiting speed to UDMA/100:PIO3
> [  956.168070] ata5: hard resetting link
> [  956.168072] ata5: nv: skipping hardreset on occupied port
> [  956.636056] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  956.660169] ata5.00: configured for UDMA/100
> [  961.660036] ata5.00: qc timeout (cmd 0xa0)
> [  961.660044] ata5.00: TEST_UNIT_READY failed (err_mask=0x4)
> [  961.660046] ata5.00: disabled
> [  961.660061] ata5: hard resetting link
> [  962.544045] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [  962.544061] ata5: EH complete
> root@teevee:/sys/devices/pci0000:00/0000:00:06.0/ata1/host0/scsi_host/host0#
>

Hmm, it did a hard reset on the hotplug with seemingly the same
effect. Can we narrow down the problem any more: does this drive work
on this machine under any Linux version, or in Windows? Can you try it
in another Linux machine with a different controller to see if it
works there?
