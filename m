From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2 v4] sata highbank: add bit-banged SGPIO driver support
Date: Thu, 6 Jun 2013 14:06:20 -0700
Message-ID: <20130606210620.GE5045@htj.dyndns.org>
References: <1369945051-2582-2-git-send-email-mark.langsdorf@calxeda.com>
 <1370523161-32449-1-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:57266 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab3FFVGX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jun 2013 17:06:23 -0400
Content-Disposition: inline
In-Reply-To: <1370523161-32449-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org

On Thu, Jun 06, 2013 at 07:52:41AM -0500, Mark Langsdorf wrote:
> Highbank supports SGPIO by bit-banging out the SGPIO signals over
> three GPIO pins defined in the DTB. Add support for this SGPIO
> functionality.
> 
> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>

Applied to libata/for-3.11.  Thanks!

-- 
tejun
