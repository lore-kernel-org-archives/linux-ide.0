From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_it821x completely broken
Date: Fri, 11 Jul 2008 21:14:09 +0100
Message-ID: <20080711211409.2eef4ddb@lxorguk.ukuu.org.uk>
References: <200807042153.56644.linux@rainbow-software.org>
	<20080706230118.GA25905@devserv.devel.redhat.com>
	<200807102235.22651.linux@rainbow-software.org>
	<200807112043.36772.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35556 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753344AbYGKUbw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2008 16:31:52 -0400
In-Reply-To: <200807112043.36772.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Alan Cox <alan@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

> > commenting out the error check after ata_dev_init_params() call in
> > ata_dev_read_id() function (libata-core.c), I got at least the device name.
> > The capacity is 0 so it doesn't work, obviously:

If you don't read the ID then it wouldn't.

> I captured the IDENTIFY data from the virtual device. I'm not ATA guru but
> looking at the data, there are zeros at many places where something should be.
> That number starting at 0x78 looks like size of the array in sectors
> (0x4C726C or 0x4C6C72 - the array is built from 2.5GB and 6.4GB drives).

The Ident data for the virtual device is fairly sparse but the specs
don't require a lot of the field are filled in and only the LBA really
matters.

