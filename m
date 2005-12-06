From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Date: Tue, 6 Dec 2005 22:20:02 +0000
Message-ID: <20051206222001.GA14171@srcf.ucam.org>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:14228 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965042AbVLFWUY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Dec 2005 17:20:24 -0500
Content-Disposition: inline
In-Reply-To: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>

On Tue, Dec 06, 2005 at 02:10:04PM +0800, Shaohua Li wrote:

> TODO: invoking ATA commands.
> 
> Though we didn't invoke ATA commands, this patch fixes the bug at 
> http://bugzilla.kernel.org/show_bug.cgi?id=5604. And Matthew said this
> actually fixes a lot of systems in his test.
> I'm not familiar with IDE, so comments/suggestions are welcome.

Of the DSDTs I've looked at, most seem to provide taskfile commands 
concerned about doing things like setting up drive security. I haven't 
yet seen an IDE failure on resume when using this patch, so the _GTF 
stuff doesn't seem terribly important. The reason for it not currently 
being implemented is that the IDE queues haven't been restarted at the 
point where this code is called, so there's no obvious way of submitting 
them to the drive yet.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
