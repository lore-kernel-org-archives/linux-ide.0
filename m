From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata queue contents
Date: Wed, 01 Mar 2006 22:31:40 -0500
Message-ID: <4406671C.2060209@pobox.com>
References: <20060301203901.GA6915@havoc.gtf.org>	<44063E09.1060303@rtr.ca> <20060301192740.1172e579.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:64151 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932201AbWCBDbn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 22:31:43 -0500
In-Reply-To: <20060301192740.1172e579.rdunlap@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Mark Lord <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Wed, 01 Mar 2006 19:36:25 -0500 Mark Lord wrote:
> 
> 
>>Jeff Garzik wrote:
>>
>>>Here's the stuff that's pending for 2.6.17, in the
>>>libata-dev.git#upstream branch.  These changes are also auto-propagated
>>>to Andrew Morton's -mm via the #ALL meta-branch.
>>
>>Where are Randy's ACPI patches ?
> 
> 
> I haven't generated them against #upstream.  I'll try to do that
> in the next couple of days (assuming that I can git along with git).
> or can I use the git-rollup patch in -mm to diff against?

git-libata-all.patch in -mm is #upstream plus other stuff.  For the time 
being, for testing and current deployment, diffing against 
git-libata-all.patch, and sending the result to akpm, is probably the 
best route, and will get you quite close to #upstream.

	Jeff



