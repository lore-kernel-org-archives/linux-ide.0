From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] ata: endianness annotations in pata drivers
Date: Thu, 19 Jun 2008 00:33:32 +0100
Message-ID: <20080618233332.GN28946@ZenIV.linux.org.uk>
References: <1213829582.2125.24.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:46746 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbYFRXdg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2008 19:33:36 -0400
Content-Disposition: inline
In-Reply-To: <1213829582.2125.24.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>

On Wed, Jun 18, 2008 at 03:53:02PM -0700, Harvey Harrison wrote:
>  			if (rw == WRITE) {
>  				memcpy(&pad, buf + buflen - slop, slop);
> -				pad = le32_to_cpu(pad);
> +				le32_to_cpus(&pad);
Ewww....
>  				iowrite32(pad, ap->ioaddr.data_addr);

What's wrong with
  				iowrite32(le32_to_cpu(pad),
					  ap->ioaddr.data_addr);
instead of that crap?

>  				pad = ioread32(ap->ioaddr.data_addr);
> -				pad = cpu_to_le32(pad);
> +				cpu_to_le32s(pad);

pad = cpu_to_le32(ioread32(....))
