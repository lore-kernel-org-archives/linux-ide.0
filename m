From: "xerces8" <xerces8@butn.net>
Subject: Re: GA-MA790FX-DS5 SATA ahci NCQ erros on Jmicron 20360/20363
	(JMB363) kernel 2.6.25-2 Debian/Lenny
Date: Sun, 24 Aug 2008 18:44:24 +0200
Message-ID: <WorldClient-F200808241844.AA44240046@butn.net>
References: <g8p6po$nm$1@ger.gmane.org> <48B0916C.4080805@garzik.org> <g8q9mg$v2p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ikar.perftech.si ([195.246.0.20]:6733 "EHLO ikar.perftech.si"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbYHXQod (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Aug 2008 12:44:33 -0400
In-Reply-To: <g8q9mg$v2p$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Spiridonov <sena@hurd.homeunix.org>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Sergey Spiridonov wrote:

> Jeff Garzik wrote:
> 
> > So...  suspect bad cables, bad port connectors, cable interference,
> > motherboard-caused interference or grounding problems, power supply
> > problems.
> 
> I did exchange power supply and I did exchange hard drives. The same
> hard drive with the same cable works with SB600 and produces errors with
> JMB363. So looks like it is not cable or hard drive problem. May be the
> problem is JMB363 port connector on the motherboard. How can I check it?

Hi!

I have a JMB363 myself and it has its share of problems.
I would say it is buggy hardware. (why would they otherwise
release a new windows driver every week ? if not to workaround
bugs in HW ;-)

My WD MyBook Studio Edition 500 GB external eSATA drive does not
work on the JMB363 correctly no matter what I try. Both
under linux and windows. I think the best was 30 minutes of
(apparent) error free operation under windows.

If interested, I can supply logs, data etc.
(I have a bunch of drives to try).

Regards,
David


