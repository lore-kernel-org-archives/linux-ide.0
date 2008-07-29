From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide pmac breakage
Date: Tue, 29 Jul 2008 22:02:51 +1000
Message-ID: <1217332971.11188.249.camel@pasglop>
References: <1217208596.11188.144.camel@pasglop>
	 <20080729141750V.fujita.tomonori@lab.ntt.co.jp>
	 <1217308857.11188.237.camel@pasglop>
	 <200807291341.14724.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36850 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758353AbYG2MDF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jul 2008 08:03:05 -0400
In-Reply-To: <200807291341.14724.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

On Tue, 2008-07-29 at 13:41 +0200, Bartlomiej Zolnierkiewicz wrote:
> > Well, all I do is call into Bart's new helpers to scan for or
> unregister
> > devices ...
> 
> The switch to these helpers happened _before_ 2.6.26 and it shouldn't
> bring
> such behavior change (ditto for new IDE host addition/removal
> helpers)...
> 
> Please try to git-bisect it when you have some time.

Ok, I will. I worked fine when I last tried your patches. I'll see if I
can track it down too. Been a bit too busy lately as you can imagine.

Do you have something that exercise the same code path you can use ?

Ben.


