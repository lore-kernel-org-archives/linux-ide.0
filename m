From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Wed, 6 Jul 2005 16:09:33 +0200
Message-ID: <20050706140933.GH21330@wotan.suse.de>
References: <20050706133052.GF21330@wotan.suse.de> <58cb370e050706070512c93ee1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:23257 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262116AbVGFOJe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2005 10:09:34 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e050706070512c93ee1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, christoph@lameter.com

> drive->hwif check is redundant, please remove it

It's not. My first version didn't have it but it still crashed.
It's what actually prevents the crash.
I also don't know why, but it's true.

The machine had four IDE controllers BTW (on board an an external Promise
card)

-Andi
