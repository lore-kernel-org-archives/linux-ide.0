From: Mark Lord <liml@rtr.ca>
Subject: Re: [patch ide-dev 8/9] make ide_task_ioctl() use REQ_DRIVE_TASKFILE
Date: Wed, 02 Mar 2005 09:20:44 -0500
Message-ID: <4225CBBC.6030904@rtr.ca>
References: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl>	 <200502271731.29448.bzolnier@elka.pw.edu.pl>	 <422337A1.4060806@gmail.com>	 <200502281714.55960.bzolnier@elka.pw.edu.pl>	 <20050301042116.GA9001@htj.dyndns.org>	 <58cb370e05030100424d98c85c@mail.gmail.com>	 <20050301092914.GA14007@htj.dyndns.org> <58cb370e05030101592a46c258@mail.gmail.com> <42255878.7080908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:153 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262306AbVCBOWJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Mar 2005 09:22:09 -0500
In-Reply-To: <42255878.7080908@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

SATA, PATA, or anything else:  if it has to cross the PCI bus,
a simple readX()/writeX() can stall the CPU for the equivalent
of hundreds of instructions.  I agree with Jeff, it is always
worth even moderately complex logic to avoid I/O.

Note that an isolated write{bwl}() *may* be almost free in most
cases, due to write buffers between the CPU and the bus.
But those buffers are of limited depth (typically 3/4 entries),
and a stall there often causes a 0.5us (or more) delay.

When measuring PATA hardware, I found the delay was often between
600ns and 1200ns (0.6us to 1.2us), per readX()/writeX().
With SATA, it will likely be around 11 PCI clocks, or say 363ns
on most current platforms.

Cheers
