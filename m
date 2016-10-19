From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/1] ahci: imx: Add imx53 SATA temperature sensor
 support
Date: Wed, 19 Oct 2016 13:31:37 -0400
Message-ID: <20161019173137.GE18532@htj.duckdns.org>
References: <1476699520-29531-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33525 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938820AbcJSRbk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2016 13:31:40 -0400
Content-Disposition: inline
In-Reply-To: <1476699520-29531-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Csaba Kertesz <csaba.kertesz@vincit.fi>

On Mon, Oct 17, 2016 at 12:18:40PM +0200, Fabien Lahoudere wrote:
> From: Csaba Kertesz <csaba.kertesz@vincit.fi>
> 
> Add a hwmon entry to get the temperature from the die of imx53
> SATA.
> 
> The original patch was made by Richard Zhu for kernel 2.6.x:
> ENGR00134041-MX53-Add-the-SATA-AHCI-temperature-monitor.patch
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>

Looks fine to me but can you please cc someone familiar with thermal
driver so that we can get an ack from them?

Thanks.

-- 
tejun
