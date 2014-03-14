From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] ata: ahci_st: remove deprecated struct
 ahci_platform_data usage
Date: Fri, 14 Mar 2014 14:27:22 -0400
Message-ID: <20140314182722.GA6843@mtj.dyndns.org>
References: <1561239.uqrRD3ZCZp@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:65210 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbaCNS10 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Mar 2014 14:27:26 -0400
Content-Disposition: inline
In-Reply-To: <1561239.uqrRD3ZCZp@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Mar 14, 2014 at 07:21:59PM +0100, Bartlomiej Zolnierkiewicz wrote:
> struct ahci_platform_data is deprecated (please see comments in
> <linux/ahci_platform.h> for details).  Convert ahci_st driver to
> use custom ->host_stop method instead.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to 1-2 to libata/for-3.15.

Hmm... I'll wait for your reviews from now on.

Thanks.

-- 
tejun
