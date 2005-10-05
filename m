From: Michael Madore <Michael.Madore@aslab.com>
Subject: Re: [PATCH 2.6.14-rc2 1/2] libata: Marvell spinlock fixes and
	simplification
Date: Wed, 05 Oct 2005 15:35:44 -0700
Message-ID: <1128551744.4041.7.camel@drevil.aslab.com>
References: <20051005210610.EC31826369@lns1058.lss.emc.com>
	 <20051005210842.F366B26369@lns1058.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:58264 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1030408AbVJEWgF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Oct 2005 18:36:05 -0400
In-Reply-To: <20051005210842.F366B26369@lns1058.lss.emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Pasi Pirhonen <upi@papat.org>, Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>, "Mr. Berkley Shands" <bshands@exegy.com>, Jim Edwards <jim@networkdesigning.com>, scott olson <scotto701@yahoo.com>, Lars Magne Ingebrigtsen <larsi@gnus.org>, Evgeny Rodichev <er@sai.msu.su>

On Wed, 2005-10-05 at 17:08 -0400, Brett Russ wrote:
> This patch should fix up lockups that people were seeing due to
> improper spinlock placement.  Also, the start/stop DMA routines put
> guarded trust in the cached state of DMA.

Hi Brett,

I assume this patch doesn't address the 'abnormal status 0x80' issue on
the 6081.  On the 5081, I still get two machine checks followed by a
hard lockup when I load the driver.

Mike

