From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: new tool:  blktool
Date: Mon, 16 Aug 2004 12:53:39 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4120E693.8070700@pobox.com>
References: <411FD744.2090308@pobox.com> <411FF170.9070700@rtr.ca> <411FF37E.7070001@pobox.com> <41201DCA.2090204@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22252 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267751AbUHPQxx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Aug 2004 12:53:53 -0400
In-Reply-To: <41201DCA.2090204@rtr.ca>
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Mark Lord wrote:
>  > http://www.t10.org/ftp/t10/document.04/04-262r1.pdf
> 
> Ahh.. my buddie Curtis has been busy of late, I see.
> 
> I'll implement this in hdparm and the SATA/RAID driver
> that I'm working on.  Will you (Jeff) do the same in libata?

I plan on providing _some_ way of executing arbitrary taskfiles, 
possibly more than one way.  I haven't decided upon the best route. 
Since T10 took my command protocol suggestions into account in the above 
proposal, implementing that would be an efficient route to the 
arbitrary-taskfiles feature.


> But HDIO_DRIVE_CMD is rather easy to implement as well,
> and perhaps both should be there for an overlap.
> 
> Especially since the former is in rather widespread use right now.
> Yup, it's missing a separate data-phase parameter,
> and lots of taskfile stuff, but it's configured by default
> into every kernel (the same is not true for taskfile support),
> and there's really only a few limited cases of it being used
> for non-data commands:  IDENTIFY, SMART, and the odd READ/WRITE
> SECTOR (pio, single sector).

If HDIO_DRIVE_CMD was easy to do, I would have already done it.  I agree 
with you that supporting it has benefits, but you are ignoring the 
obstacles:

* without taskfile protocol, it is _impossible_ to execute some vendor 
reserved commands
* without taskfile protocol, and without a lookup table, it is 
impossible to distinguish between [non-data | data-in | data-out] on 
some controllers.  Current IDE driver does "execute and pray we can 
guess from controller behavior" which definitely won't work in a lot of 
situations.

Modern SATA controllers need to set up the DMA engine beforehand -- for 
the entire transfer -- including for PIO data xfer commands.

HDIO_DRIVE_CMD tells me nothing about data direction or taskfile 
protocol.  It forces you to guess :(

libata is designed to be flexible enough to execute the full breadth of 
the ATA command set on whatever host controller you pick -- PCI PATA, 
paride, SATA, ATA-over-ethernet, or whatever zany technology you choose. 
  But all that flexibility demands a bit more from the software side of 
things, command protocol in this case.  That's why I the T10 04-262r1 
proposal spec.

	Jeff


