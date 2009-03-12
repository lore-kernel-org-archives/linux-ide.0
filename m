From: "Foster, Doug F" <doug.f.foster@intel.com>
Subject: RE: ATAPI question
Date: Thu, 12 Mar 2009 14:02:30 -0700
Message-ID: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F32F8895@azsmsx504.amr.corp.intel.com>
References: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCE7C7@azsmsx504.amr.corp.intel.com>
 <49A8AAC6.2090201@gmail.com> <49AA84E4.3050108@kernel.org>
 <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCEDF6@azsmsx504.amr.corp.intel.com>
 <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3057418@azsmsx504.amr.corp.intel.com>
 <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3057D00@azsmsx504.amr.corp.intel.com>
 <3EAC55E3B6CF7348B3E2CAB2774ADA0403F3215B07@azsmsx504.amr.corp.intel.com>
 <49B784DF.1090802@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9596 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755829AbZCLVCd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Mar 2009 17:02:33 -0400
In-Reply-To: <49B784DF.1090802@kernel.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Foster, Doug F" <doug.f.foster@intel.com>

Tejun wrote:
Yeap, I just did.  I'm looking at ATAPI_7_LiteOn.sas.  The offending
one is the one ending with the FIS 22.723 807 202, right?

On the bus level, everything seems fine.  The host prepares for
96bytes transfer and device does it and successfully sends D2H Reg FIS
for command completion.  The only thing I can think of is the draining
buffer confusing the controller somehow.  If you make
libata-scsi.c::atapi_drain_needed() always return zero, does anything
change?

++++++++++++++++++++
Tejun,

The problem occurs in 2.6.18.8 which doesn't have atapi_drain_needed() and in 2.6.28.7 which does.  I had atapi_drain_needed() return zero on 2.6.28.7 with no change in behavior.

If you click the ATA button (ATA application layer) on the above trace and expand the IN and OUT boxes on transaction 22.723 597 590, you see the DRDY, SERV, I/O, C/D pattern that I described before.  Does this pattern make sense in this context?  Do you think that this pattern is of concern or should we be looking elsewhere for the problem?

Doug
