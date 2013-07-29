From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/5] sata, highbank: fix ordering of SGPIO signals
Date: Mon, 29 Jul 2013 12:55:30 -0400
Message-ID: <20130729165530.GG22605@mtj.dyndns.org>
References: <1374851518-4802-1-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gg0-f180.google.com ([209.85.161.180]:36862 "EHLO
	mail-gg0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab3G2Qzg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jul 2013 12:55:36 -0400
Content-Disposition: inline
In-Reply-To: <1374851518-4802-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob.herring@calxeda.com

On Fri, Jul 26, 2013 at 10:11:54AM -0500, Mark Langsdorf wrote:
> The ACTIVITY and ERROR signals were reversed in the original commit.
> Fix that.

And what's the implication of this change?  Does this change the
behavior of the driver?  If so, how?  If not, why not?  *Please* be
more descriptive in patch descriptions and explain *why* the changes
are being made.

Thanks.

-- 
tejun
