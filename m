From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New driver mtipx2xx submission
Date: Tue, 28 Jun 2011 16:31:25 +0100
Message-ID: <20110628163125.0f2acc94@lxorguk.ukuu.org.uk>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>
	<20110428230605.78c55c70@lxorguk.ukuu.org.uk>
	<22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com>
	<20110502184206.25907c5e@lxorguk.ukuu.org.uk>
	<22A973199D2C2F46933448F6E7990A300214B0D6@ntxboimbx31.micron.com>
	<20110511202013.075b07cc@lxorguk.ukuu.org.uk>
	<4DD722DB.8030303@micron.com>
	<x49lixuyhhs.fsf@segfault.boston.devel.redhat.com>
	<22A973199D2C2F46933448F6E7990A300239EA77@ntxboimbx31.micron.com>
	<x49ipsp9voy.fsf@segfault.boston.devel.redhat.com>
	<20110601212129.11534c55@lxorguk.ukuu.org.uk>
	<4DF80ADE.8020206@micron.com>
	<x49ips75f4j.fsf@segfault.boston.devel.redhat.com>
	<22A973199D2C2F46933448F6E7990A3002697E77@ntxboimbx31.micron.com>
	<x49boxirnl8.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52967 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758094Ab1F1P3H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jun 2011 11:29:07 -0400
In-Reply-To: <x49boxirnl8.fsf@segfault.boston.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>, linux-ide@vger.kernel.org

> Anywho, a 40% difference is pretty significant (though NUMA can have
> that sort of impact).  Alan, what do you think?  I was never clear on
> how exactly the ahci driver would handle a queue depth larger than 32
> (if it can't, then clearly we'd need a block driver for this hardware).

The AHCI driver can drop that support in fairly easily all the queue
handling is nicely pluggable.

A 40% improvement is a big win, but it seems to me that if any of that is
not hardware related (ie the bigger command queue) then we need to be
fixing the existing driver to improve *ALL* AHCI devices. Or are we going
to end up with a pile of AHCIish drivers for every random device on the
planet ?

My request for info on the Micron errata has so far been ignored,
questions on what is involved in the queue stuff likewise. I'd like to
see those matters resolved.

Alan
