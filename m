From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/1] ahci: imx: Add imx53 SATA temperature sensor
 support
Date: Fri, 6 Jan 2017 15:35:43 -0500
Message-ID: <20170106203543.GA29909@mtj.duckdns.org>
References: <2364981.7VqghJWO9f@amdc3058>
 <1477426087-20263-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35702 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752610AbdAFUfu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jan 2017 15:35:50 -0500
Content-Disposition: inline
In-Reply-To: <1477426087-20263-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, Csaba Kertesz <csaba.kertesz@vincit.fi>

On Tue, Oct 25, 2016 at 10:08:07PM +0200, Fabien Lahoudere wrote:
> From: Csaba Kertesz <csaba.kertesz@vincit.fi>
> 
> Add a hwmon entry to get the temperature from the die of imx53
> SATA.
> 
> The original patch was made by Richard Zhu for kernel 2.6.x:
> ENGR00134041-MX53-Add-the-SATA-AHCI-temperature-monitor.patch
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>

Applied to libata/for-4.11.

Thanks.

-- 
tejun
