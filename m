From: Mark Lord <mlord@pobox.com>
Subject: Re: SATL support for hdparm?
Date: Sat, 14 Feb 2009 18:57:33 -0500
Message-ID: <49975A6D.4010608@pobox.com>
References: <20090214222114.GI17914@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbZBNX5j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Feb 2009 18:57:39 -0500
In-Reply-To: <20090214222114.GI17914@xi.wantstofly.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-ide@vger.kernel.org, dgilbert@interlog.com

Lennert Buytenhek wrote:
> [ please CC, not on the list ]
> 
> Hi,
> 
> I have a bunch of SATA disks hanging off a SAS expander on which I
> would like to disable APM (using hdparm -B).  This doesn't work as-is,
> and from reading:
> 
> 	http://smartmontools.sourceforge.net/smartmontools_scsi.html
> 
> it appears that I'd need to hack hdparm to use the ATA PASS THROUGH
> SCSI command to make it talk to SATA disks behind a SAS expander, as
> was already done for smartctl.  Did anyone implement something like
> this for hdparm yet by any chance?
..

It actually does that already.  What version are you trying with?
Grab the latest from sourceforge (9.10 or 9.11) and try again.

If it still doesn't work with that, then let me know and we'll sort it out.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
