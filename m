From: Tejun Heo <tj@kernel.org>
Subject: Re: "device error via D2H FIS" w/ Samsung drive and Si3726
Date: Sat, 30 Jul 2011 14:55:53 +0200
Message-ID: <20110730125553.GO2622@htj.dyndns.org>
References: <CAO+W5hp61FEEz1gks-=uYfNB4L=Fw6UWU1r4tOUALLZfXrVufg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54415 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab1G3Mz6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jul 2011 08:55:58 -0400
Received: by fxh19 with SMTP id 19so3076930fxh.19
        for <linux-ide@vger.kernel.org>; Sat, 30 Jul 2011 05:55:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAO+W5hp61FEEz1gks-=uYfNB4L=Fw6UWU1r4tOUALLZfXrVufg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryan Castellucci <ryan.castellucci@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tue, Jul 26, 2011 at 08:59:39PM -0700, Ryan Castellucci wrote:
> I've got a eight bay RAID enclosure with two Si3726 based port
> multipliers. I have some Seagate ST31500341AS drives which work fine,
> but my Samsung HD204UI do not like this.  I've tried swapping the
> cable.  I've tried both with a on-board JMB362 AHCI and a Si3132 and
> get similar errors.  On the Si3132 (with latest non-raid firmware):
> 
> I have eight of these Samsung drives and they all do the same thing,
> but work fine when direct attached.
> 
> Here's what spews into the kernel log:

Can you please attach full dmesg output?  The log you posted is too
incomplete to tell what's going on.

Thanks.

-- 
tejun
