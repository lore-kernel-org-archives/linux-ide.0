From: Alan Cox <alan@redhat.com>
Subject: Re: SiI3112 (Adaptec 1210SA): no devices
Date: Thu, 5 Jun 2003 18:07:04 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200306052207.h55M74Q26865@devserv.devel.redhat.com>
References: <20030605211526.GE1542@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38208 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264880AbTFEVxg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jun 2003 17:53:36 -0400
In-Reply-To: <20030605211526.GE1542@carfax.org.uk> from "Hugo Mills" at Meh 05, 2003 10:15:26 
List-Id: linux-ide@vger.kernel.org
Cc: Samuel Flory <sflory@rackable.com>, Hugo Mills <hugo-lkml@carfax.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andre@linux-ide.org, alan@redhat.com

> just couldn't find _any_ other SiI3112 SATA card on the market in this
> country. I don't run Red Hat or SuSE, and particularly not their
> kernels -- (I normally run Alan's kernels). Does this mean that I've
> bought a pig in a poke?

If its a standard SI3112 series device with a different device ID then it
ought to work just by adding the ids to the driver.
