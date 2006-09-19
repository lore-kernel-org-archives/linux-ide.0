From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
Date: Mon, 18 Sep 2006 23:53:39 -0400
Message-ID: <450F69C3.8060603@garzik.org>
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org> <20060914205050.GE27531@curie-int.orbis-terrarum.net> <20060916203812.GC30391@curie-int.orbis-terrarum.net> <20060916210857.GD30391@curie-int.orbis-terrarum.net> <20060917074929.GD25800@htj.dyndns.org> <20060918034826.GA10116@curie-int.orbis-terrarum.net> <450E13D4.10200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41115 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752023AbWISDxn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Sep 2006 23:53:43 -0400
In-Reply-To: <450E13D4.10200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Jeff, we've been ignoring PI in ahci_host_init()...
> 
>     for (i = 0; i < probe_ent->n_ports; i++) {
> #if 0 /* BIOSen initialize this incorrectly */
>         if (!(hpriv->port_map & (1 << i)))
>             continue;
> #endif
> 
> The comment suggests that some BIOSen initialize PI incorrectly which 
> will probably result in undetected ports.  Is this true?  Would it be 
> dangerous to honor PI on some controllers?  If so, PI should be used 
> only for controllers which does non-linear port mapping.


The core problem is that this register is write-once after reset, i.e. 
BIOS-initialized.  And my experience with pre-production machines has 
been that after reset _by the driver_, the register was useless until 
initialized to a value... _by the driver_.  Which defeats the purpose of 
the register.

So the info contained in the register is quite useful -- when info is 
contained in the register.  :)

Now, granted, I have only seen this on pre-production machines, hence 
the #if 0.  But also, since the code has been disabled in production, we 
don't know how effective it is across all platforms, and we _do_ know 
that it is ineffective if used directly after a reset.  The write-once 
behavior is documented, and normal.

We can't really know which controllers have a non-linear port mapping, 
because that is dependent on both the silicon and whether or not the 
chip is connected to port X[0-31].  The BIOS knows this, of course :)

We can try to enable the code, but I worry that it will fail in 
situations such as kexec.

	Jeff


