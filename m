From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Tue, 22 Jan 2008 02:31:22 +0100
Message-ID: <200801220231.22609.bzolnier@gmail.com>
References: <200801140019.20668.g.chulkov@jacobs-university.de> <20080121164744.2f7d0ed1@lxorguk.ukuu.org.uk> <4794D020.4060204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:9709 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbYAVBSa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 20:18:30 -0500
Received: by ug-out-1314.google.com with SMTP id z38so987996ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 17:18:29 -0800 (PST)
In-Reply-To: <4794D020.4060204@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

On Monday 21 January 2008, Tejun Heo wrote:

[...]

> > Old IDE says it works for PATA. For SATA I can see it might need more
> > care and you might simply not be able to get the info.
> 
> Old IDE often locks up the machine hard after timeouts.  I'm all for

Could you point me to some bugreports?

I would like to know more about hosts/conditions for which it happens.

> gathering more info but benefit vs. risk equation just doesn't look good
> here.  Why take risk for a rare device which forgets to raise IRQ on
> media error?  If such behavior is wide spread among PATA drives && we
> can verify that TF register access after timeout is safe for PATA
> controllers, sure, but currently we aren't sure about either.

Thanks,
Bart
