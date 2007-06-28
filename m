From: Mark Lord <liml@rtr.ca>
Subject: Re: PROBLEM: ata_piix.c for the ICH5 SATA Controller.
Date: Thu, 28 Jun 2007 13:43:28 -0400
Message-ID: <4683F340.2020905@rtr.ca>
References: <cd98e0260706280546m5d8c8f91kb639731e6e2da8db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3745 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbXF1Rmt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jun 2007 13:42:49 -0400
In-Reply-To: <cd98e0260706280546m5d8c8f91kb639731e6e2da8db@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Johny Mail list <maillist.johny@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Johny Mail list wrote:
> Hi,
> I have a big problem with my SC1425 Dell Servers. I use Linux Software
> RAID on them and last days i make few tests on them to see the
> reaction of the server about different situations like : power
> failure, hard drive prower failure ...
> And the hard drive prower failure was the problem. When i unplug the
> electric alimentation (or the SATA port cable) of one of my two hard
> drives in RAID 1, the server stop responding and i get this messages :
> ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata4.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
>             res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata4: port is slow to respond, please be patient (Status 0xd0)
> ata4: port failed to respond (30sec, Status 0xd0)
> ata4: soft resetting port

Does it hang permanently there, or keep failing with additional messages?

According to Intel, their ICH5 hardware does not support ordinary
SATA drive hot insertion/removal.  In practice, it can be made to work
but not via the standard SATA mechanism.

My own observation is that the hardware (CPU) locks up hard when
libata attempts to issue SRST (reset) to a removed SATA drive on ICH5.

I have an ugly (but working) hack for the ICH5 ata_piix driver
to support hot insertion/removal of drives, but I don't know if/when
I'll be pushing it upstream.

Cheers

