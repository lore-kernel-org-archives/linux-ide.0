From: Mark Lord <liml@rtr.ca>
Subject: Re: kernel history of ide performance
Date: Wed, 13 Apr 2005 14:57:53 -0400
Message-ID: <425D6BB1.1040904@rtr.ca>
References: <1112690797.4252506dd574e@kiun.homelinux.net>	 <4252541B.3030209@gmx.de> <58cb370e050405021470f3a851@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:13969 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261181AbVDMS55
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Apr 2005 14:57:57 -0400
In-Reply-To: <58cb370e050405021470f3a851@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "Oliver.Korpilla@gmx.de" <Oliver.Korpilla@gmx.de>, kiu <kiu@gmx.net>, linux-ide@vger.kernel.org

Note that hdparm has a "--direct" flag to perform O_DIRECT I/O,
which can sometimes give different information than the default method.

But the one weakness with 'hdparm -t' in either case,
is that it performs a single READ at a time, rather than
queuing up a pipeline full of READs.  So it should always
slightly under report achievable throughput.

Cheers

