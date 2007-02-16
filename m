From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Fri, 16 Feb 2007 18:07:44 +0800
Message-ID: <45D58270.4080909@tw.ibm.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>	 <8d158e1f0702150052l25fb03fnf17ba315dc6f912d@mail.gmail.com>	 <8d158e1f0702160010k2ed986ddtaccf8d2678ae1231@mail.gmail.com>	 <45D56FE4.3090900@tw.ibm.com>	 <8d158e1f0702160056j11ab6df1v99b4d72866f3e1b2@mail.gmail.com>	 <45D574B1.8080109@tw.ibm.com> <8d158e1f0702160148v366ce96bm8e3ff3e7c64a7198@mail.gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:55424 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423531AbXBPKHt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 05:07:49 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1GA7ncB011391
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 05:07:49 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1GA7mvu521132
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 03:07:48 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1GA7mSf032334
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 03:07:48 -0700
In-Reply-To: <8d158e1f0702160148v366ce96bm8e3ff3e7c64a7198@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Ale <patrick.ale@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Patrick Ale wrote:
> On 2/16/07, Albert Lee <albertcc@tw.ibm.com> wrote:
> 
>> Maybe the Promise BIOS set the adapter as disabled...
>> Could you please try the attached patch?
> 
> 
> This patch is against what? I get a hunk rejected.
> patching file drivers/ata/pata_pdc2027x.c
> Hunk #1 FAILED at 315.
> 1 out of 1 hunk FAILED -- saving rejects to file
> drivers/ata/pata_pdc2027x.c.rej
> 
> Can you make a patch against the libata-dev tree that I pulled last night?
> It's impossible for me to reboot at the moment since my grub gives me
> an attitude.
> 

1. Hmm, the patch looks useless: if the port is disabled, there should
be a error message saying "port disabled. ignoring". But we don't see such
message. So, please disregard the patch. If you have time, please try if any
previous kernel version like 2.6.17 to 2.6.19 works.

2. 
>From the dmesg, 

pata_pdc2027x 0000:00:0b.0: version 0.74-ac5
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 20
pata_pdc2027x 0000:00:0b.0: PLL input clock 16754 kHz
ata11: PATA max UDMA/133 cmd 0xf88597c0 ctl 0xf8859fda bmdma 0xf8859000 irq 20
ata12: PATA max UDMA/133 cmd 0xf88595c0 ctl 0xf8859dda bmdma 0xf8859008 irq 20
scsi11 : pata_pdc2027x
(==> There should be some boot probe activities here... )
scsi12 : pata_pdc2027x
ATA: abnormal status 0x8 on port 0xf88595df

It seems scsi_add_host() is completed for scsi11. But the boot probe
detects nothing. Adding Tejun to the cc list for advice.

--
albert


