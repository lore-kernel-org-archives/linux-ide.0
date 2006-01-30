From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata queue updated
Date: Mon, 30 Jan 2006 16:04:17 +0900
Message-ID: <43DDBA71.6040402@gmail.com>
References: <20060128182522.GA31458@havoc.gtf.org> <200601291711.43426.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:19250 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932116AbWA3HEY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2006 02:04:24 -0500
Received: by zproxy.gmail.com with SMTP id 13so1089832nzn
        for <linux-ide@vger.kernel.org>; Sun, 29 Jan 2006 23:04:24 -0800 (PST)
In-Reply-To: <200601291711.43426.ioe-lkml@rameria.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Ingo Oeser wrote:
> Hi Jeff,
> 
> 
> On Saturday 28 January 2006 19:25, Jeff Garzik wrote:
>> Testing and merge point in Tejun's flood of patches :)  The patch
>> below is against current linux-2.6.git.
> 
> These "function(unsigned int *classes)" style functions in 
> "libata-core.c" worry me somewhat.  Esp. that sometimes you have one class,
> sometimes two.
> This looks like a bug waiting to happen for me.
> 
> Could we somehow get a 
> 
> struct ata_classes {
> 	unsigned int master;
> 	unsigned int slave;
> }
> 
> here (or similiar), before this is in used everywhere?
> 
> Usage would be function(struct ata_classes *classes) then.
> 

Hello,

I object.  Using array is intentional.  Slave aware controllers (PATA / 
ata_piix) will use [0..1], most SATA controllers will use only [0], and 
PM aware ones will use [0..15].  The intention was requiring low level 
drivers of only what they know and normalize them in the core layer.

eg. Current std SATA reset routines consider the argument as *class (a 
single class value) and it's intentional.  As long as a lldd is aware of 
only one device per port, it's allowed/recommeded to consider the passed 
classes argument as a pointer to single class value.  The rest is upto 
the core libata layer.

-- 
tejun
