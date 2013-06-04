From: Tejun Heo <tj@kernel.org>
Subject: Re: drivers/ata/sata_rcar.c:183:2: warning: large integer implicitly
 truncated to unsigned type
Date: Mon, 3 Jun 2013 18:46:44 -0700
Message-ID: <20130604014644.GG29989@mtj.dyndns.org>
References: <51a59c1b.AMyrU/XAl1VcZ02t%fengguang.wu@intel.com>
 <20130529072447.GC12650@localhost>
 <20130604014521.GN23054@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:33559 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758919Ab3FDBqv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jun 2013 21:46:51 -0400
Content-Disposition: inline
In-Reply-To: <20130604014521.GN23054@verge.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Fengguang Wu <fengguang.wu@intel.com>, kbuild-all@01.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-ide@vger.kernel.org, Vladimir Barinov <vladimir.barinov@cogentembedded.com>

On Tue, Jun 04, 2013 at 10:45:21AM +0900, Simon Horman wrote:
> Hi Sergei, Hi Vladimir,
> 
> could you look into a fix for this?
> 
> I believe that it is a result of my patch "libata: do not limit R-Car SATA
> driver to shmobile", which now allows the R-Car SATA driver to be compiled
> for a (much) wider range of hardware.

Already fixed in libata/for-3.11.  Hmmm.... I'll move it into
for-3.10-fixes and push to Linus in a week or so.

Thanks.

-- 
tejun
