From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Resurrect IT8172 IDE controller driver
Date: Thu, 4 Dec 2008 14:07:42 +0000
Message-ID: <20081204140742.1d0d8046@lxorguk.ukuu.org.uk>
References: <E1L4UpB-0007ro-1g@localhost>
	<492A8306.9000400@ru.mvista.com>
	<b2b2f2320812031839q43eb6102jbae0fbddd9a1cf75@mail.gmail.com>
	<20081204100717.32819f1b@lxorguk.ukuu.org.uk>
	<b2b2f2320812040601k55ab69a6n5da4d321151f94f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53481 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754710AbYLDOHl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2008 09:07:41 -0500
In-Reply-To: <b2b2f2320812040601k55ab69a6n5da4d321151f94f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane McDonald <mcdonald.shane@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 4 Dec 2008 08:01:49 -0600
"Shane McDonald" <mcdonald.shane@gmail.com> wrote:

> Would it be acceptable to claim that these changes are outside the
> scope of this patch, and code the IT8172 driver to behave in the same
> manner as the other wrong drivers, with a suitable comment indicating
> this fact?

I think so..  and if its moved over to libata it can just be fixed then


Alan
