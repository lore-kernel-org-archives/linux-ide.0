From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Fri, 12 May 2006 13:02:39 +0800
Message-ID: <1147410159.7273.52.camel@forrest26.sh.intel.com>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com>
	 <4462F667.3060504@gmail.com>  <4462F767.5070003@gmail.com>
	 <1147340790.7273.47.camel@forrest26.sh.intel.com>
	 <44631446.1060401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46674 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750912AbWELFN2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 May 2006 01:13:28 -0400
In-Reply-To: <44631446.1060401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Thu, 2006-05-11 at 19:39 +0900, Tejun Heo wrote:
> Can you try the
> current #upstream and see how that works?  So that we can see whether
> the EH changes caused the problem?
I tried the #upstream, the ata_piix of which can't resume from S3 on T43P either.
So the code changes between 2.6.16-rc6 and #upstream caused the problem.
I'll post the dmesg in the following mails.

Thanks,
Forrest
