From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata problem...
Date: Sat, 12 Mar 2011 20:10:51 -0600
Message-ID: <4D7C27AB.1010908@gmail.com>
References: <04BB68BD-352B-45B0-A7FC-42B6005A80B3@freemail.hu> <20110227153338.GA23527@mtj.dyndns.org> <E0ABD6B5-3B05-48D8-AFDC-9FD559AF2583@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38653 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196Ab1CMCKy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Mar 2011 21:10:54 -0500
Received: by iwn34 with SMTP id 34so3853014iwn.19
        for <linux-ide@vger.kernel.org>; Sat, 12 Mar 2011 18:10:54 -0800 (PST)
In-Reply-To: <E0ABD6B5-3B05-48D8-AFDC-9FD559AF2583@freemail.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter <elekesp@freemail.hu>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On 03/12/2011 02:33 PM, Peter wrote:
> Hi!
>
> Motherboard is
> GIGABYTE GA-D510UD

..

> [    1.782644] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.785561] ata4.00: ATA-8: WDC WD10EARS-00Y5B1, 80.00A80, max UDMA/133
> [    1.785570] ata4.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
> [    1.787834] ata4.00: configured for UDMA/133
...

> [    2.098472] ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
> [    2.098483] ata4.00: irq_stat 0x40000008
> [    2.098493] ata4.00: failed command: READ FPDMA QUEUED
> [    2.098512] ata4.00: cmd 60/20:00:bf:0c:0e/00:00:74:00:00/40 tag 0 ncq 16384 in
> [    2.098516]          res 41/40:00:c7:0c:0e/00:00:74:00:00/40 Emask 0x409 (media error)<F>
> [    2.098526] ata4.00: status: { DRDY ERR }
> [    2.098532] ata4.00: error: { UNC }
> [    2.104001] ata4.00: configured for UDMA/133
> [    2.104026] ata4: EH complete

..


> I dont know why there is "[    2.098493] ata4.00: failed command: READ FPDMA QUEUED" in dmesg.
>
> I have 3 WD Green 1TB HDD, and I samsung 160GB HDD.
> 1 SAMSUNG and 1 WD on the intel SATA,
> 2 WD on the GIGABYTE Sata.
> I think the problem is only with the gigabye sata port.

That's an uncorrectable read error the drive is reporting. Most likely 
that hard drive is failing.
