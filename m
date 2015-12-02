From: Tejun Heo <tj@kernel.org>
Subject: Re: libata-core: devslp fails on ATP mSATA
Date: Wed, 2 Dec 2015 11:47:53 -0500
Message-ID: <20151202164753.GA19878@mtj.duckdns.org>
References: <20151201092234.GB29791@awelinux>
 <20151201161715.GA12922@mtj.duckdns.org>
 <20151201190410.GA21252@mtj.duckdns.org>
 <20151202093310.GE10207@awelinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34000 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758769AbbLBQr4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Dec 2015 11:47:56 -0500
Content-Disposition: inline
In-Reply-To: <20151202093310.GE10207@awelinux>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Werner <andreas.werner@men.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>, "Martin K. Petersen" <martin.petersen@oracle.com>

Hello, Andreas.

On Wed, Dec 02, 2015 at 10:33:10AM +0100, Andreas Werner wrote:
> Blacklisting the controller would be a solution yes, but I just
> wanna wait the answer from the FAE to be sure we really have a
> problem.
> 
> What kind of identifier can I use for blacklisting? The driver name
> from the host driver? (fsl-sata) I did not find any register
> in the sata controller to read out an ID.

Whatever matches the affected controllers.  If all sata_fsl
controllers are affected, the driver init code can set the flag
unconditionally.

Thanks.

-- 
tejun
