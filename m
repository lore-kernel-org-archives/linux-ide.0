Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAA2C38142
	for <linux-ide@archiver.kernel.org>; Wed, 25 Jan 2023 01:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjAYB0m (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 24 Jan 2023 20:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjAYB0l (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2023 20:26:41 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37BA47EF2
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2023 17:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674609998; x=1706145998;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tQjjtcPg0nZWYhmB/6jG70nfJyikpWEpcP+qVUie93k=;
  b=QQWe1tzT/kG95/pNYwuFmVOeF4ixpqGCW4bX6RGOn9cNf2h86Ca7z58f
   UKUSEnyYcxVqeWaiinoY02FGGenLY2fvDb9kSLAMWnu45CVa6zcDJ+VbD
   LgxXDg9kcYqcrKXh/KftAUnPUG3HVc1r1WRFA7obqvM06rAm+lu0tKeBz
   RjoIgYvXmVqJhJhQUY+aatwQkGXpS8M+4v577A+qz+ihSjR4A2zVAk3Q0
   xueA/I9q3WY+KJuu5YrUIK90MAkVJwZ3+p7bkRGl1CjWVyf5DKfvBHapJ
   7XUNCWpZhcW6Ir7/FglxClgkjGmLSyAZ7boLpWT89CefafKU9Hl3s+8hb
   A==;
X-IronPort-AV: E=Sophos;i="5.97,244,1669046400"; 
   d="scan'208";a="220012429"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2023 09:26:37 +0800
IronPort-SDR: DQoS45lqMvUS7Otv2m33GKgxSgsQ8KJ3CUrYW/PQJni6vY6BwuPMoclVaJpUJeMvVGdI2G8inN
 5HIKDy6ZmLSJJt2ibViS5ve468mCmdZEmE83OIKo/18ZpDkO7uMwXuZOEtGYCHTfHEGt+jNyjK
 fNjvguidME31NJpEasnsqyYH3f70rDnuvXmyphuN7LNyK5zO2Ll5D/QLa73upBdA6OM5qKSr9s
 q3cJ/CKkNzRTMIeHwLZBtW0CFf2+8Pjo37vQacPB83ZaITM5kLm9m8wPKhBK8pdb1FIOaa9RYf
 uwc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 16:44:10 -0800
IronPort-SDR: fMn8VWZHD7MddTENt8Spd2YiSOGdX9KgCS3pEvZMd4wmNOfuUXtrP1+lHWzPVnxVfPxGwhsGd8
 Ie9jA/O9BnICJEW1PzojXn9zCoDpwHRxshQJiCHIXaft5JJtvHv/mtuczEVwHE09eDUczv5Ith
 PX8OuHKmwSSJ03IRSgPaeNuCl5DCzhem6bNOXY17DS7be6ctQ+wfWtiWOS5tCTSoDB0h6e6aI7
 e7Jr/xwqu5jHBNZWvWaY2y0/2xh3WHOOO2t82kPAWAI+xMQFfCd73fhnGeoj5U4uh+LN7M3iSY
 ei4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 17:26:38 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P1mQP6HBdz1RvTr
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2023 17:26:37 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674609996; x=1677201997; bh=tQjjtcPg0nZWYhmB/6jG70nfJyikpWEpcP+
        qVUie93k=; b=iDnb3hY7YgL36vhFvii/+zV2KyQDth7Oud18ePAhIBdPhMoPNWa
        GIPQwBTeOMQqpxGKdhATE8ESPb5PIffAxMaeaV8nN2mbjHf10q9KDyptzLahiEO/
        +3jGGAfYWBjbq5GUDerJLlVMfiiRyhpD09sZZ7VJd4nSpM8Mu2FAg4sVKvBwly7s
        Y0grjlsNvCcyOJIayqKxhNPh376VJOa4llAOcERUIc9NMMJjqobo8YeYZqWOlGiG
        HZWisNj3j90KbiwjDIRy/66ALdYgfInVAnKhlG7qcxSMgFQTQg2TEWN401weur0X
        KWxRUCmsft4+kWrygsxMlBaT4SbYkzRWeIA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yR9zDzIKk_XM for <linux-ide@vger.kernel.org>;
        Tue, 24 Jan 2023 17:26:36 -0800 (PST)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P1mQN4836z1RvLy;
        Tue, 24 Jan 2023 17:26:36 -0800 (PST)
Message-ID: <b9a7e400-4eb1-a48b-8e3e-9910317601fc@opensource.wdc.com>
Date:   Wed, 25 Jan 2023 10:26:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug report for sata_via driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <7521d86e-a83e-7972-a4cc-55dd7155fa43@opensource.wdc.com>
 <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
 <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
 <1b8e19c35328d8dffb80fe20c6797525@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1b8e19c35328d8dffb80fe20c6797525@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/25/23 02:06, marius@psihoexpert.ro wrote:
> Hi. It's me again.
> 
> May I bother you with another bug? (^_^;)
> 
> The machine is a Lenovo X61 Tablet, a tablet PC with Intel GM965 / ICH8-M.
> It has a cardbus slot (32bit PCI), Ricoh RL5C476 II (VEN_1180 DEV_0476).
> The card is a VIA VT6421 (VEN_1106 DEV_3249) SATA/PATA controller.
> The card has 2 SATA ports and no PATA.
> 
> ---- CARD INSERTED ----
[...]
> [ 68.460166] resume, return at end of function
> [ 68.460171] hardreset, ata_phys_link_offline check failed
> [ 68.470148] [2358] libata:ata_wait_idle:2049: ata6: abnormal Status 0x7F
> [ 68.472385] ata6: SATA link down (SStatus 0 SControl 310)
> [ 68.482547] hardreset, Online=>Offline
> [ 68.483633] resume, do loop
> [ 68.698036] resume, after do loop
> [ 68.703129] debounce, SCR=0x0
> [ 68.708218] debounce, SCR=0x0
> ...
> [ 68.804763] debounce, SCR=0x0
> [ 68.809851] debounce, SCR=0x0
> [ 68.809858] resume, return at end of function
> [ 68.809863] hardreset, ata_phys_link_offline check failed
> [ 68.819838] [2360] libata:ata_wait_idle:2049: ata7: abnormal Status 0x7F
> [ 68.822067] ata7: SATA link down (SStatus 0 SControl 310)
> [ 69.008039] [2363] libata:ata_wait_idle:2049: ata8: abnormal Status 0x8

Beuh... libata does not understand these status. Bit 3 is set in the
status, but that one is transport dependent, so defined in CF card...
Would need to look that up, but it seems to be that the device reports
that an PIO is still on-going. It seems like we are in the realm of "this
is a weird drive". You could try increasing the 10ms timeout in
ata_wait_idle(): change the call:

ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);

to something like:

ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 5000);

