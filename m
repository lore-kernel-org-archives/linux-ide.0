From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] [428/2many] MAINTAINERS - SERIAL ATA (SATA) SUBSYSTEM:
Date: Fri, 17 Aug 2007 08:52:51 -0700
Message-ID: <1187365972.822.93.camel@localhost>
References: <46bffbb6.4FinvGMu+SlIxG24%joe@perches.com>
	 <46C5C2A1.3020701@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:3976 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680AbXHQPxI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Aug 2007 11:53:08 -0400
In-Reply-To: <46C5C2A1.3020701@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, akpm@linux-foundation.org

On Fri, 2007-08-17 at 19:45 +0400, Sergei Shtylyov wrote:

> joe@perches.com wrote:
> > Add file pattern to MAINTAINER entry
> > +F:	drivers/ata/sata_*
>     The libata core doesn't match this pattern, ain't a a vital part of both 
> SAT and PATA drivers?
> MBR, Sergei

Improvements to the pattern would be appreciated.
Would this be a better pattern?

F:	drivers/ata/

There is a SATA-promise maintainer

        PROMISE SATA TX2/TX4 CONTROLLER LIBATA DRIVER
        P:	Mikael Pettersson
        M:	mikpe@it.uu.se
        L:	linux-ide@vger.kernel.org
        S:	Maintained
        F:	drivers/ata/sata_promise.*

maybe there should be an entry to exclude
this maintained driver too?

X:	drivers/ata/sata_promise.*

cheers,  Joe

