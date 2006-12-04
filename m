From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Mon, 4 Dec 2006 14:25:04 +0100
Message-ID: <52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
References: <20061130165202.GA23205@aepfle.de> <20061204123854.GA28159@aepfle.de> <FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org> <4574197A.2020204@ru.mvista.com> <4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org> <45741DDE.4080509@ru.mvista.com> <20061204132124.4f7c50a9@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:12465 "EHLO
	mail-in-11.arcor-online.net") by vger.kernel.org with ESMTP
	id S936827AbWLDN0H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 08:26:07 -0500
In-Reply-To: <20061204132124.4f7c50a9@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

> setup-pci is for SFF8038i devices. It therefore knows that for  
> assigned
> resources they must be I/O. It also assumes that zero is not a  
> valid I/O
> port just like zero is not a valid IRQ. Stick a real IDE resource  
> at zero
> and drivers/ide can't cope.

But 0 _is_ a valid PCI I/O address.  Do we now have to start
using "virtual I/O addresses", analogue to the IRQ situation,
or can these bad assumptions be fixed instead?


Segher

