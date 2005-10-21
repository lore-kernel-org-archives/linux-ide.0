From: Jeff Garzik <jgarzik@pobox.com>
Subject: Merging ATA passthru
Date: Fri, 21 Oct 2005 15:14:18 -0400
Message-ID: <43593E0A.4070801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:3511 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965102AbVJUTOX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2005 15:14:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>


Folks,

Taking Mark Lord's (and others) criticism to heart, I'm going to merge 
the ATA passthru work upstream, once 2.6.14 is released.

Since there are still some reported problems that I haven't had time to 
track down, I'm going to -- like ATAPI -- introduce a module option that 
enables passthru.  It will default to off.

Other features that follow a similar pattern -- 98% there but needs a 
few final tweaks -- will be treated in the same way.

This gets lesser-used features upstream where they can get the most 
testing, while defaulting them to off ensures that we won't perturb the 
known-working code.

This also will help me, in that I won't have to maintain a bunch of 
parallel codebases.

	Jeff



