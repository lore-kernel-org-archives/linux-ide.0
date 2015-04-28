From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2 3/9] mfd: syscon: Add Atmel MC (Memory Controller)
 registers definition
Date: Tue, 28 Apr 2015 14:55:58 +0200
Message-ID: <20150428125558.GD3687@piout.net>
References: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1427138955-3617-4-git-send-email-alexandre.belloni@free-electrons.com>
 <20150428123058.GC9169@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53418 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965457AbbD1M4A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Apr 2015 08:56:00 -0400
Content-Disposition: inline
In-Reply-To: <20150428123058.GC9169@x1>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

Hi,

On 28/04/2015 at 13:30:58 +0100, Lee Jones wrote :
> On Mon, 23 Mar 2015, Alexandre Belloni wrote:
> 
> > From: Boris Brezillon <boris.brezillon@free-electrons.com>
> > 
> > The at91rm9200 SoC embeds a Memory Controller block which is used to
> > configure several aspects of the platform:
> > - AHB/APB Bus behavior
> > - SDRAM Controller
> > - EBI (External Bus Interface) and SMC (Static Memory Controller) config
> > 
> > Those registers might be accessed by different drivers, hence we need to
> > define it as a syscon device.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > ---
> >  include/linux/mfd/syscon/atmel-mc.h | 144 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 144 insertions(+)
> >  create mode 100644 include/linux/mfd/syscon/atmel-mc.h
> 
> I've lost context here.
> 
> Is it okay to take this now?
> 

I'd say that it would be better to get that one through the AT91 tree
along with the following patches as they depend on it. Is that okay with
you?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
