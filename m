From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Sr2760-2s-s2 & Sil4723 & pmp
Date: Tue, 15 Dec 2009 19:15:15 -0600
Message-ID: <4B2834A3.5030701@gmail.com>
References: <20091207114417.GB1863@voyageur.mas.nom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:40139 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbZLPBPT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Dec 2009 20:15:19 -0500
Received: by yxe17 with SMTP id 17so484583yxe.33
        for <linux-ide@vger.kernel.org>; Tue, 15 Dec 2009 17:15:17 -0800 (PST)
In-Reply-To: <20091207114417.GB1863@voyageur.mas.nom.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erwan MAS <erwan@mas.nom.fr>
Cc: linux-ide@vger.kernel.org

On 12/07/2009 05:44 AM, Erwan MAS wrote:
> Hello ,
>
> I tried to use sr2760-2s-s2 ( http://www.raidon.com.tw/content.php?sno=0000095&p_id=53 ) with linux !
>
> With
>    kernel 2.6.21           =>  work
>    kernel 2.6.26&  2.6.28  =>  does not work
>
> In 2.26.21 , the device is detect as sata disk , i can access to it !
>
> In 2.26.26&  2.6.28 , the sata port multiplier detect the sil4723 chipset and try to use in a port multiplier mode
> ( i suppose ) .
>
> Extract of /var/log/messages
>
> Dec  6 14:13:56 charlie kernel: [    6.765363] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> Dec  6 14:13:56 charlie kernel: [    6.768941] ata4.15: Port Multiplier 1.1, 0x1095:0x4723 r28, 3 ports, feat 0x1/0x9
> Dec  6 14:13:56 charlie kernel: [    6.768941] ata4.00: hard resetting link
> Dec  6 14:13:56 charlie kernel: [    7.125525] ata4.00: SATA link down (SStatus 0 SControl 0)
> Dec  6 14:13:56 charlie kernel: [    7.125525] ata4.01: hard resetting link
> Dec  6 14:13:56 charlie kernel: [    7.668637] ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> Dec  6 14:13:56 charlie kernel: [    7.668637] ata4.02: hard resetting link
> Dec  6 14:13:56 charlie kernel: [    8.036177] ata4.02: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
> Dec  6 14:13:56 charlie kernel: [    8.036177] ata4.01: unsupported device, disabling
> Dec  6 14:13:56 charlie kernel: [    8.036177] ata4.01: disabled
> Dec  6 14:13:56 charlie kernel: [    8.042941] ata4: EH complete

It looks like there's link up on ata4.02, is there no disk that gets 
detected from that? ata4.01 is the "Config  Disk" thing that shows up 
for the Silicon Image software to configure the device, I think..

>
> My systems as asus M3A motherboard .
>
> a part of output from lspci -v :
>
> 00:12.0 SATA controller: ATI Technologies Inc SB600 Non-Raid-5 SATA (prog-if 01 [AHCI 1.0])
> 	Subsystem: ASUSTeK Computer Inc. Device 8231
> 	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 22
> 	I/O ports at c000 [size=8]
> 	I/O ports at b000 [size=4]
> 	I/O ports at a000 [size=8]
> 	I/O ports at 9000 [size=4]
> 	I/O ports at 8000 [size=16]
> 	Memory at f9fff800 (32-bit, non-prefetchable) [size=1K]
> 	Capabilities: [60] Power Management version 2
> 	Kernel driver in use: ahci
> 	Kernel modules: ahci
>

