From: "Shane Huang" <Shane.Huang@amd.com>
Subject: RE: About forcing 32bit DMA patch for AMD690G(SB600)
Date: Thu, 31 Jan 2008 17:14:19 +0800
Message-ID: <B90463BC30D2E446BA423D888DC85E5020F11E@sshaexmb1.amd.com>
References: <B90463BC30D2E446BA423D888DC85E501BF3CB@sshaexmb1.amd.com>
 <47992BA3.3070104@gmail.com>
 <76366b180801242019h382fd604vd1458dab8b64dd4c@mail.gmail.com>
 <4799788E.1030600@gmail.com> <20080125205743.GA26124@lks.home>
 <479A8BDF.1090908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:15356 "EHLO
	outbound7-sin-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757454AbYAaJOj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jan 2008 04:14:39 -0500
Content-class: urn:content-classes:message
In-Reply-To: <479A8BDF.1090908@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Paprocki <andrew@ishiboo.com>, sriharivijayaraghavan@yahoo.com.au, linux-ide@vger.kernel.org, Shane Huang <Shane.Huang@amd.com>

Dear Tejun:


> The test results point to varied kinds and degrees of problems.  At
> the moment.  To avoid turning off anything fancy on systems involving
> SB600/700, we definitely need more info.
> 
> Shane, can you please summarize chipset product lines and revisions
> and how they're configured together (e.g. SB600 Axx goes together with
> RSxxx kind of stuff)?

I'll have to ask for other guys' help to summarize them, and will
provide
it here once I get it.


> Currently the following issues have been discovered and we need to
> find out what's caused by which.
> ..........
> ..........
> * Shane's test with RS690 + SB600 triggered a weird SERR_INTERNAL
>   error condition if pci=nomsi is used insted of
>   quirk_disable_all_msi.  This is super-weird.  Maybe difference in
>   memory layout and 64bit DMA acutally didn't work?  Shane, can you
>   please do some data write/read/verify test on the setup?

I will do further debug on these issues before long, because I'm busy
with other issues and my SB600 board is being used by other guy.. :-(



Thanks
Shane


