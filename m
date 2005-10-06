From: Ian Oliver <lists@foxhill.co.uk>
Subject: Re: SATA150TX4 atat1:command timeout
Date: Thu, 06 Oct 2005 10:55:43 +0100
Message-ID: <VA.00001a40.00905eec@foxhill.co.uk>
References: <433D1626.2000909@robinbowes.com>
Reply-To: linux-ide@vger.kernel.org
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay2.tidymail.co.uk ([217.146.107.7]:5270 "EHLO
	relay2.tidymail.co.uk") by vger.kernel.org with ESMTP
	id S1750778AbVJFJ41 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Oct 2005 05:56:27 -0400
Received: from [217.146.124.254] (helo=foxhill.co.uk)
	(from_AS 16353)
	by relay2.tidymail.co.uk with esmtpa
	(Exim 4.52)
	id 1ENSU9-0007jx-RT
	for linux-ide@vger.kernel.org; Thu, 06 Oct 2005 09:56:21 +0000
In-Reply-To: <433D1626.2000909@robinbowes.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

In article  <433D1626.2000909@robinbowes.com>, Robin Bowes wrote:
> However, during the re-sync, one or more of the disks clunked and I saw 
> an "ATAn Timeout" message on the console and the system froze. (n 
> varied, e.g. ATA2, ATA1, ATA4, etc.)

I had this when hammering a software raid that was on four Promise TX2 
cards. I pulled two of the cards and instead used a four-port SiL3114 and 
the errors went away.

Other have reported similar.  I haven't seen anything about a fix.

Ian



