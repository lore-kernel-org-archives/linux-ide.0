From: Rob Baxter <robb@synergymicro.com>
Subject: Re: Silicon Image 3124 SATA driver
Date: Tue, 5 Apr 2005 11:49:09 -0700
Message-ID: <20050405184909.GA21137@synergymicro.com>
References: <66F9227F7417874C8DB3CEB057727417045051@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from renfield.synergymicro.com ([207.158.54.5]:36509 "EHLO
	renfield.synergymicro.com") by vger.kernel.org with ESMTP
	id S261917AbVDEStT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Apr 2005 14:49:19 -0400
Content-Disposition: inline
In-Reply-To: <66F9227F7417874C8DB3CEB057727417045051@MILEX0.Miltope.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Drew Winstel <DWinstel@Miltope.com>
Cc: linux-ide@vger.kernel.org


I tried this patch:

http://www.us.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.30-pre3-libata1.patch.gz

But no joy, I'm curious in that I do not see explicit support for the
3124 controller within the patch.  The patch did work against the 3112
device with this patch.

-robb

On Tue, Apr 05, 2005 at 12:25:39PM -0500, Drew Winstel wrote:
> Robb,
> 
> Download the libata patch for your particular kernel version at 
> http://www.us.kernel.org/pub/linux/kernel/people/jgarzik/libata/
> 
> Drew
> 
> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org
> [mailto:linux-ide-owner@vger.kernel.org]On Behalf Of Rob Baxter
> Sent: Tuesday, April 05, 2005 9:46 AM
> To: linux-ide@vger.kernel.org
> Subject: Silicon Image 3124 SATA driver
> 
> 
> 
> I have a Sil 3124 that I would like to try.  Where can I find the patch?
> 
> Either a patch for 2.4 or 2.6 will work.
> 
> -robb
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
