From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Impact of no_lba48{_dma} = 1 ?
Date: Wed, 7 Feb 2007 14:19:19 +0000
Message-ID: <20070207141919.50e041ff@localhost.localdomain>
References: <45C9A23E.3030201@imc-berlin.de>
	<20070207115826.2e3609e3@localhost.localdomain>
	<45C9D34E.1060007@imc-berlin.de>
	<20070207135309.66942d25@localhost.localdomain>
	<45C9D8F8.2000303@ru.mvista.com>
	<20070207141149.5c0c709b@localhost.localdomain>
	<45C9DC1B.2070602@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33507 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161319AbXBGOGS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 09:06:18 -0500
In-Reply-To: <45C9DC1B.2070602@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

> 	hda: status timeout: status=0xd0 { Busy }
> 	ide: failed opcode was: unknown
> 	hda: no DRQ after issuing MULTWRITE_EXT
> 	ide0: unexpected interrupt, status=0x80, count=1
> 	ide0: reset: success
> 
> ) sometimes when rqsize is set to 65536 altough I only do PIO transfer?

If your hardware support for LBA48 is broken and you've not disabled
LBA48 then your hardware will do many strange things. 

If however the hwif->no_lba48 is set then drive->addressing ends up as 0
so LBA48 commands should never be issued and rqsize should never get >
256.

Alan
