From: Mark Lord <lkml@rtr.ca>
Subject: Re: new tool:  blktool
Date: Sun, 15 Aug 2004 22:36:58 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41201DCA.2090204@rtr.ca>
References: <411FD744.2090308@pobox.com> <411FF170.9070700@rtr.ca> <411FF37E.7070001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:58293 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S267349AbUHPCiO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Aug 2004 22:38:14 -0400
In-Reply-To: <411FF37E.7070001@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

 > http://www.t10.org/ftp/t10/document.04/04-262r1.pdf

Ahh.. my buddie Curtis has been busy of late, I see.

I'll implement this in hdparm and the SATA/RAID driver
that I'm working on.  Will you (Jeff) do the same in libata?

But HDIO_DRIVE_CMD is rather easy to implement as well,
and perhaps both should be there for an overlap.

Especially since the former is in rather widespread use right now.
Yup, it's missing a separate data-phase parameter,
and lots of taskfile stuff, but it's configured by default
into every kernel (the same is not true for taskfile support),
and there's really only a few limited cases of it being used
for non-data commands:  IDENTIFY, SMART, and the odd READ/WRITE
SECTOR (pio, single sector).

In drivers that I work on now, I generally just support those
limited cases, and defer anything else to either taskfile
or something more native -- but in practice,
there are no other cases.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
