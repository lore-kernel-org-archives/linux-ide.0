From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: HPA patches
Date: Fri, 23 Mar 2007 20:56:53 +0000
Message-ID: <20070323205652.GA9965@srcf.ucam.org>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:45699 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992571AbXCWU5F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2007 16:57:05 -0400
Content-Disposition: inline
In-Reply-To: <20070323191321.5d00887a@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

On Fri, Mar 23, 2007 at 07:13:21PM +0000, Alan Cox wrote:
> +static int ata_ignore_hpa = 0;
> +module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
> +MODULE_PARM_DESC(ignore_hpa, "Ignore HPA (0=off 1=on)");

I'm not sure I like the language here. "Ignore HPA" appears to mean 
"Explicitly disable the HPA", which I guess is one interpretation of 
"ignore" - however, naively I'd expect "Ignore HPA" to mean "Don't touch 
the HPA" with the result that it would remain inaccessible to userspace.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
