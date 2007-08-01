From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Wed, 1 Aug 2007 16:51:40 +0100
Message-ID: <20070801165140.3e176cd1@the-village.bc.nu>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
	<46B0972C.3020000@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60276 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755901AbXHAPox (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 11:44:53 -0400
In-Reply-To: <46B0972C.3020000@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Wed, 01 Aug 2007 18:22:36 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Segher Boessenkool wrote:
> 
> >> setup-pci is for SFF8038i devices. It therefore knows that for  assigned
> >> resources they must be I/O. It also assumes that zero is not a  valid I/O
> >> port just like zero is not a valid IRQ. Stick a real IDE resource  at 
> >> zero and drivers/ide can't cope.
> 
> > But 0 _is_ a valid PCI I/O address.  Do we now have to start
> 
>     I wasn't in PCI 2.1 (later the corresponding passage have disppeared).

SFF controllers often use 0 to indicate a channel isn't configured and
present. Libata and old IDE both assume these semantics for an SFF
IDE device reporting address zero. It matches the hardware behaviour.

I would suggest you don't map one at I/O zero on your PCI.

Alan
