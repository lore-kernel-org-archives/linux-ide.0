From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_it821x completely broken
Date: Tue, 22 Jul 2008 19:10:22 +0100
Message-ID: <20080722191022.0417f45c@lxorguk.ukuu.org.uk>
References: <200807042153.56644.linux@rainbow-software.org>
	<200807122342.12841.linux@rainbow-software.org>
	<200807131347.14045.linux@rainbow-software.org>
	<200807221959.53669.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59650 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751869AbYGVS1y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2008 14:27:54 -0400
In-Reply-To: <200807221959.53669.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Alan Cox <alan@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

> New patch below, this time with DMA forced on RAID volumes - as my firmware
> does not identify the RAID arrays as DMA capable :(

The underlying problem is that the newer libata rewrites the dev->id data
in ways that we can't then patch up. I've actually been hacking on this a
bit today. The existing it821x code was working fine and it does the
needed patching, it just needs to do it in a different place, and that in
turn needs a new ap->ops->read_id() method so it can be hooked.

On the bright side that also allows us to implement a pata_mfm/rll
driver at last.

Alan

