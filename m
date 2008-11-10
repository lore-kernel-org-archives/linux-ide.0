From: Santiago Vila <sanvila@unex.es>
Subject: Re: Bug 11581
Date: Mon, 10 Nov 2008 13:02:02 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0811101258580.12415@cantor.unex.es>
References: <Pine.LNX.4.64.0810141314590.2555@cantor.unex.es>
 <9ea470500810140453m6e1f7eb6raf179ee78414e19e@mail.gmail.com>
 <Pine.LNX.4.64.0810141709450.4529@cantor.unex.es> <20081026154657.GA2578@gollum.tnic>
 <Pine.LNX.4.64.0810281202010.24944@cantor.unex.es> <20081110063443.GA17946@gollum.tnic>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from guadiana.unex.es ([158.49.17.23]:55967 "EHLO guadiana.unex.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754483AbYKJMCR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Nov 2008 07:02:17 -0500
In-Reply-To: <20081110063443.GA17946@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

On Mon, 10 Nov 2008, Borislav Petkov wrote:

> Ok, so it looks like your drive gets puzzled again by a
> GET_CONFIGURATION command despite 2.6.18 which used to work, as you say.
> But I think it fails this time because you've updated to debian testing
> and, correct me if I'm wrong, but the udev utility cdrom_id came with
> the update and it sends all those GET_CONFIGURATION commands. Have you
> thought of updating the drive's firmware - that helps sometimes?

Ok, I tried that today, using Wine and the root account, but the unit
is not detected by the firmware updating utility. Which of the multiple
patched kernels should I try? Neither 2.6.18 or 2.6.26 from Debian
seem to work this time.
