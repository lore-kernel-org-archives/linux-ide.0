From: Tejun Heo <tj@kernel.org>
Subject: Re: [stable] [PATCH #upstream-fixes] sata_nv: disable hardreset	for
 generic
Date: Thu, 02 Oct 2008 09:22:31 +0900
Message-ID: <48E41447.6000103@kernel.org>
References: <4895407B.5030602@kernel.org> <48B803F8.8000306@kernel.org> <48C57A4A.2050303@kernel.org> <20081001232211.GA31609@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56456 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbYJBA02 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Oct 2008 20:26:28 -0400
In-Reply-To: <20081001232211.GA31609@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux@sun7.cn, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>, stable@kernel.org

Greg KH wrote:
> On Mon, Sep 08, 2008 at 09:17:30PM +0200, Tejun Heo wrote:
>> Tejun Heo wrote:
>>> From 2.6.26, libata is defaulting to hardreset for various reasons one
>>> of them being unifying probing, hotplug and EH reset paths uniform.
>>> Previously, broken hardreset could go unnoticed as it wasn't used
>>> during probing but when something goes wrong or after hotplug the
>>> problem will surface and bite hard.
>>>
>>> OSDL bug 11195 reports that sata_nv generic flavor falls into this
>>> category.  Hardreset itself succeeds but PHY stays offline after
>>> hardreset.  I tried longer debounce timing but the result was the
>>> same.
>>>
>>>   http://bugzilla.kernel.org/show_bug.cgi?id=11195
>>>
>>> So, it seems we'll have to drop hardreset from the generic flavor.
>>>
>>> Signed-off-by: Tejun Heo <tj@kernel.org>
>>> Cc: Peer Chen <pchen@nvidia.com>
>> This one definitely should go into -stable too.  The original patch is...
>>
>> http://article.gmane.org/gmane.linux.ide/34077/raw
> 
> Now applied, thanks.

Greg, can you please hold a bit before releasing this?  This patch
accidentally disables hardreset for all flavors of nv controllers which
causes problems for ck804.  A later patch to only apply it to generic
went in but it then broke nf2 flavor, so it seems generic and nf2
require this workaround but ck804 doesn't like the workaround.  I've
asked a reporter to test to apply the workaround only to generic and nf2
and will forward the third patch as soon as it's confirmed.  So, please
wait till the third one is ready.

Thanks.

-- 
tejun
