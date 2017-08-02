From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 005/102] ata: sata_gemini: explicitly request exclusive
 reset control
Date: Wed, 2 Aug 2017 08:15:10 -0700
Message-ID: <20170802151509.GD2311718@devbig577.frc2.facebook.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719152646.25903-6-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34190 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbdHBPPN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Aug 2017 11:15:13 -0400
Content-Disposition: inline
In-Reply-To: <20170719152646.25903-6-p.zabel@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-ide@vger.kernel.org

On Wed, Jul 19, 2017 at 05:25:09PM +0200, Philipp Zabel wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
> 
> No functional changes.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied to libata/for-4.14.

Thanks.

-- 
tejun
