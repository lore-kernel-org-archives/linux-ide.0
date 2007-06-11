From: John Fremlin <not@just.any.name>
Subject: Re: [PATCH] AHCI powersaving and port-stopping (2.6.22-rc4)
Date: Mon, 11 Jun 2007 14:20:54 +0000
Message-ID: <87y7iqtvw9.fsf-genuine-vii@john.fremlin.org>
References: <873b0yvk14.fsf-genuine-vii@john.fremlin.org>
	<466D3319.6070008@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:28723 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751871AbXFKOVQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jun 2007 10:21:16 -0400
In-Reply-To: <466D3319.6070008@googlemail.com> (Peter Ganzhorn's message of "Mon\, 11 Jun 2007 13\:33\:45 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Ganzhorn <peter.ganzhorn@googlemail.com>
Cc: linux-ide@vger.kernel.org, power@bughost.org

Peter Ganzhorn <peter.ganzhorn@googlemail.com> writes:

> I just wanted to have a look at the patch and see if it works for me - 
> looks like somethings not all straight, I get this while booting:
>
> ahci 0000:00:1f.2: version 2.2
> ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 19 (level, low) -> IRQ 19
> ahci 0000:00:1f.2: nr_ports (3) and implemented port map (0x1) don't match
> ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x1 impl SATA mode
> ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> scsi0 : ahci
> ata1: SATA max UDMA/133 cmd 0xffffc20000048100 ctl 0x0000000000000000
> bmdma 0x0000000000000000 irq 0
> WARNING: at drivers/ata/libata-eh.c:1917 ata_eh_set_powersave()

[...]

> I hope this output from dmesg helps to make the patch better - if I
> can do any further testing please let me know!

That is fine. The warning is expected. There is nothing wrong with
it.

This patch will stop the ports when they are idle. To turn it on, 
      echo 1 > /sys/module/libata/parameters/powersave

[...]

