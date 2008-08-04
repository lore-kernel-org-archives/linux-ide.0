From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
 and IDE
Date: Mon, 4 Aug 2008 14:07:44 +0100
Message-ID: <20080804140744.7f2da5f6@lxorguk.ukuu.org.uk>
References: <1217779055.4179.10.camel@localhost.localdomain>
	<20080803173941.314edf33@lxorguk.ukuu.org.uk>
	<F29B8321-272A-45B4-9D72-DC6A9EB407F1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60718 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753594AbYHDNZa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 09:25:30 -0400
In-Reply-To: <F29B8321-272A-45B4-9D72-DC6A9EB407F1@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Mon, 4 Aug 2008 08:16:47 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Aug 3, 2008, at 11:39 AM, Alan Cox wrote:
> 
> > - For certain embedded PPC boards there are some things to sort out  
> > with
> > IRQ routing on non standards sane configurations using pata_ali in
> > particular.
> 
> Alan, do you have any specifics here?

Some people are running PPC setups which report the IDE controller as in
native mode, the PCI IRQ as zero and in fact are using legacy IRQ lines.
