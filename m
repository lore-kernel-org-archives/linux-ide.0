From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: qoriq: fixed using uninitialized variable warnings
Date: Mon, 14 Sep 2015 12:00:41 -0400
Message-ID: <20150914160041.GD20047@mtj.duckdns.org>
References: <1441790182-20248-1-git-send-email-Yuantian.Tang@freescale.com>
 <DM2PR03MB574B7F5FBB2844161CD7482FA5D0@DM2PR03MB574.namprd03.prod.outlook.com>
 <20150914065432.GA25168@wfg-t540p.sh.intel.com>
 <4524877.YJljz8o2LZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35270 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbbINQAp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Sep 2015 12:00:45 -0400
Content-Disposition: inline
In-Reply-To: <4524877.YJljz8o2LZ@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Fengguang Wu <fengguang.wu@intel.com>, Yuantian Tang <Yuantian.Tang@freescale.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hello, Arnd.

On Mon, Sep 14, 2015 at 09:45:33AM +0200, Arnd Bergmann wrote:
> In general, we really want to leave drivers with a COMPILE_TEST dependency
> so they at least get cross-built on x86, ideally on all architectures.

Yeah, as long as it doesn't trigger silly warnings or errors on x86,
COMPILE_TEST is usually a good idea.

> Does something like the below help? I think we really just need to help
> gcc a little to see the obvious.

We already tried cachine qoriq_priv->type in a local.  Not sure this
would make much difference.  It looks like the warning goes away with
newer gcc.  I'm inclined to just leave it as-is.

Thanks.

-- 
tejun
