From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6 1/3] Add CHS support
Date: Sun, 06 Feb 2005 01:26:14 -0500
Message-ID: <4205B886.4070005@pobox.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49077 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S271382AbVBFG0c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Feb 2005 01:26:32 -0500
In-Reply-To: <006d01c50c11$81003920$a801a8c0@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>, "Mudama, Eric" <eric_mudama@Maxtor.com>, Mark Lord <mlord@pobox.com>

Thanks for doing this work.

Comments:

1) Patches #1 and #2 look OK.

2) Patch #3 needs to be split up into three patches:
	a) rename variables (s/sector/block/),
	b) reorganize read/write translation
	c) add CHS support

    Otherwise, patch #3 (content-wise) is OK.

3) In Promise's GPL'd driver for their SATA (w/ PATA) cards, they 
unconditionally execute the INITIALIZE DEVICE PARAMETERS command.  I 
wonder if we should do the same.

4) I will apply patches #1 and #2 after I receive feedback on my 
comments in item #3.  I have not applied them yet, even though they are 
acceptable.


