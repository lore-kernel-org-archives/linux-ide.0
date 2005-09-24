From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA suspend-to-ram patch - merge?
Date: Sat, 24 Sep 2005 06:18:20 -0400
Message-ID: <433527EC.8050503@pobox.com>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com> <20050922103605.GA1527@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:24766 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932155AbVIXKSi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Sep 2005 06:18:38 -0400
In-Reply-To: <20050922103605.GA1527@openzaurus.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Joshua Kwan <joshk@triplehelix.org>, axboe@suse.de, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Pavel Machek wrote:
> I think that shared buses are rare enough to be safely ignored.

Hardly.  This potentially covers many enterprise installations that use 
fibre channel, iSCSI, plus the upcoming SAS device networks.

Desktop != the entire universe.


> We could simply say "never ever suspend machine with some
> disks on shared bus".

This is indeed a fair statement, at least in the short term.

	Jeff


