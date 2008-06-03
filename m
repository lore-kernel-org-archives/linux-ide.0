From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Tue, 3 Jun 2008 20:23:27 +0200
Message-ID: <20080603182106.GA3556@homac>
References: <20080528143857.GB5585@homac.suse.de> <4845886E.2010505@garzik.org> <20080603181346.GA5013@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:34161 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbYFCSXM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jun 2008 14:23:12 -0400
Content-Disposition: inline
In-Reply-To: <20080603181346.GA5013@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

On Tue 03. Jun - 19:13:46, Matthew Garrett wrote:
> On Tue, Jun 03, 2008 at 02:07:42PM -0400, Jeff Garzik wrote:
> 
> > It would be nice if you and Holger could work together to produce a 
> > single patch[set]...  right now I have patches from both of you, and I 
> > was sorta waiting on the thread to die down to see if competing patches 
> > might merge into a single set
> 
> I think we were waiting for feedback from Tejun as to why removing the 
> port freeze call fixed the hang I was seeing? Beyond that, Holger's 
> latest patch looked good to me.

My suspicion is just that calling ata_port_freeze() on an already frozen
port is not good ;-)

I'll resend the merged patch.

Regards,
	Holger
