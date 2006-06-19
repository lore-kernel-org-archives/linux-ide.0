From: Niccolo Rigacci <niccolo@rigacci.org>
Subject: Re: Sometimes ata_piix fails to detect second SATA disk
Date: Mon, 19 Jun 2006 12:28:48 +0200
Message-ID: <20060619102848.GB17376@rigacci.org>
References: <20060618140650.GA17986@rigacci.org> <44960EF6.4090205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host50-109-static.38-88-b.business.telecomitalia.it ([88.38.109.50]:13504
	"EHLO paros.rigacci.org") by vger.kernel.org with ESMTP
	id S932368AbWFSK2y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jun 2006 06:28:54 -0400
Content-Disposition: inline
In-Reply-To: <44960EF6.4090205@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

On Mon, Jun 19, 2006 at 11:41:58AM +0900, Tejun Heo wrote:
> Niccolo Rigacci wrote:
> >I'm trying to debug a strange problem on an IBM xSeries 206m 
> >where I installed a Debian Testing with a self-compiled Linux 
> >kernel 2.6.15.
> 
> Can you try just released 2.6.17?  ata_piix probing received some 
> updates during 2.6.16 devel cycle and some fixes during .17.

I started to test 2.6.17 vanilla last night, it seems to resolve 
the problem.

I will post a new message in a day or two to confirm that the 
problem is fixed.

Thanks for the great work to the kernel guys. Sorry for bothering 
you before testing the latest version, I can't believe how much 
work is done in just two minor releases!

I hope my mail will remains for people googling on this problem.

-- 
Niccolo Rigacci
Firenze - Italy

Iraq, missione di pace: 38475 morti - www.iraqbodycount.net
