From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [rfc][patch] ide: fix unneeded LBA48 taskfile registers access
Date: Mon, 07 Feb 2005 03:58:08 -0500
Message-ID: <42072DA0.8050302@pobox.com>
References: <Pine.GSO.4.58.0502062348200.2763@mion.elka.pw.edu.pl> <4206F2E5.7020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52675 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261370AbVBGI6Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Feb 2005 03:58:24 -0500
In-Reply-To: <4206F2E5.7020501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <tj@home-tj.org>


FWIW, there are two limitations of libata in this area:

1) ISTR some PATA vendor-specific commands have a very specific set of 
input and output registers to use, and input/output sets of registers 
may differ from each other.

2) libata is lazy, and just reads registers in "groups":  the 
lbaH/M/L/nsect registers, the device register, etc.


