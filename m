From: Mark Lord <liml@rtr.ca>
Subject: Re: SMART support for libata
Date: Wed, 08 Jun 2005 14:52:30 -0400
Message-ID: <42A73E6E.80808@rtr.ca>
References: <87y8g8r4y6.fsf@stark.xeocode.com> <41B7EFA3.8000007@pobox.com> <87br6g6ayr.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:25604 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261522AbVFHSwc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jun 2005 14:52:32 -0400
In-Reply-To: <87br6g6ayr.fsf@stark.xeocode.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Stark <gsstark@mit.edu>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Greg Stark wrote:
>
> getting really hot so I put it to sleep with "hdparm -Y".
> 
> Now whenever smartd probes that drive my system freezes for a few seconds and
> I get this in my syslog:
> 
> Jun  8 12:49:36 stark kernel: hda: status timeout: status=0xd0 { Busy }
> Jun  8 12:49:36 stark kernel: 
> Jun  8 12:49:36 stark kernel: ide: failed opcode was: 0xe5

That is normal and expected behaviour.
A "sleeping" drive never responds to commands
until woken with a reset.

You should be using "-y" (standby) instead of "-Y" (sleep).

Cheers
