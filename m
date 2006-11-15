From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
Date: Wed, 15 Nov 2006 17:20:52 +0100
Message-ID: <1163607653.31358.128.camel@laptopd505.fenrus.org>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
	 <4558BE57.4020700@cfl.rr.com>
	 <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>
	 <1163446372.15249.190.camel@laptopd505.fenrus.org>
	 <1163519125.2998.8.camel@de-c-l-110.nero-de.internal>
	 <455 <455B3A78.7010503@gmail.com>  <455B3D99.8040705@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:57492 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030648AbWKOQV2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 11:21:28 -0500
In-Reply-To: <455B3D99.8040705@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Tejun Heo <htejun@gmail.com>, Mathieu Fluhr <mfluhr@nero.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 11:17 -0500, Phillip Susi wrote:
> Tejun Heo wrote:
> >> The patch _seems_ to solve my problem. I am just really astonished when
> >> I read the diff file :D. Can I expect that it will be merged to the
> >> official kernel sources ?
> > 
> > It seems that some devices choke when the bytes after CDB contain 
> > garbage.  I seem to recall that I read somewhere ATAPI device require 
> > left command bytes cleared to zero but I can't find it anywhere now. 
> > Maybe I'm just imagining.  Anyways, yeah, I'll push it to upstream.
> > 
> 
> The original patch memsets the entire buffer only to copy over most of 
> it right after.  Could you amend the patch so that it memcpys first, 
> then memsets only the remainder of the buffer?  No sense wasting cpu 
> cycles.

due to the funnies of how cpu caches work it might not actually be
faster though... Write Allocate and things like that are.. well fun.



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

