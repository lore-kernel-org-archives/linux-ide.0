From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH][RFC] Add support for Adaptec 1210SA (was: Re: SiI3112 (Adaptec 1210SA): no devices)
Date: Sat, 7 Jun 2003 14:02:34 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200306071802.h57I2Yb07842@devserv.devel.redhat.com>
References: <20030607175637.GA1266@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:21443 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263310AbTFGRtC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Jun 2003 13:49:02 -0400
In-Reply-To: <20030607175637.GA1266@carfax.org.uk> from "Hugo Mills" at Meh 07, 2003 06:56:37 
List-Id: linux-ide@vger.kernel.org
To: Hugo Mills <hugo-lkml@carfax.org.uk>
Cc: Alan Cox <alan@redhat.com>, Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andre@linux-ide.org

>    Like the patch below?

Yep

>    I've assumed that it's exactly like a SiI3112 in making these
> changes. The kernel now recognises the device, and I can (e.g.) run
> cfdisk. However, any read or write on the disk causes huge delays, and
> these:

Its clearly clos in that it works in PIO although DMA is failing

>    I don't have the knowledge to determine whether this is similar to
> the SiI3112 problems people have been having elsewhere, or if it's a

It is

>  Model=ST3120026AS, FwRev=3.05, SerialNo=3JT059GT

According to the info I have that drive should be working ok


This is a very good starting point anyway
