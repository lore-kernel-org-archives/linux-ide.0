From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFC] AHCI Command Completion Coalescing(CCC) proposal
Date: Fri, 09 Jun 2006 14:24:18 +0900
Message-ID: <44890602.90002@gmail.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>	 <44883BAE.7070406@pobox.com>	 <1149820043.5721.7.camel@forrest26.sh.intel.com>	 <4488EB4A.4050501@pobox.com> <4488EE69.7050907@gmail.com>	 <4488EF64.9070602@gmail.com> <1149825065.5721.22.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:5457 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965173AbWFIFYY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Jun 2006 01:24:24 -0400
Received: by py-out-1112.google.com with SMTP id x31so854322pye
        for <linux-ide@vger.kernel.org>; Thu, 08 Jun 2006 22:24:24 -0700 (PDT)
In-Reply-To: <1149825065.5721.22.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Fri, 2006-06-09 at 12:47 +0900, Tejun Heo wrote:
>> If we're gonna do it.  EH needs only a few changes probably during 
>> autopsy and report.  Fixing up command issue path and implementing 
>> command exclusion (NCQ vs. non-NCQ, sil24 does it in hardware, ahci 
>> doesn't) will be a bit complex though.
> 
> Would you please elaborate on command exclusion? Why NCQ commands need
> to be excluded from non-NCQ commands?

AHCI spec rev 1.1, sect 1.7.  The last paragraph says.

"This multiple-use of the command list is achieved by the HBA only 
moving its command list pointer when the BSY, DRQ, and ERR bits are 
cleared by the device. System software is responsible to ensure that 
queued and non-queued commands are not mixed in the command list."

-- 
tejun
