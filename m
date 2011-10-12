From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] pata_sil680: minor CodingStyle fixups
Date: Wed, 12 Oct 2011 12:03:05 +0100
Message-ID: <20111012120305.0b5f8f06@lxorguk.ukuu.org.uk>
References: <201110112021.51236.bzolnier@gmail.com>
	<4E957080.6020102@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58754 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751179Ab1JLLDk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 07:03:40 -0400
In-Reply-To: <4E957080.6020102@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


> 
> > +	/* This last case is _NOT_ ok */
> > +	case 0x30:
> > +		printk(KERN_ERR "sil680: Clock disabled ?\n");
> 
>     pr_err()? Or checkpatch.pl doesn't complain about it (I forgot)?

dev_ would be even better but that seems to be a separate thing. The
existing patch is still a move in the right direction.
