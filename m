From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch] ata: ahci: Enclosure Management via LED
Date: Thu, 29 Nov 2007 11:22:20 -0800
Message-ID: <20071129112220.55310ff5@appleyard>
References: <20071129094802.49e729ed@appleyard>
	<474F01E7.5040101@rtr.ca>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19535 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761478AbXK2TYa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Nov 2007 14:24:30 -0500
In-Reply-To: <474F01E7.5040101@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: jeff@garzik.org, akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 29 Nov 2007 13:16:07 -0500
Mark Lord <lkml@rtr.ca> wrote:

> Kristen wrote:
> ...
> >+	 * XXX will need Port Multiplier support
> 
> What's that all about ?
> 

I didn't have any hardware that had LED support as well as Port
Multiplier, so I didn't implement port multiplier support for this.  I
wasn't sure if it was better to just do it anyway, or leave it for when
we actually have hardware that needs it.
