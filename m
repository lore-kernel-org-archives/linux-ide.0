From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH 1/1] - sgiioc4: fixup use of mmio ops
Date: Wed, 19 Jul 2006 22:19:29 -0700
Message-ID: <20060720051929.GB763333@sgi.com>
References: <20060719153155.30856.2479.sendpatchset@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:26854 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932567AbWGTFTa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Jul 2006 01:19:30 -0400
Content-Disposition: inline
In-Reply-To: <20060719153155.30856.2479.sendpatchset@attica.americas.sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Keller <jpk@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Jul 19, 2006 at 10:31:55AM -0500, John Keller wrote:
> Resend #2 changes include:
> 
> - use 'void __iomem *' for ioremap() return values,
>   and handle error cases.
> 
> sgiioc4.c had been recently converted to using mmio ops.
> There are still a few issues to cleanup.
> 
> Signed-off-by: jpk@sgi.com
Signed-off-by: jeremy@sgi.com
