From: Mark Lord <liml@rtr.ca>
Subject: Re: Playing with SATA NCQ
Date: Sun, 29 May 2005 20:06:12 -0400
Message-ID: <429A58F4.3040308@rtr.ca>
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299F47B.5020603@gmail.com> <1117387591.4851.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:31762 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261471AbVE3AGP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 May 2005 20:06:15 -0400
In-Reply-To: <1117387591.4851.17.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Michael Thonke <iogl64nx@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Erik Slagter wrote:
>
> ICH6M (mobile/no raid) on a Dell Inspiron 9300 laptop. AFAIK there are
> no plans to implement support for AHCI transition in the BIOS. &^$##($%
> DELL.

No hope of it on this machine (I'm using a tricked-out i9300 here too),
because (1) the HD is PATA, not SATA, and (2) the drive itself probably
doesn't support NCQ (my 100GB drive does NOT -- use "hdparm -I" to see
what is supported on any given drive.  libata-dev includes hdparm support).

Cheers
