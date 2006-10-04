From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PCI/IDE generic IDE driver + bus master DMA logic errors
Date: Wed, 04 Oct 2006 12:17:25 +0100
Message-ID: <1159960645.25772.7.camel@localhost.localdomain>
References: <28EE04D1-1645-4D2C-9D8B-FB4877779223@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40636 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030806AbWJDKvs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Oct 2006 06:51:48 -0400
In-Reply-To: <28EE04D1-1645-4D2C-9D8B-FB4877779223@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: girish <girishvg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Mer, 2006-10-04 am 19:07 +0900, ysgrifennodd girish:
> our hardware guys are designing an pci/ide controller which has  
> interrupt wrapper such that the ide & bus master interrupts are  
> packaged & delivered together.

All the SFF8038i/D1510 style devices have a single interrupt line for
IDE and for bus mastering interrupts. If your device behaves in
accordance to D1510 the default code ought to work.

Alan

