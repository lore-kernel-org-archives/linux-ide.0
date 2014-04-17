From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/2] ahci: Tweaks to the driver's PCI function
Date: Thu, 17 Apr 2014 10:00:41 -0400
Message-ID: <20140417140041.GF15326@htj.dyndns.org>
References: <cover.1397736364.git.agordeev@redhat.com>
 <20140417132806.GA15326@htj.dyndns.org>
 <20140417123618.GB2270@dhcp-26-207.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:55967 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbaDQOAp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Apr 2014 10:00:45 -0400
Content-Disposition: inline
In-Reply-To: <20140417123618.GB2270@dhcp-26-207.brq.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Apr 17, 2014 at 02:36:18PM +0200, Alexander Gordeev wrote:
> > Applied to libata/for-3.15-fixes.
> 
> Oh-oh.
> It seems the changelog's demo patch portion applied to the source.

Urgh... fixed it.  Please don't include proper patch in the
description.  It'll mess up a lot of people's workflow.

Thanks.

-- 
tejun
