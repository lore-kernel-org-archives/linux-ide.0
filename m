From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: new tool:  blktool
Date: Sun, 15 Aug 2004 18:40:37 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <411FE665.60207@pobox.com>
References: <411FD744.2090308@pobox.com> <20040816002245.3f73e75a@hantst.kabel.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52619 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267205AbUHOWk4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Aug 2004 18:40:56 -0400
In-Reply-To: <20040816002245.3f73e75a@hantst.kabel.utwente.nl>
List-Id: linux-ide@vger.kernel.org
To: Anton Starikov <antst@ifm.liu.se>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Anton Starikov wrote:
> Hm..probably I'm stupid guy, but BTW I wont to ask stupid question which
> I have already for a long time.
> 
> I use promise driver from libata. So, drive connected to promise
> controller is /dev/sdX. hdparm doesn't want to manage parameters of a
> such drive. I've checked blktool - the same result.
> So, is it problem of driver (something not implemented yet) or I have to
> use something different? 


I'll add that eventually to the driver, but it's a low priority.

Higher priority for most users is SMART and hotplug support.

With SATA, you don't really need to care that much about most of the 
things that hdparm messes with, such as multiple-mode or transfer mode. 
  The power management and acoustic stuff is probably the most relevant 
to modern SATA devices.

	Jeff


