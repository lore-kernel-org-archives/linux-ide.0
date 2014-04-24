From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 0/3] ahci: add support for hisilicon sata
Date: Thu, 24 Apr 2014 08:28:08 -0400
Message-ID: <20140424122808.GL4781@htj.dyndns.org>
References: <1398256603-20160-1-git-send-email-kefeng.wang@linaro.org>
 <20140423142726.GC4781@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:53780 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbaDXM2X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2014 08:28:23 -0400
Content-Disposition: inline
In-Reply-To: <20140423142726.GC4781@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kefeng Wang <kefeng.wang@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com

On Wed, Apr 23, 2014 at 10:27:26AM -0400, Tejun Heo wrote:
> Applied to libata/for-3.16.

Reverted due to build failure.  I was apparently too dependent on
build-bot but what the hell?  This isn't acceptable.

-- 
tejun
