From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/8] pcmcia: Add an id to ide-cs.c
Date: Mon, 20 Nov 2006 12:43:33 -0500
Message-ID: <20061120174333.GA18660@isilmar.linta.de>
References: <20061119163427.GA2924@dominikbrodowski.de> <20061119163851.GB2924@dominikbrodowski.de> <20061120095349.GA15410@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:44736 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S966283AbWKTRnf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Nov 2006 12:43:35 -0500
Content-Disposition: inline
In-Reply-To: <20061120095349.GA15410@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Hi,

On Mon, Nov 20, 2006 at 09:53:49AM +0000, Russell King wrote:
> On Sun, Nov 19, 2006 at 11:38:51AM -0500, Dominik Brodowski wrote:
> > 
> > From: Matt Reimer <mattjreimer@gmail.com>
> > Date: Thu, 26 Oct 2006 15:56:00 -0700
> > Subject: [PATCH] pcmcia: Add an id to ide-cs.c
> > 
> > Add an ID entry for:
> > 
> > product info: "TRANSCEND", "TS1GCF80", "", ""
> > manfid: 0x000a, 0x0000
> > function: 4 (fixed disk)
> 
> Erm, silly question: isn't this supposed to be matched by the following:
> 
> static struct pcmcia_device_id ide_ids[] = {
>         PCMCIA_DEVICE_FUNC_ID(4),
> 
> or are we going to be ignoring the function ID and only matching using
> the manfid and product info strings?

As the matching by func_id is fuzzy and gives false positives, this is a
multiple-step process:

a) the kernel checks all built-in and previously loaded modules for
   prod_id and manf_id matches

b) userspace (udev/hotplug + modprobe) loads appropriate modules (including
   those which are only matched by func_id

c) during the module initialization (e.g. modprobe hasn't returned yet) the
   kernel checks the modules based on prod_id and manf_id matches

d) after all these modprobe calls return, userspace writes "1" into
   /sys/$devpath/allow_func_id_match. Then, the kernel re-checks all
   built-in and previously loaded modules for func_id "fuzzy" matches.

It is self-evident that steps b)-d) only work once userspace is ready. As
PCMCIA drivers should be able to work even before that, manf_id and prod_id
table entries do make sense even if func_id matching works.

Thanks,
	Dominik
