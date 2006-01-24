From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATCH convert libata-core to the new debugging scheme
Date: Tue, 24 Jan 2006 14:47:41 -0500
Message-ID: <20060124194741.GG23269@havoc.gtf.org>
References: <20060124194343.GB25402@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:6553 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965002AbWAXTrp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 14:47:45 -0500
Content-Disposition: inline
In-Reply-To: <20060124194343.GB25402@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com, randy_d_dunlap@linux.intel.com

On Tue, Jan 24, 2006 at 08:43:43PM +0100, Borislav Petkov wrote:
> for the debugging macros which to me _is_ kinda too much. In addition, the
> ata_msg_xxx() macros are going to be pretty useless if we wrap them one more
> time into other macros but this is only my opinion.

Yes, I like the current stuff, and am not really interested in further
macros.

	Jeff



