From: =?UTF-8?B?SsOpcsO0bWU=?= Carretero <cJ-ko@zougloub.eu>
Subject: Re: Bad DMA from Marvell 9230
Date: Fri, 30 May 2014 03:06:18 -0400
Message-ID: <20140530030618.5ad4f447@Vantage>
References: <1395903457.5569.89.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zougloub.eu ([198.27.83.45]:52073 "EHLO zougloub.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754888AbaE3HEi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 May 2014 03:04:38 -0400
In-Reply-To: <1395903457.5569.89.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thu, 27 Mar 2014 17:57:37 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> I've been trying a 9230 on a power box here (a 9235 on the same
> machine works fine) and it blows up with an IOMMU violation early
> during init.

Hi,

That's https://bugzilla.kernel.org/show_bug.cgi?id=3D42679
if you haven't already found it.

--=20
J=C3=A9r=C3=B4me
