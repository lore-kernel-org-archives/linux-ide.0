From: Tejun Heo <htejun@gmail.com>
Subject: Re: Message
Date: Sat, 27 Nov 2010 11:25:25 +0100
Message-ID: <4CF0DC95.2050501@gmail.com>
References: <AANLkTinSigE4JPsFByPCkFd-+_oXQwR-V9=AsSH9Warz@mail.gmail.com> <1290755809.2678.14.camel@edumazet-laptop> <AANLkTi=8nWFHeJ0Z-WhprNqZMGprMRG5LQ+b3wKoMWWv@mail.gmail.com> <AANLkTi=bELgtgcWcy59KCvKwWWiuVZBb7e_hTSBHZ4cH@mail.gmail.com> <20101126073805.GB14282@liondog.tnic> <AANLkTikBgxBsGudfiN-xnN-KRNaanFrPpwOH_EMJ-oic@mail.gmail.com> <4CEFEEC6.20900@gmail.com> <AANLkTi=W2swi_5r=wMrORA5xkXq1aU5KRD-rE9f0mxxP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45079 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab0K0KZb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Nov 2010 05:25:31 -0500
In-Reply-To: <AANLkTi=W2swi_5r=wMrORA5xkXq1aU5KRD-rE9f0mxxP@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alessandro Tagliapietra <tagliapietra.alessandro@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Eric Dumazet <eric.dumazet@gmail.com>, linux-kernel@vger.kernel.org, linux-ide <linux-ide@vger.kernel.org>

On 11/26/2010 07:59 PM, Alessandro Tagliapietra wrote:
> 2010/11/26 Tejun Heo <htejun@gmail.com>:
>> Can you please just attach them?
> 
> 
> Sure, here are the files. The file "dmesg" is done via fedora with
> kernel 2.6.35.6-45.fc14.x86_64.
> 
> Also, as aked, the lspci -nn.

So, it's a different controller.  1b4b:91a3 instead of 1b4b:9123.
Hmm... why did they switch vendor id from 11ab?  I currently don't
have access to the datasheets but does the following blind patch work
by any chance?

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3288263..0c39fbb 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -380,6 +380,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
 	{ PCI_DEVICE(0x1b4b, 0x9123),
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9128 */
+	{ PCI_DEVICE(0x1b4b, 0x91a3),
+	  .driver_data = board_ahci_yes_fbs },

 	/* Promise */
 	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */

-- 
tejun
