From: Peter Ganzhorn <peter.ganzhorn@googlemail.com>
Subject: Re: [PATCH] AHCI powersaving and port-stopping (2.6.22-rc4)
Date: Mon, 11 Jun 2007 23:49:38 +0200
Message-ID: <466DC372.3010603@googlemail.com>
References: <873b0yvk14.fsf-genuine-vii@john.fremlin.org>	<466D3319.6070008@googlemail.com> <87y7iqtvw9.fsf-genuine-vii@john.fremlin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:31832 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbXFKVtm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jun 2007 17:49:42 -0400
Received: by ug-out-1314.google.com with SMTP id j3so15377ugf
        for <linux-ide@vger.kernel.org>; Mon, 11 Jun 2007 14:49:40 -0700 (PDT)
In-Reply-To: <87y7iqtvw9.fsf-genuine-vii@john.fremlin.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Fremlin <not@just.any.name>
Cc: linux-ide@vger.kernel.org, power@bughost.org

Well actually I did not worry about the warning, this particular part 
made me worry much more:

Call Trace:
 [<ffffffff804a99ce>] ata_eh_set_powersave+0x34e/0x370
 [<ffffffff8048c7b0>] scsi_error_handler+0x0/0x330
 [<ffffffff804a9e27>] ata_do_eh+0xb7/0x16f0
 [<ffffffff80229f9d>] find_busiest_group+0x1bd/0x800
 [<ffffffff804aece0>] ahci_postreset+0x0/0x80
 [<ffffffff804ada70>] ahci_hardreset+0x0/0xf0
 [<ffffffff804aee20>] ahci_softreset+0x0/0x270
 [<ffffffff804a40f0>] ata_std_prereset+0x0/0xf0
 [<ffffffff8023b134>] lock_timer_base+0x34/0x70
 [<ffffffff8048c7b0>] scsi_error_handler+0x0/0x330
 [<ffffffff8048c7b0>] scsi_error_handler+0x0/0x330
 [<ffffffff8048c7b0>] scsi_error_handler+0x0/0x330
 [<ffffffff804abc27>] ata_scsi_error+0x297/0x730
 [<ffffffff8048c7b0>] scsi_error_handler+0x0/0x330
 [<ffffffff8048c893>] scsi_error_handler+0xe3/0x330
 [<ffffffff80229507>] __wake_up_common+0x47/0x80
 [<ffffffff8048c7b0>] scsi_error_handler+0x0/0x330
 [<ffffffff8024675b>] kthread+0x4b/0x80
 [<ffffffff8020a9a8>] child_rip+0xa/0x12
 [<ffffffff80246710>] kthread+0x0/0x80
 [<ffffffff8020a99e>] child_rip+0x0/0x12

Looks like the kernel complains about a bug or something at this point?! 
Because I am not a developer I can't tell for sure, but I don't think 
this is all good.
It is printed to dmesg when booting and a second time when enabling the 
feature via sysfs.

Peter


John Fremlin wrote:
> Peter Ganzhorn <peter.ganzhorn@googlemail.com> writes:
>
>   
>> I just wanted to have a look at the patch and see if it works for me - 
>> looks like somethings not all straight, I get this while booting:
>>
>> ahci 0000:00:1f.2: version 2.2
>> ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 19 (level, low) -> IRQ 19
>> ahci 0000:00:1f.2: nr_ports (3) and implemented port map (0x1) don't match
>> ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x1 impl SATA mode
>> ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part
>> PCI: Setting latency timer of device 0000:00:1f.2 to 64
>> scsi0 : ahci
>> ata1: SATA max UDMA/133 cmd 0xffffc20000048100 ctl 0x0000000000000000
>> bmdma 0x0000000000000000 irq 0
>> WARNING: at drivers/ata/libata-eh.c:1917 ata_eh_set_powersave()
>>     
>
> [...]
>
>   
>> I hope this output from dmesg helps to make the patch better - if I
>> can do any further testing please let me know!
>>     
>
> That is fine. The warning is expected. There is nothing wrong with
> it.
>
> This patch will stop the ports when they are idle. To turn it on, 
>       echo 1 > /sys/module/libata/parameters/powersave
>
> [...]
>
>
>   

