From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH] AHCI powersaving and port-stopping (2.6.22-rc4)
Date: Mon, 11 Jun 2007 12:44:22 -0700
Message-ID: <20070611124422.769cba7d.kristen.c.accardi@intel.com>
References: <873b0yvk14.fsf-genuine-vii@john.fremlin.org>
	<466D56B2.5080109@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54778 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755385AbXFKTrt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Jun 2007 15:47:49 -0400
In-Reply-To: <466D56B2.5080109@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: John Fremlin <john@fremlin.org>, linux-ide@vger.kernel.org, power@bughost.org

On Mon, 11 Jun 2007 07:05:38 -0700
Arjan van de Ven <arjan@linux.intel.com> wrote:

> > This is very different from the patch I posted a while ago turning on
> > a few bits in the CMD register (ALPE and ASP) and which Intel is
> 
> we've not seen a patch that actually works in this area unfortunately. 
> We know Kristen's patch does work
> 
> > apparently now trying. That only saves around 250mW. Tejun's patch
> 
> .. and saves close to a watt on a laptop in our measurements
> 
> the patch is available on
> http://www.kernel.org/pub/linux/kernel/people/kristen/patches/SATA/alpm/
> 
> maybe worth a try as well..
> -

I've updated the hardware based patches and posted to the mailing list - 
they do indeed save anywhere from .6-1.5 watts depending on the system,
on my X60 they save about a watt.  I don't think that a hardware based
solution is irrelevant at all - it will usually be able to make faster
and more accurrate decisions about when to place the link into lower
power state than software could.

Note that the previous implementation that was posted didn't work for me,
so I just redid everything.

http://marc.info/?l=linux-kernel&m=118158780117084&w=2

Kristen
