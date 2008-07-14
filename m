From: Tejun Heo <tj@kernel.org>
Subject: Re: Regression: kernel 2.6.24{,.1} ahci problem, does not boot
Date: Mon, 14 Jul 2008 22:18:40 +0900
Message-ID: <487B5230.8040903@kernel.org>
References: <Pine.LNX.4.63.0806141945270.2761@bob.slackware.com> <487B403F.5040704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51434 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519AbYGSKWV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Jul 2008 06:22:21 -0400
In-Reply-To: <487B403F.5040704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Piter PUNK <piterpunk@slackware.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> And the AHCI controller 1039:1185 @ 00:05.0 works just fine with
> regular devices and PMPs.  Can you please post lspci -nn output on
> your machine?  It seems the blacklisting was too wide.

Tested a bit more and the problem doesn't seem to be PMP support itself.
 Command issue doesn't work properly if follow up SRST is issued without
clearing SError after issuing hardreset.  2.6.26 always clears SError
after hardreset so it should work.  Piter, can you please remove SIS
blacklist and test 2.6.26?

Thanks.

-- 
tejun
