From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 2/2] fastboot: use a DMI match table to set defaults for
 port-disable
Date: Mon, 11 Aug 2008 22:04:40 -0700
Message-ID: <20080811220440.5cc1bc2d@infradead.org>
References: <20080811153542.61095e5c@infradead.org>
	<20080811153730.74599410@infradead.org>
	<1218503351.25524.28.camel@californication>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60539 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbYHLFEc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 01:04:32 -0400
In-Reply-To: <1218503351.25524.28.camel@californication>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, 12 Aug 2008 03:09:11 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Arjan,
> 
> > Subject: [PATCH] libata: use a DMI match table to set defaults for
> > port-disable
> > 
> > As suggested by Jeff:
> > This patch adds a DMI table that is used for setting defaults for
> > the new dont-probe-port parameter boot time optimization feature.
> > 
> > Initially, the table only contains the Asus EeePC 901 as this is the
> > device I have for testing.
> 
> last time I had mine open, I saw that the other ATA connectors are in
> theory usable. You have to do some heavy modifications, 

if you solder the board... well you can add a tiny kernel patch or
change the dmi ;)



-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
