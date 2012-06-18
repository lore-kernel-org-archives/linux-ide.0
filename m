From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 09/14] ata: Use 32bit DMA in AHCI for Loongson 3.
Date: Mon, 18 Jun 2012 12:10:30 +0200
Message-ID: <20120618101030.GA24308@liondog.tnic>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
 <1339747801-28691-10-git-send-email-chenhc@lemote.com>
 <4FDB08AC.8010208@mvista.com>
 <CAAhV-H6AKp+aGUozOxQoLgGYQ+GtHMbKKC4MVkFA570zodjgDA@mail.gmail.com>
 <20120617120557.GE31534@liondog.tnic>
 <CAAhV-H67M5xH+HMyVNopm=TPhei24NfnzNqiPMA+Ucz4Y7V3hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51959 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137Ab2FRKKf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Jun 2012 06:10:35 -0400
Content-Disposition: inline
In-Reply-To: <CAAhV-H67M5xH+HMyVNopm=TPhei24NfnzNqiPMA+Ucz4Y7V3hg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: huacai chen <chenhuacai@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Huacai Chen <chenhc@lemote.com>, Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>, linux-ide@vger.kernel.org

On Mon, Jun 18, 2012 at 05:04:14PM +0800, huacai chen wrote:
> Do you means it is a better idea to modify "enum board_ids" and add a
> new board id such as board_ahci_sb700_loongson, and then add a new
> entry in ahci_port_info[]?
> If so, I think there is a problem: the pci id of our AHCI controller
> is 1002:4390, if I add board_ahci_sb700_loongson, then I should also
> add
> { PCI_VDEVICE(ATI, 0x4390), board_ahci_sb700_loongson },
> in ahci_pci_tbl[], but ahci_pci_tbl[] already has a line
> { PCI_VDEVICE(ATI, 0x4390), board_ahci_sb700 },
> Then which entry will match the device?

Before you do anything, my question is:

SB700/800 chipsets don't need to set a 32-bit only DMA flag; why do you
need it when you use the same chipset?

So why do you need to do 32-bit DMA only when the chipset supports
64-bit DMA just fine?

Thanks.

-- 
Regards/Gruss,
    Boris.
