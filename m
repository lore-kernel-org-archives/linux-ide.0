From: Jim Paris <jim@jtan.com>
Subject: Re: libata-tj-stable success report, with minor patch
Date: Mon, 12 Jun 2006 00:06:08 -0400
Message-ID: <20060612040608.GA32353@jim.sh>
References: <20060612022358.GA29164@jim.sh> <448CE1E9.5000502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:28308 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S1750758AbWFLEGL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2006 00:06:11 -0400
Content-Disposition: inline
In-Reply-To: <448CE1E9.5000502@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

> Hmmm... sil3726 and 4726 report different number of ports depending on 
> configuration.  I'll try to get it right in the next round.

Sounds good to me, thanks again.  Let me know if there's anything I
can help test.

> That is a pretty cool enclosure you have there.  How's the
> performance?

Haven't used it much yet, but it seems decent.  "hdparm -t" gives
80MB/s on the RAID6 array across all disks.  Each disk reads at 60MB/s
alone, and reading from all 12 simultaneously gets 6 MB/s on each of
the ten multiplexed disks and 30 MB/s on each of the last two disks.
The card is in a normal PCI slot so that's probably maxing out my bus.

-jim
