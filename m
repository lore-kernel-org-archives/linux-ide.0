From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF Card Adapter White List Candidate
Date: Wed, 5 Jan 2011 19:23:41 -0800
Message-ID: <20110106032341.GB19416@mtj.dyndns.org>
References: <369064.19710.qm@web112003.mail.gq1.yahoo.com>
 <AANLkTimXN5ThH08Q7u1kY5DQNPmY4O5WXmG64=dc_T9z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46466 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab1AFDXt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2011 22:23:49 -0500
Received: by qyj19 with SMTP id 19so18918318qyj.19
        for <linux-ide@vger.kernel.org>; Wed, 05 Jan 2011 19:23:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimXN5ThH08Q7u1kY5DQNPmY4O5WXmG64=dc_T9z@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tom Denchfield <td_denchfield@yahoo.com>, linux-ide@vger.kernel.org

Hello,

On Wed, Jan 05, 2011 at 05:47:49PM -0600, Robert Hancock wrote:
> > Tejun, this CF card adapter plugs directly into an IDE socket
> > (Channel 0, in my case) on a desktop computer motherboard.  You
> > can see a picture of the adapter in the following URL01:

Oh, okay, so it's a plugin device.  For some reason, I thought the
machine in question was a laptop and the CF slot was built-in.

> The reason the speed is being limited to 33 is that the cable
> detection code is detecting that an 80-wire cable doesn't appear to be
> connected. In order for an 80-wire cable to be detected, pin 34 on the
> cable is supposed to be grounded at the motherboard end. In the case
> of this adapter, since it plugs directly into the motherboard, it
> would have to be grounding pin 34 to get an 80-wire detection, but
> presumably it's not.

Yeap, it's the device failing to wire cable detection properly.
Unfortunately, it's impossible to detect and work around
automatically.

Thanks.

-- 
tejun
