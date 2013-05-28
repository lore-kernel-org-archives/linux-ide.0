From: Tejun Heo <tj@kernel.org>
Subject: Re: 88SE9172 additional PCI ID: 1b4b:9172
Date: Wed, 29 May 2013 07:31:58 +0900
Message-ID: <20130528223158.GA6149@mtj.dyndns.org>
References: <20130528002234.GB18531@mtj.dyndns.org>
 <20130528071220.3601.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:55794 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757255Ab3E1WcD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 May 2013 18:32:03 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp6so8489319pab.35
        for <linux-ide@vger.kernel.org>; Tue, 28 May 2013 15:32:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130528071220.3601.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Tue, May 28, 2013 at 03:12:20AM -0400, George Spelvin wrote:
> > when the device gets working.
> 
> I don't quite understand this.  With VT-d disabled in the BIOS,
> the devices *are* working.  I even have a port multiplier plugged
> into one.  (Which gets all confused by hdparm -m16, but whatever.)
> 
> When I get time, I'm going to play with various BIOS and kernel
> options to narrow down the problem.  But that's for later.
> 
> Can you explain what you think is not working now?

I just misunderstood what you were saying in the previous email.  Can
you please post a proper patch with SOB?

Thanks.

-- 
tejun
