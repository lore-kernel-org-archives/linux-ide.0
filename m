From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide-cd: Do not access completed requests in the irq
 handler
Date: Mon, 05 Jul 2010 21:24:05 -0700 (PDT)
Message-ID: <20100705.212405.232923099.davem@davemloft.net>
References: <20100703094918.03007437@cbook.fritz.box>
	<20100703082304.GA25293@liondog.tnic>
	<20100703110104.GB25293@liondog.tnic>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:45503
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750889Ab0GFEXw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jul 2010 00:23:52 -0400
In-Reply-To: <20100703110104.GB25293@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bp@alien8.de
Cc: akpm@linux-foundation.org, hans42mueller@googlemail.com, linux-ide@vger.kernel.org

From: Borislav Petkov <bp@alien8.de>
Date: Sat, 3 Jul 2010 13:01:04 +0200

> this came out as a by-product after debugging
> https://bugzilla.kernel.org/show_bug.cgi?id=16142
> 
> It fixes the oops at
> https://bugzilla.kernel.org/attachment.cgi?id=26776, please apply.
> 
> --
> From: Borislav Petkov <bp@alien8.de>
> Date: Fri, 2 Jul 2010 09:08:09 +0200
> Subject: [PATCH] ide-cd: Do not access completed requests in the irq handler
> 
> ide_cd_error_cmd() can complete an erroneous request with leftover
> buffers. Signal this with its return value so that the request is not
> accessed after its completion in the irq handler and we oops.
> 
> Cc: <stable@kernel.org> # 32.x 33.x 34.x
> Signed-off-by: Borislav Petkov <bp@alien8.de>

Applied, thanks Borislav.
