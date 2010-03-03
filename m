From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 09/11] ahci: Move generic code into libahci
Date: Wed, 3 Mar 2010 20:45:23 +0300
Message-ID: <20100303174523.GA15173@oksana.dev.rtsoft.ru>
References: <20100303171713.GA6322@oksana.dev.rtsoft.ru>
 <20100303171747.GI12362@oksana.dev.rtsoft.ru>
 <4B8E9D7B.6040709@ru.mvista.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B8E9D7B.6040709@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Mar 03, 2010 at 08:33:47PM +0300, Sergei Shtylyov wrote:
[...]
> >diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> >index b7d4923..75e3abd 100644
> >--- a/drivers/ata/Makefile
> >+++ b/drivers/ata/Makefile
> >@@ -1,7 +1,7 @@
> > obj-$(CONFIG_ATA)		+= libata.o
> >-obj-$(CONFIG_SATA_AHCI)		+= ahci.o
> >+obj-$(CONFIG_SATA_AHCI)		+= libahci.o ahci.o
> 
>   This means 2 different modules: libahci.ko and ahci.ko.

Right you are. And we can't do ahci-objs += libahci.o ahci.o,
since that would be a circular dependency. Oh well, I'll merge
09 and 10 patches.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
