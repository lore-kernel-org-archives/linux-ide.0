From: Sergey Spiridonov <sena@hurd.homeunix.org>
Subject: Re: GA-MA790FX-DS5 SATA ahci NCQ erros on Jmicron 20360/20363  (JMB363)
     kernel 2.6.25-2 Debian/Lenny
Date: Mon, 25 Aug 2008 01:31:27 +0200
Message-ID: <g8sqp1$jn4$1@ger.gmane.org>
References: <g8p6po$nm$1@ger.gmane.org> <48B0916C.4080805@garzik.org> <g8q9mg$v2p$1@ger.gmane.org> <48B0E608.4050205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:60878 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbYHXX1i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Aug 2008 19:27:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KXOzg-0007Zb-Ps
	for linux-ide@vger.kernel.org; Sun, 24 Aug 2008 23:27:36 +0000
Received: from 87.234.202.175 ([87.234.202.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 24 Aug 2008 23:27:36 +0000
Received: from sena by 87.234.202.175 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 24 Aug 2008 23:27:36 +0000
In-Reply-To: <48B0E608.4050205@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi

Jeff Garzik wrote:

> Try new motherboard of same brand and model :/

Well, it is probably right time to try to get replacement motherboard
from store.

> In general, tons of ATA bus errors and SError complaints indicate some
> sort of problem at the physical layer/level.  Its always possible that
> software is to blame, but bug report patterns so far tend to point to
> hardware.

I think I got indirect confirmation of possible motherboard defect.
There are 2 sata ports managed by JMB363: GSATAII-1 and  GSATAII-2. I
found out that kernel errors appear only if I use GSATAII-1. If I
connect my drive to the GSATAII-2, there are no errors anymore.

Also, Seagate testing utility Seatools for DOS 2.07PG (bootable iso) is
hanging at startup even without connected sata drive, which also
indicates some motherboard problem (or again, utility problem). Seagate
support does not tell anything except something like "it should work"...

Thanks everybody for support.
-- 
Best regards, Sergey Spiridonov

