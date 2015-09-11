From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: qoriq: fixed using uninitialized variable warnings
Date: Fri, 11 Sep 2015 09:54:31 -0400
Message-ID: <20150911135431.GP8114@mtj.duckdns.org>
References: <1441790182-20248-1-git-send-email-Yuantian.Tang@freescale.com>
 <20150909140130.GB22909@mtj.duckdns.org>
 <DM2PR03MB5746E6637A2BC5081EC5428FA500@DM2PR03MB574.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:32945 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbbIKNyf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Sep 2015 09:54:35 -0400
Content-Disposition: inline
In-Reply-To: <DM2PR03MB5746E6637A2BC5081EC5428FA500@DM2PR03MB574.namprd03.prod.outlook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: "hdegoede@redhat.com" <hdegoede@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Fengguang Wu <fengguang.wu@intel.com>

Hello, Yuantian.

On Fri, Sep 11, 2015 at 05:27:25AM +0000, Yuantian Tang wrote:
> Hi Tejun,
> 
> Could you please take the version 1 patch?
> The version 2 patch can't address these warnings, and the version 1 can definitely remove them.
> In this case, that would cause any hidden bugs, so no worries.

Ugh... I really hate changes which are made to just work around
compiler silliness.  If this is something which goes away with newer
gcc, Fengguang can just make it as a known false positive.  Yuantian,
which compiler are you using?

Thanks.

-- 
tejun
