From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata sata_sil error handling
Date: Mon, 23 Apr 2007 19:50:53 +0900
Message-ID: <462C8F8D.2040409@gmail.com>
References: <462B2748.3080200@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:38975 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161391AbXDWLLY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 07:11:24 -0400
Received: by an-out-0708.google.com with SMTP id b33so1748744ana
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2007 04:11:24 -0700 (PDT)
In-Reply-To: <462B2748.3080200@arndnet.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-ide@vger.kernel.org

Arnd Hannemann wrote:
>> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000010
>>  printing eip:
>> ef9c8b05
>> EIP is at ata_host_remove+0x5/0xd0 [libata]
>>  [<ef9cce3a>] ata_pci_remove_one+0x1a/0x40 [libata]
>>  [<b01dc036>] pci_device_remove+0x16/0x40
>>  [<b02262b4>] __device_release_driver+0x64/0x90
>>  [<b02267e5>] driver_detach+0x95/0xa0
>>  [<b0225e89>] bus_remove_driver+0x69/0x90
>>  [<b0226818>] driver_unregister+0x8/0x20
>>  [<b01dc10d>] pci_unregister_driver+0xd/0x60
>>  [<b01305d0>] sys_delete_module+0x140/0x1b0
>>  [<b0142499>] remove_vma+0x39/0x50
>>  [<b0142e37>] do_munmap+0x197/0x1f0
>>  [<b0102cb0>] syscall_call+0x7/0xb

This should be fixed in the current devel kernel.  Can you give a shot
at 2.6.21-rc7?

Thanks.

-- 
tejun
