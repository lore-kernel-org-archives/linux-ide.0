From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 3/4] ARM: S5PC100: Add support for Compact Flash driver	on
 SMDKC100
Date: Wed, 02 Jun 2010 11:34:31 +0900
Message-ID: <002801cb01fc$245ad4f0$6d107ed0$%kim@samsung.com>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
 <1274948524-2970-4-git-send-email-kgene.kim@samsung.com>
 <20100527194714.GE25921@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20100527194714.GE25921@n2100.arm.linux.org.uk>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 'Abhilash Kesavan' <a.kesavan@samsung.com>, ben-linux@fluff.org
List-Id: linux-ide@vger.kernel.org

Russell King - ARM Linux wrote:
> 
> On Thu, May 27, 2010 at 05:22:03PM +0900, Kukjin Kim wrote:
> > +#include <linux/kernel.h>
> > +#include <linux/types.h>
> > +#include <linux/io.h>
> > +
> > +#include <mach/gpio.h>
> 
> linux/gpio.h ?

Will change it :-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
