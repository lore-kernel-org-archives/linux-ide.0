From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.23-rc4] sata_promise: FastTrack TX4200 is a second-generation
 chip
Date: Fri, 31 Aug 2007 04:15:07 -0400
Message-ID: <46D7CE0B.5050806@garzik.org>
References: <200708290825.l7T8PbYL016964@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44113 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755982AbXHaIPM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 04:15:12 -0400
In-Reply-To: <200708290825.l7T8PbYL016964@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, sziemba@ecn.purdue.edu

Mikael Pettersson wrote:
> This patch corrects sata_promise to classify FastTrack TX4200
> (DID 3515/3519) as a second-generation chip. Promise's partial-
> source FT TX4200 driver confirms this classification.
> 
> Treating it as a first-generation chip causes several problems:
> 1. Detection failures. This is a recent regression triggered by
>    the hotplug-enabling changes in 2.6.23-rc1.
> 2. Various "failed to resume link for reset" warnings.
> 
> This patch fixes <http://bugzilla.kernel.org/show_bug.cgi?id=8936>.
> 
> Thanks to Stephen Ziemba for reporting the bug and for testing the fix.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> Tested-by: Stephen Ziemba <sziemba@ecn.purdue.edu>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> This patch is identical to the one Stephen tested, I've
> just updated the description.
> 
>  drivers/ata/sata_promise.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

applied


