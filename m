From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 6/6] drivers/ide: Convert printk(KERN_NOTICE to
 pr_notice(
Date: Mon, 18 May 2009 19:55:33 +0100
Message-ID: <20090518195533.6ca4412d@lxorguk.ukuu.org.uk>
References: <cover.1242609803.git.joe@perches.com>
	<3ff9e9c7a8918f4d5f7bab5590f46073a196a4bf.1242609804.git.joe@perches.com>
	<4A11343C.5070809@ru.mvista.com>
	<m3skj2im12.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44263 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752468AbZERSzb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 May 2009 14:55:31 -0400
In-Reply-To: <m3skj2im12.fsf@intrepid.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Joe Perches <joe@perches.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

> Though I think most people would agree that the latter is much better,
> no?
> I think removal (rewording) of this rule has already been agreed upon,
> though not exactly yet codified.

There are no rules - its a style guide ;)

And yes sticking to 80 columns is frequently totally bogus especially
when it splits text strings

Alan
--
	"Policy is a poor man's substitute for common sense."
			-- David Woodhouse
