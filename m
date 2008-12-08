From: "Rob OpenSuSE" <rob.opensuse.linux@googlemail.com>
Subject: Re: [RFC PATCH] pata_hpt366: fix mode configuration
Date: Mon, 8 Dec 2008 23:18:03 +0000
Message-ID: <ce9d8ed60812081518g5d9166baia9fb9531b472dbff@mail.gmail.com>
References: <493CC897.9080406@kernel.org> <493CF9A8.301@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:54600 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbYLHXSE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Dec 2008 18:18:04 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1500342wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 08 Dec 2008 15:18:03 -0800 (PST)
In-Reply-To: <493CF9A8.301@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>

> There have been reports of pata_hpt366 locking up the whole machine
> and as Mark kindly sent me his hpt366 about a year ago, I played with
> it a bit today.
>
> The controller worked perfectly fine with the IDE driver but with
> pata_hpt366, PIO works but DMA mode locks up the machine solidly.
> After comparing the sources and lspci outputs, I found the following
> differences.

Tejun's patch applied to OpenSUSE 11.1-RC1 kernel solves non-booting
issues, and has given good  performance (which have been regular since
2.6.19 introduced PATA experimental drivers have been shipped by
distros).

I can't comment on cable speed details, as I haven't seen such messages.

If parts of it are dubious, please can we start from a minimal
changeset which delivers a working driver, based on these mods, and
then move forwards to beautified enhanced code.   Though I do wonder
how sensible it is, to spend a lot of time on elegant driver
development for this legacy hardware, as it must be nearing practical
end of life.

The hang existed in 2.6.22 and 2.6.23 code I tried, then was fixed in
updates which made there way into the OpenSUSE distro kernel.  So end
users have been using pata_hpt366 for quite a while, thus the patch
fixes a regression for them.
