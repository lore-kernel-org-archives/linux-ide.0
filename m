From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] IDE/ATA/SATA controller hotplug
Date: Tue, 27 Jul 2004 16:15:57 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040727201557.GA1612@havoc.gtf.org>
References: <200407191947.i6JJldK1024910@falcon10.austin.ibm.com> <41067543.3090003@pobox.com> <4106C5B7.9040606@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:46247 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266590AbUG0UP7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jul 2004 16:15:59 -0400
Content-Disposition: inline
In-Reply-To: <4106C5B7.9040606@clanhk.org>
List-Id: linux-ide@vger.kernel.org
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: Doug Maxey <dwm@austin.ibm.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Jul 27, 2004 at 03:14:31PM -0600, J. Ryan Earl wrote:
> Jeff Garzik wrote:
> 
> >Why do you think libata is not already hotplug capable, WRT controllers?
> 
> I'm not sure what WRT means, but your last Linux SATA Update did contain:
> 
> "Hotplug support
> ---------------
> All SATA is hotplug.
> 
> libata does not support hotplug... yet.
> 
> The following SATA controllers will never support hotplug:
> Intel ICH5, Intel ICH5-R, Intel ICH6 (non-AHCI), Pacific Digital Talon,
> Promise SATA SX4."


That refers to SATA devices, not controllers.

	Jeff



