From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: 2.6.22-rc5 libata/ata_piix failure with older CDROM
Date: Tue, 3 Jul 2007 11:54:45 +0200 (MEST)
Message-ID: <200707030954.l639sjvC010518@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:55880 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756013AbXGCJyu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 05:54:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

On Tue, 03 Jul 2007 16:36:13 +0900, Tejun Heo wrote:
> Mikael Pettersson wrote:
> > ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
> >          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> 
> This is hopefully fixed by using PIO for ATAPI data transfers which
> aren't multiple of 16bytes, which made into -rc7.  Care to give it a shot?

Confirmed, the libata ATAPI DMA changes in -rc7 fixed this issue.

/Mikael
