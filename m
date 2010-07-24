From: Tejun Heo <tj@kernel.org>
Subject: Can you guys please take a look at bko#16434?
Date: Sat, 24 Jul 2010 10:47:30 +0200
Message-ID: <4C4AA8A2.4030107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50957 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619Ab0GXIrg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jul 2010 04:47:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, Saeed Bishara <saeed@marvell.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

It looks like sata_mv triggers BUG_ON() when a command it doesn't know
about is issued and discard support makes it happen.  Can you guys
take a look?  And please update it such that it doesn't trigger
BUG_ON() only because an unknown command is issued.  That's way too
dangerous.  If void return from qc_prep is a problem, just move the
whole qc_prep into qc_issue, the distinction is pretty arbitrary
anyway.

Thanks.

-- 
tejun
