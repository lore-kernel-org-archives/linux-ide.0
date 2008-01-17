From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv oops on module removal
Date: Thu, 17 Jan 2008 10:01:09 -0500
Message-ID: <478F6DB5.4080308@rtr.ca>
References: <478F5F1C.80608@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1092 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbYAQPBN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Jan 2008 10:01:13 -0500
In-Reply-To: <478F5F1C.80608@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Tomasz Chmielewski wrote:
> This is what happened when I tried to remove sata_mv module:
> 
> 
> ACPI: PCI interrupt for device 0000:01:00.0 disabled
> BUG: unable to handle kernel paging request at virtual address e0122028
>  printing eip:
> e0015599
> *pde = 1f557067
> *pte = 00000000
> Oops: 0000 [#1]
> Modules linked in: cpufreq_ondemand p4_clockmod speedstep_lib iscsi_scst 
> crc32c libcrc32c scst_vdisk scst bonding dm_mirror dm_snapshot sata_mv
> CPU:    0
> EIP:    0060:[<e0015599>]    Not tainted VLI
> EFLAGS: 00010046   (2.6.23.14-N5200-3 #8)
> EIP is at __mv_stop_dma+0x53/0xc2 [sata_mv]
> eax: e0120000   ebx: 00000282   ecx: df629a0c   edx: df629a4c
> esi: df494000   edi: e0122000   ebp: df44d048   esp: ddd07eb8
> ds: 007b   es: 007b   fs: 0000  gs: 0033  ss: 0068
> Process rmmod (pid: 2305, ti=ddd06000 task=df25aa80 task.ti=ddd06000)
> Stack: df44d0ec 00000000 c01d14bc 00000001 00000282 df5aa4ec df44d14c 
> e0015611
>        00000000 c0219884 df5aa4e0 ddd07f00 df44d14c 00000000 c01f525f 
> df44d14c
>        df44d048 0000001d df5aa4e0 df7e5a00 00000292 e0018af0 c0347760 
> ddd06000
> Call Trace:
>  [<c01d14bc>] acpi_pci_free_irq+0x0/0x12
>  [<e0015611>] mv_stop_dma+0x9/0xd [sata_mv]
>  [<c0219884>] ata_host_release+0x2f/0x87
>  [<c01f525f>] release_nodes+0x102/0x122
>  [<c01f5387>] devres_release_all+0x1b/0x1e
>  [<c01f3422>] __device_release_driver+0x75/0x8b
>  [<c01f37f3>] driver_detach+0x59/0x96
>  [<c01f300d>] bus_remove_driver+0x57/0x75
>  [<c01b250a>] pci_unregister_driver+0xc/0x45
>  [<c012da39>] sys_delete_module+0x16f/0x196
>  [<c013ceaa>] remove_vma+0x31/0x36
>  [<c0103bd6>] syscall_call+0x7/0xb
>  =======================
> Code: 00 02 00 8b 96 70 20 00 00 8d b8 00 20 00 00 f6 42 20 01 74 16 c7 
> 80 28 20 00 00 02 00 00 00 8b 80 28 20 00 00 83 62 20 fe eb 33 <8b> 80 
> 28 20 00 00
> EIP: [<e0015599>] __mv_stop_dma+0x53/0xc2 [sata_mv] SS:ESP 0068:ddd07eb8
..

You did not say which exact kernel version this is from.
A bug just like this was fixed not long ago.

-ml

