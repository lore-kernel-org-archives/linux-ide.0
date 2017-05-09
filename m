From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1] ata: sata_rcar: Handle return value of
 clk_prepare_enable
Date: Tue, 9 May 2017 10:31:18 -0400
Message-ID: <20170509143118.GC8609@htj.duckdns.org>
References: <1494325828-2725-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f175.google.com ([209.85.213.175]:35797 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbdEIObV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 May 2017 10:31:21 -0400
Content-Disposition: inline
In-Reply-To: <1494325828-2725-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 09, 2017 at 04:00:28PM +0530, Arvind Yadav wrote:
> Here, Clock enable can failed. So adding an error check for
> clk_prepare_enable.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to libata/for-4.12-fixes w/ a couple trivial changes.

Thanks.

-- 
tejun
