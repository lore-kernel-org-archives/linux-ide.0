From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata PATA support - work items?
Date: Fri, 7 Jan 2005 00:07:34 +0100
Message-ID: <58cb370e050106150743d6271f@mail.gmail.com>
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>
	 <41DB2781.7000203@pobox.com>
	 <005701c4f3ce$37d56140$fb7f4109@tw.ibm.com>
	 <1105044491.24187.268.camel@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:38924 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263102AbVAFXHg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2005 18:07:36 -0500
Received: by wproxy.gmail.com with SMTP id 67so159981wri
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2005 15:07:34 -0800 (PST)
In-Reply-To: <1105044491.24187.268.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Albert Lee <albertcc@tw.ibm.com>, Jeff Garzik <jgarzik@pobox.com>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

On Thu, 06 Jan 2005 21:29:42 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Iau, 2005-01-06 at 08:51, Albert Lee wrote:
> > For the 1st item,
> > - add PATA device errata/blacklist info
> > Is there any detail or draft design idea available?
> 
> There is a fair bit of code in drivers/ide. Most of it is handling drive
> problems that occurred with early DMA drives and it uses the
> model/firmware info in the ident string to match drives that claim to do
> DMA but do not and drives that claim not to but can.
> 
> The logic is fairly simple and the database is easily transported or
> shared. It is fairly important because some of these old drives
> corrupted data if used DMA. (see drivers/ide/ide-dma.c)
> 
> For PIO problem drives where there is a need to keep PIO modes chosen
> carefully then ide-lib has a list (ide_pio_blacklist) and the ide-io
> code knows about pio modes and older style EIDE cycle timing reports
> (ide_get_best_pio_mode)

There was some rumor (?) that this blacklist was created on CMD640
controller programmed with wrong timings...

BTW ide_get_best_pio_mode(), it is really misleading
(i.e. recent PIO tuning bug in it821x.c).

> IDE CD has some DMA blacklists for ATAPI but they should be viewed with
> caution as many entries were due to a bug in our atapi implementation
> that was fixed long ago.

There is only a common DMA blacklist in ide-dma.c.
