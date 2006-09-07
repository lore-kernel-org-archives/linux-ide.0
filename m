From: Andres Salomon <dilinger@debian.org>
Subject: Re: weird port status w/ sata_mv
Date: Thu, 07 Sep 2006 03:22:28 -0400
Message-ID: <1157613748.32204.43.camel@localhost.localdomain>
References: <1157612390.32204.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mouth.voxel.net ([69.9.180.118]:23688 "EHLO mail.squishy.cc")
	by vger.kernel.org with ESMTP id S1750925AbWIGHWX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Sep 2006 03:22:23 -0400
In-Reply-To: <1157612390.32204.40.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org

On Thu, 2006-09-07 at 02:59 -0400, Andres Salomon wrote:
[...]
> 
> What does 0x4 in the SCR_STATUS register actually mean?  Is there
> something that can be initialized or reset to coax the port to a normal
> status/state?
> 
> 

Ok, so to answer my own question: according to
<http://www.monkey.org/openbsd/archive/misc/0408/msg01454.html>, it
would appear that 0x4 means the PHY is in offline mode.  So the question
is, why is it offline, and what can be done to reset it?

