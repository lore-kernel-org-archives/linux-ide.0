From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Mon, 04 Dec 2006 16:27:47 +0300
Message-ID: <45742253.1000807@ru.mvista.com>
References: <20061130165202.GA23205@aepfle.de>	<20061204123854.GA28159@aepfle.de>	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>	<4574197A.2020204@ru.mvista.com>	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>	<45741DDE.4080509@ru.mvista.com> <20061204132124.4f7c50a9@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:35869 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S936828AbWLDN0O
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 08:26:14 -0500
In-Reply-To: <20061204132124.4f7c50a9@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Hello.

Alan wrote:

>>>>W82C105_IDE: inconsistent baseregs (BIOS) for port 0, skipping

>>>So that needs fixing too, then.

> Both PCI core and IDE interpret a zero length resource as unassigned.

   This is not about 0-length resource, this is about 0-address. Look at 
ide_hwif_confiure() in drivers/ide/setup-pci.c...

> That is probably better than clearing the flags in retrospect.

>>    I'd agree here, that check in the IDE code seems like being too x86 
>>specific. I'm having issues with it as well on MPC85xx/U-Boot...

> setup-pci is for SFF8038i devices. It therefore knows that for assigned
> resources they must be I/O. It also assumes that zero is not a valid I/O
> port just like zero is not a valid IRQ.

    You should know that the IRQ assumption is *not* true even for x86 since 
IRQ0 is and has always been a perfectly valid IRQ (used by PIT).

> Stick a real IDE resource at zero
 > and drivers/ide can't cope.

    Yeah, I've noticed. Unfortunately, a lot of PPC platforms (at least) are 
doing exactly this...

> Alan

WBR, Sergei
