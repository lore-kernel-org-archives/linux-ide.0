From: =?UTF-8?B?SsOpcsO0bWU=?= Carretero <cJ-ko@zougloub.eu>
Subject: Re: Bad DMA from Marvell 9230
Date: Fri, 30 May 2014 09:58:22 -0400
Message-ID: <20140530095822.3588a6ff@Vantage>
References: <1395903457.5569.89.camel@pasglop>
	<20140530030618.5ad4f447@Vantage>
	<1401446278.14938.26.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zougloub.eu ([198.27.83.45]:55081 "EHLO zougloub.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbaE3N4p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 May 2014 09:56:45 -0400
In-Reply-To: <1401446278.14938.26.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>

On Fri, 30 May 2014 20:37:58 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> We've switched to a 9235 instead which seems to work fine.

Weird (I hadn't seen that you reported the 9235 working...), I have
IOMMU problems with a 9235...

What system are you running it on (when you say "power box", is it a
beefy x86 computer or literally a PowerPC)?
=46or me, AMD 990FX chipset, latest master linux.
My board works fine* on another non-IOMMU system.

--=20
J=C3=A9r=C3=B4me

* with issues with port multipliers

Link to Benjamin's first message: https://lkml.org/lkml/2014/3/27/43
