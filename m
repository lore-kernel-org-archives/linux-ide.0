From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] drivers: pata_octeon_cf : Switch IO mode depending
 on model number
Date: Fri, 8 Jan 2016 10:30:49 -0500
Message-ID: <20160108153049.GN1898@mtj.duckdns.org>
References: <1452230332-14926-1-git-send-email-danielwa@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35576 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621AbcAHPav (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jan 2016 10:30:51 -0500
Content-Disposition: inline
In-Reply-To: <1452230332-14926-1-git-send-email-danielwa@cisco.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Walker <danielwa@cisco.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Anil Veliyankara Madam <aveliyan@cisco.com>, xe-kernel@external.cisco.com, Shikha Jain <shikjain@cisco.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Daniel.

On Thu, Jan 07, 2016 at 09:18:51PM -0800, Daniel Walker wrote:
> From: Anil Veliyankara Madam <aveliyan@cisco.com>
> 
> Since viking flash has a problem in the MWDMA mode which causes data
> corruption, this patch allows the driver to detect the model number
> and switch the IO mode to PIO6 if it's a viking flash.

Hmmm... is this specific to pata_octeon_cf or should it apply to the
device regardless of the controller in use?

Thanks.

-- 
tejun
