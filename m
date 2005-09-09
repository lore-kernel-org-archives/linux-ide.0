From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] PCI: PCI/libata INTx bug fix
Date: Fri, 9 Sep 2005 13:04:50 -0400
Message-ID: <20050909170450.GA25136@havoc.gtf.org>
References: <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de> <42FD14E9.8060502@pobox.com> <20050812224303.F40A820E94@lns1058.lss.emc.com> <20050815185732.GA15216@kroah.com> <20050815192341.6600220FF7@lns1058.lss.emc.com> <1126218402469@kroah.com> <20050909130440.4E31E271E6@lns1058.lss.emc.com> <20050909170222.GA24894@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:49551 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030263AbVIIREw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Sep 2005 13:04:52 -0400
Content-Disposition: inline
In-Reply-To: <20050909170222.GA24894@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <gregkh@suse.de>, torvalds@osdl.org
Cc: Brett M Russ <russb@emc.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz

On Fri, Sep 09, 2005 at 10:02:22AM -0700, Greg KH wrote:
> From: Brett M Russ <russb@emc.com>
> 
> Previous INTx cleanup patch had a bug that was not caught.  I found
> this last night during testing and can confirm that it is now 100%
> working.
> 
> Signed-off-by: Brett Russ <russb@emc.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Acked-by: Jeff Garzik <jgarzik@pobox.com>

Linus, please apply to fix my drivers :)

Greg and Brett, thanks much.

	Jeff



