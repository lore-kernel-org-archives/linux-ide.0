From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: a question about interrupt of IDE controller( bug 5637)
Date: Wed, 05 Dec 2007 17:32:49 +0300
Message-ID: <4756B691.3080202@ru.mvista.com>
References: <1196738884.4012.55.camel@yakui_zhao.sh.intel.com>	<20071204123828.09fc2648@the-village.bc.nu>	<1196832826.10467.15.camel@yakui_zhao.sh.intel.com> <20071205141809.615d1f59@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:1932 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751502AbXLEOcd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Dec 2007 09:32:33 -0500
In-Reply-To: <20071205141809.615d1f59@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-ide@vger.kernel.org, len.brown@intel.com, shaohua.li@intel.com, rui.zhang@intel.com

Hello.

Alan Cox wrote:

>>When IDE device works in legacy mode, the IRQ of IDE is fixed at 14/15
>>for the two channel. But IDE controller is a PCI device, OS will assign
>>an interrupt number for the PCI device in which IDE controller resides.
>>This is realized by calling ide_pci_enable, which will call
>>pcibios_enable_irq. 

> And pcibios_enable_irq should see interrupt in as 0 in that case. It also

    Should doesn't mean it actually does. I've just looked at my 82801DB 
configuration, see yourself:

[root@wasted etc]# lspci -x -s 0:1f.1
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
00: 86 80 cb 24 07 00 80 02 02 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 01 f0 00 00 00 00 00 20 00 00 00 00 43 10 89 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00

    The controller is in legacy mode (programming i/f is 0x8a), yet it 
requests IRQ (interrupt pin = 1) and got assigned IRQ9.

MBR, Sergei
