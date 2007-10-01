From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch] SB700 contains more than one IDE channel
Date: Mon, 1 Oct 2007 23:04:01 +0200
Message-ID: <200710012304.01744.bzolnier@gmail.com>
References: <5CAB7B5D6F8AB84AA868A46B47A5070544C164@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:61343 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbXJAVjd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:33 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977009ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:31 -0700 (PDT)
In-Reply-To: <5CAB7B5D6F8AB84AA868A46B47A5070544C164@sshaexmb1.amd.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <Shane.Huang@amd.com>
Cc: linux-ide@vger.kernel.org, gregkh@suse.de, "Su, Henry" <Henry.Su@amd.com>

On Thursday 27 September 2007, Shane Huang wrote:
> From: shane.huang@amd.com
> 
> SB700 supports one physical IDE channel, but SB700 SATA controller
> supports combined mode. When the SATA combined mode is enabled,
> two SATA ports(port4 and port5) share one IDE channel from IDE
> controller, and PATA will share the other IDE channel.
> 
> Our previous patch adding SB700 IDE device ID only support one
> IDE channel, which contains bug. The attached patch fix the bug.
> 
> 
> Signed-off-by: shane.huang@amd.com

applied

The inlined patch was word-wrapped and the attached one lacked patch
description so manual fixing was required anyway.  Not a big problem
but next time please try to use some known-to-be-good mail client to
inline patches.

Thanks,
Bart
