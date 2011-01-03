From: Tejun Heo <tj@kernel.org>
Subject: Re: Adding runtime PM support to sata_mv driver
Date: Mon, 3 Jan 2011 15:39:47 +0100
Message-ID: <20110103143947.GS18831@htj.dyndns.org>
References: <Pine.LNX.4.44L0.1012292303080.13580-100000@netrider.rowland.org>
 <201012310009.11718.rjw@sisk.pl>
 <20101231120118.GI18831@htj.dyndns.org>
 <AANLkTiksyiR3b3QZu-B7VnfhK_P4t1Y5kHxhAZ4XU+en@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61145 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330Ab1ACOjx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 09:39:53 -0500
Received: by bwz15 with SMTP id 15so13743393bwz.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Jan 2011 06:39:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTiksyiR3b3QZu-B7VnfhK_P4t1Y5kHxhAZ4XU+en@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Priyanka Gupta <ankaguptaca@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-ide@vger.kernel.org

Hello,

On Sun, Jan 02, 2011 at 11:07:43PM -0600, Priyanka Gupta wrote:
> Let me try and elaborate on what I am trying to achieve: I would like
> to add a way to move the marvell sata controller to D3hot to save some
> power.

Oh I see.  You wanna put the controller into sleep.  You'll have to
implement EH actions for it and invoke EH to do it.  The problem is
that for it to work in generic manner, the operations need to be
synchronized with other accesses to the hardware and going through EH
is the easiest way to achieve that.  Something like the following
would work.

On runtime suspend

* Tell EH to kick in and suspend the controller (and wait (or not)).

* EH kicks in.  Mark the port inactive so that further commands
  processing won't happen (it would probably be nice if this is
  something the PM framework can guarantee but I don't think it's done
  that way, is it?)

* EH skips all other EH actions and put the controller in sleep.

On runtime resume

* Tell EH to kick in and wake up the controller.

* EH kicks in.  Powers up the controller and revalidates all the
  attached devices.

So, it's gonna take a bit more code than posted.

Thanks.

-- 
tejun
