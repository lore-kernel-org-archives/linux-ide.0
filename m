From: Tejun Heo <tj@kernel.org>
Subject: Re: Added advisement against marvell ATA controller in the ATA wiki
 page
Date: Fri, 10 Jun 2011 14:21:43 +0200
Message-ID: <20110610122143.GH15235@htj.dyndns.org>
References: <20110610070030.GB15235@htj.dyndns.org>
 <4DF20BDC.5090109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60133 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770Ab1FJMVs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2011 08:21:48 -0400
Received: by fxm17 with SMTP id 17so1574051fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2011 05:21:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DF20BDC.5090109@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Saeed Bishara <saeed@marvell.com>, Hubert Bailey <hbailey@marvell.com>

Hello, Mark.

On Fri, Jun 10, 2011 at 08:19:40AM -0400, Mark Lord wrote:
> On 11-06-10 03:00 AM, Tejun Heo wrote:
> ..
> > If anyone has _any_ better idea, please share.  As it currently
> > stands, marvell controllers are the only problematic ones in ATA land
> > and it would be AWESOME to see it somehow resolved.
> ..
> 
> It's only the Marvell AHCI controllers that are causing grief.
> The ones supported by sata_mv are among the very best performing
> SATA controllers that work with Linux.
> 
> So long as it clarifies that point, then great.

Ah, I was thinking about the mixed PATA/SATA thing when I was writing
"different generations".  I'll clear it up.

Thanks.

-- 
tejun
