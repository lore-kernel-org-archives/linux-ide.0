From: Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: SATL support for hdparm?
Date: Sun, 15 Feb 2009 01:14:47 +0100
Message-ID: <49975E77.5020704@interlog.com>
References: <20090214222114.GI17914@xi.wantstofly.org>
Reply-To: dgilbert@interlog.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.infotech.no ([82.134.31.41]:39023 "EHLO
	elrond2.infotech.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbZBOAWo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Feb 2009 19:22:44 -0500
In-Reply-To: <20090214222114.GI17914@xi.wantstofly.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-ide@vger.kernel.org, mlord@pobox.com

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

I need to update that document to state that later versions
of hdparm do indeed use the SAT pass-through mechanism and
hdparm should work in your situation.

So follow Mark Lord's advice.

Doug Gilbert


