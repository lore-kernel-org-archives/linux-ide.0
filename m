From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 04/12] sata_rcar: Convert to clk_prepare/unprepare
Date: Tue, 29 Oct 2013 14:41:20 -0400
Message-ID: <20131029184120.GA21990@mtj.dyndns.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:50186 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab3J2SlZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Oct 2013 14:41:25 -0400
Content-Disposition: inline
In-Reply-To: <1383000569-8916-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-ide@vger.kernel.org

On Mon, Oct 28, 2013 at 11:49:21PM +0100, Laurent Pinchart wrote:
> Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> clk_disable_unprepare() to get ready for the migration to the common
> clock framework.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Applied to libata/for-3.13.

Thanks.

-- 
tejun
