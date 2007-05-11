From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 09/20] Add the combined mode for ATI SB700
Date: Fri, 11 May 2007 18:16:24 -0400
Message-ID: <4644EB38.5040909@garzik.org>
References: <200705110548.l4B5mo0P007639@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43677 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756543AbXEKWQ1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2007 18:16:27 -0400
In-Reply-To: <200705110548.l4B5mo0P007639@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, henry.su@amd.com, htejun@gmail.com, luugi.marsan@amd.com

akpm@linux-foundation.org wrote:
> From: "Henry Su" <henry.su@amd.com>
> 
> Besides those modes in ATI SB600 SATA controller, ATI SB700 supports one
> more mode:the combined mode.
> 
> The combined mode is a Legacy IDE mode used for compatibility with some old
> OS without AHCI driver, but now it is not necessary for Linux since the
> kernel has supported AHCI.
> 
> Signed-off-by: Luugi Marsan <luugi.marsan@amd.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/pci/quirks.c    |    1 +
>  include/linux/pci_ids.h |    1 +
>  2 files changed, 2 insertions(+)

applied


