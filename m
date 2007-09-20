From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 05/25] ata: add the SW NCQ support to sata_nv for MCP51/MCP55/MCP61
Date: Thu, 20 Sep 2007 18:40:37 -0400
Message-ID: <46F2F6E5.3010406@garzik.org>
References: <200708102059.l7AKxYVQ008581@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36175 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbXITWko (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Sep 2007 18:40:44 -0400
In-Reply-To: <200708102059.l7AKxYVQ008581@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org, kluo@nvidia.com, pchen@nvidia.com, Robert Hancock <hancockr@shaw.ca>
Cc: linux-ide@vger.kernel.org, zboszor@dunaweb.hu

akpm@linux-foundation.org wrote:
> From: Kuan Luo <kluo@nvidia.com>
> 
> Add the Software NCQ support to sata_nv.c for MCP51/MCP55/MCP61 SATA
> controller.  NCQ function is disable by default, you can enable it with
> 'swncq=1'.  NCQ will be turned off if the drive is Maxtor on MCP51 or MCP55
> rev 0xa2 platform.
> 
> [akpm@linux-foundation.org: build fix]
> Signed-off-by: Kuan Luo <kluo@nvidia.com>
> Signed-off-by: Peer Chen <pchen@nvidia.com>
> Cc: Zoltan Boszormenyi <zboszor@dunaweb.hu>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/sata_nv.c |  860 +++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 851 insertions(+), 9 deletions(-)

I finally gave this a thorough review.

Overall, good work.  The state transitions all seem solid.  I made 
several minor changes and cleanups, and checked it into the 'nv-swncq' 
branch of 
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Two hurdles before I'm ready to push upstream:

* someone please verify my minor changes did not break anything; I don't 
have real hardware

* the pp->lock appears unnecessary at best, wrong at worst.  needs 
additional analysis.

