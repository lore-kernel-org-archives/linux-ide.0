From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New driver mtipx2xx submission
Date: Mon, 2 May 2011 19:52:24 +0100
Message-ID: <20110502195224.6175bfb0@lxorguk.ukuu.org.uk>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>
	<20110428230605.78c55c70@lxorguk.ukuu.org.uk>
	<x49oc3lndyu.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44322 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755474Ab1EBSvS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 May 2011 14:51:18 -0400
In-Reply-To: <x49oc3lndyu.fsf@segfault.boston.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>, linux-ide@vger.kernel.org

> > The kernel starting point would be that we have an AHCI driver. If you
> > need workarounds for hardware errata then they can go into it and that is
> > fine. We support NCQ so we can use the queue depths. If there are
> > extensions then the AHCI driver can be enhanced.
> 
> Given the highly parallel nature of these parts, I wouldn't be surprised
> if the ahci queue depth of 31 is one of the main bottlenecks.  Can you
> think of a way to extend the ahci driver in this manner to accommodate
> devices like this one?

The queue depth and tag limits come from the SATA standard and also leak
fairly comprehensively into the AHCI spec so not unless the hardware has
extensions for it and is merely faked SATA (and if you are faking SATA
you have to wonder why if your goal is max performance)
