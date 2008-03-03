From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: locking problem in sata_sil24?
Date: Tue, 04 Mar 2008 09:37:46 +1100
Message-ID: <1204583866.21545.31.camel@pasglop>
References: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39034 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118AbYCCWil (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Mar 2008 17:38:41 -0500
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org


On Mon, 2008-03-03 at 16:10 -0600, Rune Torgersen wrote:
> Hi I am trying to get PREEMPT_RT pach to wokr on my 2.6.24 kernel, but
> kept gettign a BUG() (kernel BUG at kernel/rtmutex.c:692).
> While tryiong to figure out what it was, I saw some mention of trying
> LOCKDEP to see what is going on, so I patched my -rt1 kernel with some
> lockdep patches from BenH.
> 
> Now I get an "inconsistent locking state", but I need help in trying to
> fiure out what I should look for.
> kernel is fo an Freescale 8280 and the locking seems to occur in the
> driver for a Silicon Image SII3124 SATA disk driver

What core is in the 8280 ? At this stage, I wouldn't rule out a bug in
the lockdep patches, I need to do more work on them.

Cheers,
Ben.


