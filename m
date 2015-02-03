From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: libahci: Use of_platform_device_create only if
 supported
Date: Tue, 3 Feb 2015 07:13:25 -0500
Message-ID: <20150203121325.GD19463@htj.dyndns.org>
References: <1422729382-20150-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:59499 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933558AbbBCMN3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Feb 2015 07:13:29 -0500
Content-Disposition: inline
In-Reply-To: <1422729382-20150-1-git-send-email-linux@roeck-us.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>

On Sat, Jan 31, 2015 at 10:36:22AM -0800, Guenter Roeck wrote:
> of_platform_device_create does not exist if OF_ADDRESS is not configured,
> so limit its use accordingly.
> 
> Without this fix, the sparc64:allmodconfig build fails with
> 
> ERROR: "of_platform_device_create" [drivers/ata/libahci_platform.ko] undefined!
> 
> Fixes: c7d7ddee7e24 ("ata: libahci: Allow using multiple regulators")
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to libata/for-3.20.

Thanks.

-- 
tejun
