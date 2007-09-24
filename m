From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 1/2] Enable link power management for ata drivers
Date: Mon, 24 Sep 2007 16:41:18 -0700
Message-ID: <20070924164118.803cfb22.kristen.c.accardi@intel.com>
References: <20070924215140.966161778@intel.com>
	<20070924151320.67f0c332.kristen.c.accardi@intel.com>
	<46F84460.5090703@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16526 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014AbXIXXqK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Sep 2007 19:46:10 -0400
In-Reply-To: <46F84460.5090703@tiscali.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: roel <12o3l@tiscali.nl>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk, akpm@linux-foundation.org

On Tue, 25 Sep 2007 01:12:32 +0200
roel <12o3l@tiscali.nl> wrote:

> >  #define ata_id_cdb_intr(id)	(((id)[0] & 0x60) == 0x20)
> > +#define ata_id_has_hipm(id)	\
> > +	( (((id)[76] != 0x0000) && ((id)[76] != 0xffff)) && \
> > +	  ((id)[76] & (1 << 9)) )
> 		^
> 		|
> are you sure this
> should be 76?

Yes.

> 
> we can also change the first statement a bit:
> 	(!(((id)[76] == 0x0000) || ((id)[76] == 0xffff)) && \
> 
> 
> > +#define ata_id_has_dipm(id)	\
> > +	( (((id)[76] != 0x0000) && ((id)[76] != 0xffff)) && \
> 
> and:
> 	(!(((id)[76] == 0x0000) || ((id)[76] == 0xffff)) && \

I feel this is equivalent functionality and not as readable.
