From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: clear PIO pad area
Date: Wed, 7 Sep 2011 01:58:54 +0900
Message-ID: <20110906165854.GK18425@mtj.dyndns.org>
References: <20110906040905.GD18425@mtj.dyndns.org>
 <4E65F09F.6020508@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51892 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab1IFQ7F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2011 12:59:05 -0400
Received: by gxk21 with SMTP id 21so4120585gxk.19
        for <linux-ide@vger.kernel.org>; Tue, 06 Sep 2011 09:59:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E65F09F.6020508@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, tom.leiming@gmail.com

Hello,

On Tue, Sep 06, 2011 at 02:06:23PM +0400, Sergei Shtylyov wrote:
> On 06-09-2011 8:09, Tejun Heo wrote:
> 
> >ata_sff_data_xfer[32]() use pad area if the transfer size isn't
> >multiple of transfer size; however, this area wasn't cleared and
> >garbage data in pad area could be transferred to the device.  Make
> >sure the pad area is cleared.
> 
> >Signed-off-by: Tejun Heo<tj@kernel.org>
> >Cc: Lei Ming<tom.leiming@gmail.com>
> 
>    And what's the problem with garbage data? Why it's worse than 0s?

There were devices which puke on random garbage at the end of CDB and
in general sending indeterministic garbage to external device is a bad
idea.  It increases chance of problems which can be difficult to
reproduce and track down while gaining nothing.  It really is a stupid
thing to do.

Thanks.

-- 
tejun
