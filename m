From: "Johny Mail list" <maillist.johny@gmail.com>
Subject: Re: PROBLEM: ata_piix.c for the ICH5 SATA Controller.
Date: Fri, 29 Jun 2007 13:39:57 +0200
Message-ID: <cd98e0260706290439n475dc02cw552e47fdd953b575@mail.gmail.com>
References: <cd98e0260706280546m5d8c8f91kb639731e6e2da8db@mail.gmail.com>
	 <4683F340.2020905@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:21101 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759759AbXF2Lj6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 07:39:58 -0400
Received: by wx-out-0506.google.com with SMTP id h31so812905wxd
        for <linux-ide@vger.kernel.org>; Fri, 29 Jun 2007 04:39:57 -0700 (PDT)
In-Reply-To: <4683F340.2020905@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

2007/6/28, Mark Lord <liml@rtr.ca>:
> Johny Mail list wrote:
> > Hi,
> > I have a big problem with my SC1425 Dell Servers. I use Linux Software
> > RAID on them and last days i make few tests on them to see the
> > reaction of the server about different situations like : power
> > failure, hard drive prower failure ...
> > And the hard drive prower failure was the problem. When i unplug the
> > electric alimentation (or the SATA port cable) of one of my two hard
> > drives in RAID 1, the server stop responding and i get this messages :
> > ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > ata4.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
> >             res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> > ata4: port is slow to respond, please be patient (Status 0xd0)
> > ata4: port failed to respond (30sec, Status 0xd0)
> > ata4: soft resetting port
>
> Does it hang permanently there, or keep failing with additional messages?
>
> According to Intel, their ICH5 hardware does not support ordinary
> SATA drive hot insertion/removal.  In practice, it can be made to work
> but not via the standard SATA mechanism.
>
> My own observation is that the hardware (CPU) locks up hard when
> libata attempts to issue SRST (reset) to a removed SATA drive on ICH5.
>
> I have an ugly (but working) hack for the ICH5 ata_piix driver
> to support hot insertion/removal of drives, but I don't know if/when
> I'll be pushing it upstream.
>
> Cheers
>
>

Yes it hang permanently there, after this messages i generally reboot
the server.
Yes it not support SATA drive hot insertion/removal, but i have make
the same test on windows. I unplug one disk when i'm logged and the
system don't stop. The drive is removed from the devices list.

If you can give me the patch for testing it... I would give you my
returns about the good/bad functioning in my case.

Salutation
