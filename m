From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Mon, 10 Mar 2008 08:22:36 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803100821440.3948@axis700.grange>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange>
 <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange>
 <47CFADDF.20200@gmail.com> <Pine.LNX.4.64.0803061248070.5670@axis700.grange>
 <47D0C9E6.8090301@gmail.com> <Pine.LNX.4.64.0803082345000.6749@axis700.grange>
 <47D3723B.3040700@gmail.com> <Pine.LNX.4.64.0803092221560.7385@axis700.grange>
 <47D485EC.1060103@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:51669 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750786AbYCJHWc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Mar 2008 03:22:32 -0400
In-Reply-To: <47D485EC.1060103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Mon, 10 Mar 2008, Tejun Heo wrote:

> > Yctually it was 2.6.24 before, rebuilt 2.6.25-rc4, booted as above, it did 
> > say:
> > 
> > ata4: FORCE: PHY spd limit set to 1.5Gbps
> > 
> > but hot-plugging the drive still took 50 seconds to recover.
> 
> How about cold plugging?

Same.

Thanks
Guennadi
---
Guennadi Liakhovetski
