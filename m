From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: A question about NCQ
Date: Tue, 16 May 2006 18:01:29 +0800
Message-ID: <1147773689.7273.88.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13677 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751741AbWEPKMb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 06:12:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hi, Tejun

Since your NCQ patches were pushed into #upstream, I decide to compare
the performance between with and without NCQ enabling.

But initial test result of running iozone with O_DIRECT option turned on
didn't show the visible performance gain with NCQ. In certain cases, NCQ
even had a worse performance than without NCQ.

So my question is in what usage case can we observe the performance gain
with NCQ?

Thanks,
Forrest
