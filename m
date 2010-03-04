From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/2] ahci: Add platform driver
Date: Thu, 4 Mar 2010 21:11:55 +0300
Message-ID: <20100304181155.GA10894@oksana.dev.rtsoft.ru>
References: <20100304170525.GA8126@oksana.dev.rtsoft.ru>
 <20100304170606.GB29022@oksana.dev.rtsoft.ru>
 <4B8FF626.6060704@pobox.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:34709 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752267Ab0CDSL7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Mar 2010 13:11:59 -0500
Content-Disposition: inline
In-Reply-To: <4B8FF626.6060704@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Mark Lord <kernel@teksavvy.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 04, 2010 at 01:04:22PM -0500, Jeff Garzik wrote:
> On 03/04/2010 12:06 PM, Anton Vorontsov wrote:
> >This can be used for AHCI-compatible interfaces implemented inside
> >System-On-Chip solutions, or AHCI devices connected via localbus.
> >
> >Signed-off-by: Anton Vorontsov<avorontsov@ru.mvista.com>
> >---
> >  drivers/ata/Kconfig           |    8 ++
> >  drivers/ata/Makefile          |    1 +
> >  drivers/ata/ahci_platform.c   |  191 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/ahci_platform.h |   29 ++++++
> >  4 files changed, 229 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/ata/ahci_platform.c
> >  create mode 100644 include/linux/ahci_platform.h
> 
> applied 1-2 to #upstream

Thanks!

> Thanks for this work, this will give me the kick-in-the-pants
> necessary to move forward on mv-ahci and acard-ahci.

:-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
