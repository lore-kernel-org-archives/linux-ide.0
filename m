From: Mark Lord <liml@rtr.ca>
Subject: Re: libata total system lockup fix
Date: Fri, 19 Aug 2005 00:01:34 -0400
Message-ID: <4305599E.4000303@rtr.ca>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com> <42FA70A9.6080608@pobox.com> <43052C03.7060306@pobox.com> <4305504B.7080201@gmail.com> <430553DB.5030807@rtr.ca> <430555F6.4090709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:57749 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932416AbVHSEBl
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Aug 2005 00:01:41 -0400
In-Reply-To: <430555F6.4090709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

One idea would be to inject more faults into disk (ATA)
as opposed to the Optical (ATAPI) drives, and see if doing
so in combination with the existing ATAPI poll/fails will
trigger things more quickly.

This can be done by using Passthru to issue invalid commands
to a drive, which the drive will reject with "Drive Status Errors".

I just tried it now on a whim, using "hdparm -Z /dev/sda",
and my system never recovered until I used ctrl-alt-sysreq-b.

Now mind you, "hdparm -Z" sends a Seagate vendor-unique opcode
(to my Fujitsu hard drive), and perhaps that maps to something
the Fujitsu recognized or choked on..  But one could edit
hdparm to send a NOP or something instead.

Cheers
