From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SATA kernel-buffered read VERY slow (not raid, Promise TX300
 card); 2.6.23.1(vanilla)
Date: Sun, 6 Jan 2008 22:43:40 +0000
Message-ID: <20080106224340.3aff293c@lxorguk.ukuu.org.uk>
References: <fa.o9uy6Qaq3PtHs2Z9lAKGUKvD85I@ifi.uio.no>
	<fa.1kDEq2SPE3FqpM5Mfw9CVGbvVdY@ifi.uio.no>
	<fa.hIZ5+XhGRugySB/HuLxr5qd6gAY@ifi.uio.no>
	<fa.iefWPg3R6g5Pnm/ktSCK9XWVFVw@ifi.uio.no>
	<fa.FhpaleM/osLTMJ85/PuxjxyJeGI@ifi.uio.no>
	<fa.MP5rgMp4TS2+Cfemd/uFOQOuquQ@ifi.uio.no>
	<477D9B6E.7060000@shaw.ca>
	<477D9D66.3080502@tlinx.org>
	<477DA05F.4080503@shaw.ca>
	<47813926.6010908@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38639 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755686AbYAFWrk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2008 17:47:40 -0500
In-Reply-To: <47813926.6010908@tlinx.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linda Walsh <lkml@tlinx.org>
Cc: Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Sun, 06 Jan 2008 12:25:10 -0800
Linda Walsh <lkml@tlinx.org> wrote:

> Robert Hancock wrote:
> >
> > If this is a Seagate, I believe that they don't have AAM enabled on 
> > any of their newer drives (something about a lawsuit for patent 
> > infringement on that feature, or something). Quite likely they don't 
> > support that power management command, either.
> --
>     Do you have a source for this -- haven't heard of such a conflict -- 

There were patent questions around AAM. There are some discussions on the
t13 archive then it goes silent and nothing is ever said again, which I
imagine is when it got lawyered.

> besides, doesn't
> ATA-7 require some of those functions? 

No.

Alan
