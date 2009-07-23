From: Mark Lord <liml@rtr.ca>
Subject: Re: NCQ is slower in some cases?
Date: Thu, 23 Jul 2009 11:39:21 -0400
Message-ID: <4A688429.50800@rtr.ca>
References: <1248320643.9035.19.camel@sli10-desk.sh.intel.com> <4A67E0AA.6060405@pobox.com> <20090723054804.GB7473@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:55398 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbZGWPjW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jul 2009 11:39:22 -0400
In-Reply-To: <20090723054804.GB7473@sli10-desk.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>, "Zhang, Yanmin" <yanmin.zhang@intel.com>

Shaohua Li wrote:
>
> I just occasionally did the test and hadn't resource to do a full test.
> I tested two hard disks (one from WDC the other Seegate), both have the
> same behavior. If it's possible hardware will slower with NCQ in some
> cases, I'll not borther spending time on it any more.
> So can you guys suggest if the issue is related with hardware?
..

WD Raptor drives were one of the known "slower with NCQ" drives,
except for random I/O of course.

Cheers