to see if that changes anything.

> ---- EXTERNAL HDD CONNECTED ----
> [ 118.683511] irq 16: nobody cared (try booting with the "irqpoll" option)
> [ 118.684531] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-rc8-M95D+ #1
> [ 118.684538] Hardware name: LENOVO 776702U/776702U, BIOS 7SET39WW (1.25 ) 03/22/2011
> [ 118.684542] Call Trace:
> [ 118.684547] <IRQ>
> [ 118.684550] dump_stack_lvl+0x34/0x44
> [ 118.684561] __report_bad_irq+0x30/0xa2
> [ 118.684569] note_interrupt.cold+0xb/0x61
> [ 118.684575] handle_irq_event+0x65/0x70
> [ 118.684581] handle_fasteoi_irq+0x8b/0x1c0
> [ 118.684588] __common_interrupt+0x5a/0xf0
> [ 118.684596] common_interrupt+0x9f/0xc0
> [ 118.684601] </IRQ>
> [ 118.684604] <TASK>
> [ 118.684606] asm_common_interrupt+0x22/0x40
> [ 118.684614] RIP: 0010:cpuidle_enter_state+0xbb/0x280

Looks like a problem with interrupts here. Can you "gdb vmlinux" and "list
*(cpuidle_enter_state+0xbb)" to see exactly what is failing here ?

[...]

> ---- EJECT CARD ----
> [ 136.498083] pcmcia_socket pcmcia_socket0: pccard: card ejected from slot 0
> [ 136.498159] hardreset, Online=>Offline
> [ 136.500751] Reconfig spd
> [ 136.500807] hardreset, Online=>Offline
> [ 136.500815] Reconfig spd
> [ 136.501858] resume, do loop
> [ 136.501968] resume, do loop
> [ 136.718048] resume, do loop
> [ 136.718089] resume, do loop
> [ 136.938104] resume, do loop
> [ 136.938115] resume, do loop
> [ 137.158076] resume, do loop
> [ 137.158108] resume, do loop
> [ 137.378105] resume, do loop
> [ 137.378115] resume, do loop
> [ 137.598082] resume, after do loop
> [ 137.598086] ata6: failed to resume link (SControl FFFFFFFF)
> [ 137.599831] hardreset, ata_phys_link_offline check failed
> [ 137.599872] ata6: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
> [ 137.599897] resume, after do loop
> [ 137.599900] ata7: failed to resume link (SControl FFFFFFFF)
> [ 137.599965] ------------[ cut here ]------------
> [ 137.601620] hardreset, ata_phys_link_offline check failed
> [ 137.601618] WARNING: CPU: 1 PID: 79 at drivers/ata/libata-core.c:5910 ata_host_detach+0x1c7/0x1d0

