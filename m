From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: System fails to connect to iHOS-104 DVD drive with nvidia MCP61
 chipset.
Date: Wed, 14 Aug 2013 00:17:47 -0600
Message-ID: <520B210B.5040700@gmail.com>
References: <520AB4D8.1000208@1045.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:45708 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab3HNGRu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Aug 2013 02:17:50 -0400
Received: by mail-ie0-f176.google.com with SMTP id 9so11939736iec.21
        for <linux-ide@vger.kernel.org>; Tue, 13 Aug 2013 23:17:49 -0700 (PDT)
In-Reply-To: <520AB4D8.1000208@1045.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Link <Bruce@1045.ca>
Cc: linux-ide@vger.kernel.org, 1063474@bugs.launchpad.net

On 08/13/2013 04:36 PM, Bruce Link wrote:
> On bootup, when trying to attach to a Lite-on iHOS-104 DVD drive, the
> kernel attempts to establish a connection to the CD drive at a variety
> of speeds. Ultimately it fails with a "TEST_UNIT_READY failed
> (err_mask=0x4)" message
>
> ****************************************************************
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1063474
>
> ****************************************************************
> The relevant DMESG output is listed below:
> watchtv@teevee:~$ dmesg|grep ata5
> [    1.088342] ata5: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0xc400
> irq 23
> [    1.556031] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.564134] ata5.00: ATAPI: ATAPI   iHOS104, WL0F, max UDMA/100
> [    1.580115] ata5.00: configured for UDMA/100
> [    6.580029] ata5.00: qc timeout (cmd 0xa0)
> [    6.580036] ata5.00: TEST_UNIT_READY failed (err_mask=0x4)
> [    7.048044] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    7.072129] ata5.00: configured for UDMA/100
> [   29.856040] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> frozen
> [   29.856063] ata5.00: cmd a0/01:00:00:60:00/00:00:00:00:00/a0 tag 0
> dma 96 in
> [   29.856065] ata5.00: status: { DRDY }
> [   29.856071] ata5: hard resetting link
> [   29.856073] ata5: nv: skipping hardreset on occupied port
> [   30.324070] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   30.348152] ata5.00: configured for UDMA/100
> [   35.348125] ata5.00: qc timeout (cmd 0xa0)
> [   35.348132] ata5.00: TEST_UNIT_READY failed (err_mask=0x4)
> [   35.348139] ata5: hard resetting link
> [   35.348141] ata5: nv: skipping hardreset on occupied port
> [   35.816115] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   35.840125] ata5.00: configured for UDMA/100
> [   36.835824] ata5: EH complete
> [   67.840151] ata5: limiting SATA link speed to 1.5 Gbps
> [   67.840159] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> frozen
> [   67.840178] ata5.00: cmd a0/01:00:00:80:00/00:00:00:00:00/a0 tag 0
> dma 16512 in
> [   67.840181] ata5.00: status: { DRDY }
> [   67.840187] ata5: hard resetting link
> [   67.840188] ata5: nv: skipping hardreset on occupied port
> [   68.308056] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   68.332176] ata5.00: configured for UDMA/100
> [   68.343497] ata5: EH complete
> [   75.808054] ata5.00: limiting speed to UDMA/66:PIO4
> [   75.808061] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> frozen
> [   75.808081] ata5.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0
> dma 16416 in
> [   75.808084] ata5.00: status: { DRDY }
> [   75.808089] ata5: hard resetting link
> [   75.808091] ata5: nv: skipping hardreset on occupied port
> [   76.276050] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   76.300125] ata5.00: configured for UDMA/66
> [   76.307490] ata5: EH complete
> [  136.868049] ata5.00: limiting speed to UDMA/33:PIO4
> [  136.868058] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> frozen
> [  136.868078] ata5.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0
> dma 16416 in
> [  136.868081] ata5.00: status: { DRDY }
> [  136.868087] ata5: hard resetting link
> [  136.868089] ata5: nv: skipping hardreset on occupied port
> [  137.332073] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  137.356170] ata5.00: configured for UDMA/33
> [  137.866272] ata5: EH complete

These NVIDIA SATA controllers are a pain as they all seem to have a 
different set of bugs related to hardreset, etc. What happens if you 
boot up without the drive connected and then plug in the cable after the 
system boots up?
