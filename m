From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 21 May 2004 15:59:00 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085176740.3199.12.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.edu.
	pl><1085162347.4791.24.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:3509 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S266042AbUEUV7K
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 17:59:10 -0400
Received: from royntex01.iomegacorp.com (franklin [10.1.1.83])
	by email.iomega.com (Postfix) with ESMTP id 92ED61E1C
	for <linux-ide@vger.kernel.org>; Fri, 21 May 2004 15:59:09 -0600 (MDT)
In-Reply-To: <1085162347.4791.24.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> a trivial -bk8 patch that ducks ever trying PATAPI auto sense.

bk8.good.always.patch is the name I have stored locally for that patch.

> > Without auto sense, we read and write ok ...
> > 
> > But when I try a no-data op x00 "TEST UNIT READY", I get:
> 
> Well, it's a no-op on the ATA side, but not on the ATAPI side.
> 
> Thanks for testing though, I'll think about this one a bit.  I'm 
> surprised the interrupt wasn't handled correctly.

Among our blogged results we of course still have the noise of
brain-dead newbie errors by me.

I'll roll back to vanilla -bk8, apply my bk8.good.always.patch, and
reconfirm results of:

#
# host expects no data, device agrees

sudo plscsi /dev/sg0 -v -X time 5 0 -x "12 00:00:00 00 00"

sudo plscsi /dev/sg0 -v -X time 5 0 -x "00 00:00:00 00 00"

#
# host expects one block in, device actually sources no data

sudo plscsi /dev/sg0 -v -X time 5 0 -i x800 -x "28 00 00:00:00:10 00 00:00 00"

#
# host expects one block out, device actually sinks no data

sudo plscsi /dev/sg0 -v -X time 5 0 -o x800 -x "2A 00 00:00:00:10 00 00:00 00"

Pat LaVarre


