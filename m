From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata PATA support - work items?
Date: Tue, 04 Jan 2005 18:43:26 -0500
Message-ID: <41DB2A1E.2020809@pobox.com>
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>	 <311601c9050101111929aef5ba@mail.gmail.com>	 <87f94c3705010312568b48d6e@mail.gmail.com>	 <311601c905010313201d5a02fa@mail.gmail.com> <58cb370e05010314092d421aee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44430 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262108AbVADXnn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jan 2005 18:43:43 -0500
In-Reply-To: <58cb370e05010314092d421aee@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Eric Mudama <edmudama@gmail.com>, Greg Freemyer <greg.freemyer@gmail.com>, Albert Lee <albertcc@tw.ibm.com>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, dan mares <dmares@dmares.com>

Bartlomiej Zolnierkiewicz wrote:
> Existing IDE drivers are not going away any time soon (not 2.6.x at least)
> and if/when this happens we shouldn't drop CHS support completely
> from the kernel - IMHO it is quite easy to add CHS support to libata.
> I also agree that libata PATA development should be focused on LBA
> but I don't see any problem in keeping CHS support around...


I don't think it's a problem to support C/H/S in libata.  libata already 
has to handle lba28/lba48, CHS would simply be a third instance of the 
"fill read/write taskfile" code.

	Jeff


