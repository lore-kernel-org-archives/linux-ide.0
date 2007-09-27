From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.23-rc7 - _random_ IRQ23 : nobody cared
Date: Thu, 27 Sep 2007 19:04:11 +1000
Message-ID: <1190883851.6158.18.camel@pasglop>
References: <20070924083336.7a08fd61@tux.DEF.witbe.net>
	 <46F7C933.4080003@davidnewall.com>
	 <20070925090057.5778aa2a@tux.DEF.witbe.net> <46FAFF7A.5070208@gmail.com>
	 <20070927080551.424e90b9@tux.DEF.witbe.net>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59808 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbXI0JEf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Sep 2007 05:04:35 -0400
In-Reply-To: <20070927080551.424e90b9@tux.DEF.witbe.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Rolland <rol@as2917.net>
Cc: Tejun Heo <htejun@gmail.com>, David Newall <david@davidnewall.com>, Linux Kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, rol@witbe.net

Let me guess... this is a T61 or X61 ?

There's a problem with these that we don't fully understand yet, we're
getting those stale interrupts all over the range.

I wonder if it could be a bug with the ICH8 chipset... 

If yours is one of these, it's being dealt with (or attempted to deal
with) at

http://bugzilla.kernel.org/show_bug.cgi?id=8853

Ben.


