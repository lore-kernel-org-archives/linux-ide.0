From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6 fix queue] cmd64x: init. code cleanup
Date: Tue, 15 May 2007 23:16:37 +0200
Message-ID: <200705152316.37558.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com> <200705110004.16552.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:36336 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759476AbXEPAqY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 20:46:24 -0400
Received: by ug-out-1314.google.com with SMTP id 44so2831uga
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 17:46:23 -0700 (PDT)
In-Reply-To: <200705110004.16552.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 10 May 2007, Sergei Shtylyov wrote:
> Fix two minor issues with PCI0646 chip reporting in the init_chipset() method:
> "IRQ workaround enabled" message printed out not only for revision 0x01 and
> "CMD646: chipset revision" printed twice (by IDE core and the driver itself).
> Also, remove empty/pointless switch cases for the chips other than PCI0646,
> duplicate write to the MRDMODE register when enabling interrupts and MEMORY
> READ LINE cycles, and needless/misplaced initialization of the timing registers
> in this method.
> Switch to reading only the PCI revision ID register itself, not the whole 32
> bits at its address in init_chipset() and init_hwif() methods; in addition,
> get rid of the useless clearing of hwif->autodma and perform some cosmetic
> style changes in the latter method.
> Refactor ata66_cmd64x() by moving all the code into the 'switch' statement,
> renaming/adding variables, and fixing the coding style.
> While at it, finally get rid of the meaningless aliasing register #define's...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
