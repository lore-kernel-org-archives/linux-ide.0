From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide patches
Date: Tue, 24 Jul 2007 07:49:35 +1000
Message-ID: <1185227375.5439.133.camel@localhost.localdomain>
References: <200707222019.03684.bzolnier@gmail.com>
	 <1185148506.5439.80.camel@localhost.localdomain>
	 <1185153674.5439.83.camel@localhost.localdomain>
	 <1185155835.5439.91.camel@localhost.localdomain>
	 <1185156084.5439.93.camel@localhost.localdomain>
	 <46A4B211.7080800@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:34050 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755560AbXGWVtr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jul 2007 17:49:47 -0400
In-Reply-To: <46A4B211.7080800@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org


>     Gah! Why the debug messages might be using KERN_ERR?

Blah, other debug messages where like that and I copy/pasted stupidly. I
suppose at one point, somebody (maybe me) decided that it was a PITA to
have to add "debug" on the kernel command line :-)

I will change all of these to pr_debug anyway.

Cheers,
Ben.

