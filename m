From: Jeff Garzik <jeff@garzik.org>
Subject: Re: GA-MA790FX-DS5 SATA ahci NCQ erros on Jmicron 20360/20363  (JMB363)
   kernel 2.6.25-2 Debian/Lenny
Date: Sun, 24 Aug 2008 00:39:36 -0400
Message-ID: <48B0E608.4050205@garzik.org>
References: <g8p6po$nm$1@ger.gmane.org> <48B0916C.4080805@garzik.org> <g8q9mg$v2p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52093 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbYHXEjj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Aug 2008 00:39:39 -0400
In-Reply-To: <g8q9mg$v2p$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Spiridonov <sena@hurd.homeunix.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Sergey Spiridonov wrote:
> Hi
> 
> Jeff Garzik wrote:
> 
>> So...  suspect bad cables, bad port connectors, cable interference,
>> motherboard-caused interference or grounding problems, power supply
>> problems.
> 
> I did exchange power supply and I did exchange hard drives. The same
> hard drive with the same cable works with SB600 and produces errors with
> JMB363. So looks like it is not cable or hard drive problem. May be the
> problem is JMB363 port connector on the motherboard. How can I check it?

Try new motherboard of same brand and model :/

In general, tons of ATA bus errors and SError complaints indicate some 
sort of problem at the physical layer/level.  Its always possible that 
software is to blame, but bug report patterns so far tend to point to 
hardware.

	Jeff


