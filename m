From: Tejun Heo <tj@kernel.org>
Subject: Re: Random shutdown of disks using sata_mv
Date: Tue, 15 Dec 2009 14:38:11 +0900
Message-ID: <4B2720C3.3050203@kernel.org>
References: <34963.87.210.74.220.1259669744.squirrel@ketsers.dhs.org> <ABFC24E4C13D81489F7F624E14891C8661539155@uk-ex-mbx1.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58325 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbZLOFgJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Dec 2009 00:36:09 -0500
In-Reply-To: <ABFC24E4C13D81489F7F624E14891C8661539155@uk-ex-mbx1.terastack.bluearc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Jackson <sjackson@bluearc.com>
Cc: Caspar Smit <c.smit@truebit.nl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 12/01/2009 11:29 PM, Simon Jackson wrote:
> We are investigating a similar type of problem seen on several of
> our systems.  Seemingly at random (though some systems seem more
> susceptible than others) we see the ata link reset and subsequently
> there is a FAILED TO IDENTIFY error logged.  smartctl is unable to
> get information from the drive and a power cycle of the drive is
> required to bring it back on line.
>
> I would be interested to know if the ata level errors are similar to
> those we are seeing.

Posting kernel messages would be helpful.  Just in case, there was a
similar report where the new devicekit based smart polling caused HSM
violation errors and device shutdown on certain SSDs with flaky
firmwares.

Thanks.

-- 
tejun
