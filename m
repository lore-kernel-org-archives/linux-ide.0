From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] ide: add "ignore_hpa" module parameter
Date: Mon, 25 May 2009 23:36:43 +0100
Message-ID: <20090525233643.0a47e950@lxorguk.ukuu.org.uk>
References: <200905252344.11826.bzolnier@gmail.com>
	<200905260027.39330.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48093 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752615AbZEYWff (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 May 2009 18:35:35 -0400
In-Reply-To: <200905260027.39330.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> It's also not obvious (at least not to a dumb user like me) that "ignore 
> HPA limit" is equivalent to "preserving the Host Protected Area" as the 
> commit commit says.

It isn't - its the exact reverse.

Ignoring the HPA limit tells the kernel to ignore the system BIOS and
firmware set defaults and to stomp the whole disk regardless. On a modern
system thats almost always a really bad idea. Unfortunately on ancient
boxes with disk jumpers set to lie about the disk size (32GB clipping
etc) its the right thing.

Having the same parameter in both stacks seems a good idea but really we
need Tejun's patch exposing the values and then to propogate the hpa
ignore into sysfs and trigger a revalidate of the disk if you change it.
Libata has all the framework for that ready just needing the final bits.
I don't see anything problematic in old IDE also having that interface.
