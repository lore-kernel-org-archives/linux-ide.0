From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: sata sil3114 vs. certain seagate drives results in filesystem
	corruptions
Date: Mon, 22 Oct 2007 12:56:17 +0000
Message-ID: <1193057777.10246.37.camel@localhost>
References: <1192863324.5720.162.camel@localhost>
	 <200710221148.08809.bs@q-leap.de> <1193049392.10246.29.camel@localhost>
	 <200710221302.12229.bs@q-leap.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nn7.de ([85.214.94.156]:37360 "EHLO nn7.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017AbXJVM4U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2007 08:56:20 -0400
In-Reply-To: <200710221302.12229.bs@q-leap.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bernd Schubert <bs@q-leap.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

On Mon, 2007-10-22 at 13:02 +0200, Bernd Schubert wrote:
> On Monday 22 October 2007 12:36:32 Soeren Sonnenburg wrote:
> > > but as much as it fits onto the disk. On reading back this file, the
> > > filesystem will report errors somewhere between 50GB and 230GB (disk size
> > > is 250GB).
> >
> > Wow, I really see lots of corruptions (well every 1-2 GB a couple of
> > bytes are corrupted). Are you getting similiarly many in the 50G - 230G
> > region?
> 
> I never tested what is corrupted. Well, a diff over 250GB would take quite a 
> lot of time...

Actually hexdump does not display duplicate lines, so if your file is
really all zeros it will only display a single line + the count, however
I think it is not so optimized...

Soeren
