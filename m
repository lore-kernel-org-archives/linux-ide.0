From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] AHCI Command Completion Coalescing(CCC) proposal
Date: Fri, 09 Jun 2006 00:12:41 -0400
Message-ID: <4488F539.4010501@pobox.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>	 <44883BAE.7070406@pobox.com>	 <1149820043.5721.7.camel@forrest26.sh.intel.com>	 <4488EB4A.4050501@pobox.com> <4488EE69.7050907@gmail.com>	 <4488EF64.9070602@gmail.com> <1149825065.5721.22.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:15078 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965062AbWFIEMp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jun 2006 00:12:45 -0400
In-Reply-To: <1149825065.5721.22.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Fri, 2006-06-09 at 12:47 +0900, Tejun Heo wrote:
>> If we're gonna do it.  EH needs only a few changes probably during 
>> autopsy and report.  Fixing up command issue path and implementing 
>> command exclusion (NCQ vs. non-NCQ, sil24 does it in hardware, ahci 
>> doesn't) will be a bit complex though.
> 
> Would you please elaborate on command exclusion? Why NCQ commands need
> to be excluded from non-NCQ commands?

For one thing, getting the command ordering right (particularly with 
regards to barriers) isn't trivial...  also, you need exclusion for 
major feature changes like set xfer mode.

	Jeff



