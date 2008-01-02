From: Jean-Yves Simon <lethalwp@tiscali.be>
Subject: Re: Sil4723 on ata2 - ICH7 - Timeouts - Suspend to RAM
Date: Wed, 02 Jan 2008 11:26:13 +0100
Message-ID: <1199269573.3357.3.camel@little.lethalwp>
References: <1182090097.3108.6.camel@little.lethalwp>
	 <46761D02.8090106@gmail.com> <1199259632.3066.6.camel@little.lethalwp>
	 <477B4458.2070407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:13831 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756058AbYABK0Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 05:26:16 -0500
In-Reply-To: <477B4458.2070407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


Hello,


This mail to confirm that the sil4723 sata "bridge" using 2.6.24-rc6
now:
 - has no timeouts anymore on boot & on first suspend
 - support a suspend to ram sleeping mode


 Wed, 2008-01-02 at 16:59 +0900, Tejun Heo wrote:
> Jean-Yves Simon wrote:
> > Hello Tejun,
> > 
> > First of all, happy new year 2008 ;)
> > 
> > I don't know if i should bother you with this, just an update on how
> > well/bad the sil4723 works with fedora 8 (kernel 2.6.23.9-85 )
> > 
> > boot time: no timeouts anymore,
> > but the device doesn't support the suspend to ram sleeping mode at all
> > now
> > 
> > 
> > I have no device connected through the port multiplier, so can't say if
> > the basic functionnality works at all
> > 
> > 
> > Can you help me to dig this out & fix it? Maybe the vanilla 2.6.3-12
> > could fix this?
> > 
> 
> Can you please give a shot at 2.6.24-rc6?  It's rc but should be ripe
> enough for production use.
> 
> Thanks.
> 
-- 
Jean-Yves Simon <lethalwp@tiscali.be>