Looks like the ATA_PFLAG_UNLOADED is not set, causing this warning. But
given that there seem to be issues with interrupts, the eject may not be
detected.

> [ 137.601661] ata7: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
> [ 137.603368] CPU: 1 PID: 79 Comm: pccardd Not tainted 6.1.0-rc8-M95D+ #1
> [ 137.603375] Hardware name: LENOVO 776702U/776702U, BIOS 7SET39WW (1.25 ) 03/22/2011
> [ 137.603378] RIP: 0010:ata_host_detach+0x1c7/0x1d0

Please gdb that too.

> ---- CONNECT CARD WITH HDD ALREADY ATTACHED ----
> [ 168.768069] pcmcia_socket pcmcia_socket0: pccard: CardBus card inserted into slot 0
> [ 168.771207] pci 0000:06:00.0: [1106:3249] type 00 class 0x010400
> [ 168.771256] pci 0000:06:00.0: reg 0x10: [io 0x0af0-0x0aff]
> [ 168.771280] pci 0000:06:00.0: reg 0x14: [io 0x0a70-0x0a7f]
> [ 168.771302] pci 0000:06:00.0: reg 0x18: [io 0x01f0-0x01ff]
> [ 168.771322] pci 0000:06:00.0: reg 0x1c: [io 0x0170-0x017f]
> [ 168.771343] pci 0000:06:00.0: reg 0x20: [io 0xcc00-0xcc1f]
> [ 168.771363] pci 0000:06:00.0: reg 0x24: [io 0x8c00-0x8cff]
> [ 168.771695] pci 0000:06:00.0: BAR 5: assigned [io 0x4000-0x40ff]
> [ 168.771713] pci 0000:06:00.0: BAR 4: assigned [io 0x4400-0x441f]
> [ 168.771727] pci 0000:06:00.0: BAR 0: assigned [io 0x4420-0x442f]
> [ 168.771742] pci 0000:06:00.0: BAR 1: assigned [io 0x4430-0x443f]
> [ 168.771756] pci 0000:06:00.0: BAR 2: assigned [io 0x4440-0x444f]
> [ 168.771769] pci 0000:06:00.0: BAR 3: assigned [io 0x4450-0x445f]
> [ 168.771908] sata_via 0000:06:00.0: enabling device (0000 -> 0001)
> [ 168.772137] sata_via 0000:06:00.0: routed to hard irq line 0
> [ 168.772162] [79] sata_via:svia_configure:635: sata_via 0000:06:00.0: enabling SATA hotplug (0x0)
> [ 168.773265] scsi host6: sata_via
> [ 168.775256] scsi host7: sata_via
> [ 168.788766] scsi host8: sata_via
> [ 168.788866] ata9: SATA max UDMA/133 port i16@0x4420 bmdma 0x4400 irq 16
> [ 168.788872] ata10: SATA max UDMA/133 port i16@0x4430 bmdma 0x4408 irq 16
> [ 168.788875] ata11: PATA max UDMA/133 port i16@0x4440 bmdma 0x4410 irq 16
> [ 168.788961] hardreset, Online=>Offline
> [ 168.790037] resume, do loop
> [ 169.008036] resume, after do loop
> [ 169.013116] debounce, SCR=0x1
> [ 169.018189] debounce, SCR=0x1
> ...
> [ 170.054131] debounce, SCR=0x1
> [ 170.059209] debounce, SCR=0x1
> [ 170.062091] irq 16: nobody cared (try booting with the "irqpoll" option)
> [ 170.062095] CPU: 0 PID: 2356 Comm: tee Tainted: G W 6.1.0-rc8-M95D+ #1
> [ 170.062100] Hardware name: LENOVO 776702U/776702U, BIOS 7SET39WW (1.25 ) 03/22/2011
> [ 170.062102] Call Trace:
> [ 170.062107] <IRQ>
> [ 170.062109] dump_stack_lvl+0x34/0x44
> [ 170.062117] __report_bad_irq+0x30/0xa2
> [ 170.062123] note_interrupt.cold+0xb/0x61
> [ 170.062128] handle_irq_event+0x65/0x70
> [ 170.062133] handle_fasteoi_irq+0x8b/0x1c0
> [ 170.062138] __common_interrupt+0x5a/0xf0
> [ 170.062144] common_interrupt+0x9f/0xc0
> [ 170.062148] </IRQ>
> [ 170.062150] <TASK>
> [ 170.062151] asm_common_interrupt+0x22/0x40
> [ 170.062157] RIP: 0010:cfb_imageblit+0x3e8/0x800

gdb disassemble (list command) ?


-- 
Damien Le Moal
Western Digital Research

