From: Tejun Heo <tj@kernel.org>
Subject: Re: Power-up-in-standby Hitachi 5K3000 fails with either sata_sil24
 or pmp, but not direct to AHCI controllers
Date: Fri, 10 Jun 2011 12:25:50 +0200
Message-ID: <20110610102550.GF15235@htj.dyndns.org>
References: <4DF0C797.201@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46388 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab1FJKZy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2011 06:25:54 -0400
Received: by fxm17 with SMTP id 17so1522233fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2011 03:25:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DF0C797.201@seoss.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@seoss.co.uk>
Cc: linux-ide@vger.kernel.org

Hello,

On Thu, Jun 09, 2011 at 02:16:07PM +0100, Tim Small wrote:
> ... if I then didn't power down the drive, but instead attached it
> to the Marvell controller, it didn't come back, so I'd guess the
> interaction with the 3124 has wedged the drive permanently.

Heh, that's interesting.  The feature isn't very well tested and it
wouldn't be too surprising if there are some bugs on all sides
(driver, controller and drive firmware).  Can you please try with a
drive from a different vendor and see whether it fares any
differently?

Thanks.

-- 
tejun
