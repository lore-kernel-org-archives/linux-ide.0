From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH 2.6.14-rc2 1/2] libata: Marvell spinlock fixes and simplification
Date: Thu, 06 Oct 2005 07:52:40 -0400
Message-ID: <43451008.2090305@emc.com>
References: <20051005210610.EC31826369@lns1058.lss.emc.com>	 <20051005210842.F366B26369@lns1058.lss.emc.com> <1128551744.4041.7.camel@drevil.aslab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750838AbVJFLxR@vger.kernel.org>
In-Reply-To: <1128551744.4041.7.camel@drevil.aslab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Madore <Michael.Madore@aslab.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Pasi Pirhonen <upi@papat.org>, Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>, "Mr. Berkley Shands" <bshands@exegy.com>, Jim Edwards <jim@networkdesigning.com>, scott olson <scotto701@yahoo.com>, Lars Magne Ingebrigtsen <larsi@gnus.org>, Evgeny Rodichev <er@sai.msu.su>
List-Id: linux-ide@vger.kernel.org

Michael Madore wrote:
> I assume this patch doesn't address the 'abnormal status 0x80' issue on
> the 6081.

Correct assumption.  This message seems benign as I've seen it and am 
working fine despite it.  I'll take a look soon.

Is the driver working for you on the 6081?

> On the 5081, I still get two machine checks followed by a
> hard lockup when I load the driver.

Would you turn on ATA_DEBUG and ATA_VERBOSE_DEBUG in 
include/linux/libata.h and send along the console output when loading 
the driver?

Thanks,
BR
