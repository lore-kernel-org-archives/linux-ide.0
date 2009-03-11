From: Tejun Heo <tj@kernel.org>
Subject: Re: ATAPI question
Date: Wed, 11 Mar 2009 18:31:11 +0900
Message-ID: <49B784DF.1090802@kernel.org>
References: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCE7C7@azsmsx504.amr.corp.intel.com> <49A8AAC6.2090201@gmail.com> <49AA84E4.3050108@kernel.org> <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCEDF6@azsmsx504.amr.corp.intel.com> <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3057418@azsmsx504.amr.corp.intel.com> <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3057D00@azsmsx504.amr.corp.intel.com> <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3215B07@azsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44554 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbZCKJar (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 05:30:47 -0400
In-Reply-To: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3215B07@azsmsx504.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Foster, Doug F" <doug.f.foster@intel.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

Foster, Doug F wrote:
> Did anyone get a chance to look at these traces?
> Any thoughts on what the problem is?
> Any guidance on experiments that I should try?
> Is there anything else that I can provide to help?

Yeap, I just did.  I'm looking at ATAPI_7_LiteOn.sas.  The offending
one is the one ending with the FIS 22.723 807 202, right?

On the bus level, everything seems fine.  The host prepares for
96bytes transfer and device does it and successfully sends D2H Reg FIS
for command completion.  The only thing I can think of is the draining
buffer confusing the controller somehow.  If you make
libata-scsi.c::atapi_drain_needed() always return zero, does anything
change?

Thanks.

-- 
tejun
