From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: sata_via (pata): problems when write cache is disabled
Date: Thu, 3 May 2007 15:23:27 +0200
Message-ID: <20070503132327.GH28116@deprecation.cyrius.com>
References: <20070429105001.GA4530@deprecation.cyrius.com> <4635BC42.6020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:4288 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754060AbXECNXq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 May 2007 09:23:46 -0400
Content-Disposition: inline
In-Reply-To: <4635BC42.6020201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, "Williams, Dan J" <dan.j.williams@intel.com>

* Tejun Heo <htejun@gmail.com> [2007-04-30 11:52]:
> I doubt it's the driver's fault.  It's more likely actual wiring
> problem.
...
> The difference between the first two and the last one might be that the
> last one is just more tolerant about degraded signals.  (e.g. some of
> latest PATA drives can do UDMA/100 on 40c cable w/o any problem).

The cable is quite old, so that's possible.  Unfortuately, I don't
have another PATA cable to test.  If the problem persists once I can
try another cable, I'll let you know.
-- 
Martin Michlmayr
http://www.cyrius.com/
