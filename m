From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RESEND v3 5/6] AHCI: Optimize single IRQ interrupt
 processing
Date: Wed, 24 Sep 2014 09:36:10 -0400
Message-ID: <20140924133610.GE16555@htj.dyndns.org>
References: <cover.1411297686.git.agordeev@redhat.com>
 <b1a04379e05e40f9774fb4668609fac4255a6514.1411297686.git.agordeev@redhat.com>
 <20140923205710.GB17332@mtj.dyndns.org>
 <20140924104213.GA2695@agordeev.usersys.redhat.com>
 <20140924130444.GA16555@htj.dyndns.org>
 <20140924082713.7ddd718e@as>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:49072 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbaIXNlt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2014 09:41:49 -0400
Content-Disposition: inline
In-Reply-To: <20140924082713.7ddd718e@as>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert.lkml@gmail.com>
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Sep 24, 2014 at 08:27:12AM -0500, Chuck Ebbert wrote:
> I think he meant other, non-AHCI, interrupt handlers would benefit. A
> good test of this patch might be to stream 10Gb ethernet while also
> streaming writes to an AHCI device.

I'm a bit doubtful this'd make a noticeable difference.  ahci
interrupt handler doesn't do that much to begin with.

Thanks.

-- 
tejun
