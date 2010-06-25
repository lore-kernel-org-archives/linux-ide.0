From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v4] libata: pata_samsung_cf: Add Samsung PATA controller
 driver
Date: Fri, 25 Jun 2010 12:38:19 +0900
Message-ID: <001f01cb1417$dce8f8d0$96baea70$%kim@samsung.com>
References: <1276499263-12217-1-git-send-email-kgene.kim@samsung.com>
 <4C22704B.50103@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <4C22704B.50103@pobox.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Jeff Garzik' <jgarzik@pobox.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, 'Abhilash Kesavan' <a.kesavan@samsung.com>
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> 
> On 06/14/2010 03:07 AM, Kukjin Kim wrote:
> > From: Abhilash Kesavan<a.kesavan@samsung.com>
> >
> > Adds support for the Samsung PATA controller. This driver is based on
the
> > Libata subsystem and references the earlier patches sent for IDE
subsystem.
> >
> > Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
> > Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> 
> Acked-by: Jeff Garzik <jgarzik@redhat.com>
> 
> Send it through the appropriate subsystem tree for this platform...

Hi,

You mean in my case, appropriate subsystem tree is ARM tree.
But I think, as Ben commented, it's better drivers go to upstream via the
driver's tree.
And of course, I read your comments about this like below...
'platform drivers do not build and/or work without additional platform
glue...'

Hmm.
I'm not sure which way is better...

Russell,

How do you think?
May I send this to your patch tracking system?
Or...how should I handle this?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
