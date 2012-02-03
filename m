From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: Regression 3.2 -> 3.3-rc1 10 sec hang at boot and resume,
 COMRESET failed
Date: Fri, 03 Feb 2012 13:34:29 +0800
Message-ID: <1328247269.15079.26.camel@minggr>
References: <20120202051258.GA15550@gamma.logic.tuwien.ac.at>
	 <4F2A4B7E.2090503@linux.vnet.ibm.com> <1328231716.15079.15.camel@minggr>
	 <1328242884.15079.22.camel@minggr>
	 <20120203052452.GC24563@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:60568 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912Ab2BCFec (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Feb 2012 00:34:32 -0500
In-Reply-To: <20120203052452.GC24563@gamma.logic.tuwien.ac.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, jeff@garzik.org, Tejun Heo <tj@kernel.org>, "stern@rowland.harvard.edu >> Alan Stern" <stern@rowland.harvard.edu>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Fri, 2012-02-03 at 14:24 +0900, Norbert Preining wrote:
> On Fr, 03 Feb 2012, Lin Ming wrote:
> > And could you do a bisect?
> 
> Done that. First failing commit is:
> -----
> commit 7faa33da9b7add01db9f1ad92c6a5d9145e940a7
> Author: Tejun Heo <tj@kernel.org>
> Date:   Fri Jul 22 11:41:26 2011 +0200
> 
>     ahci: start engine only during soft/hard resets
> 
> Previous commit booted without delay.
> 
> I didn't try to revert that commit on top of HEAD.

Please revert that commit to test.
That helps us to make sure we find the exact bad commit.

Thanks.

> 
> Suggestions?
> 
> Best wishes
> 
> Norbert
> ------------------------------------------------------------------------
> Norbert Preining            preining@{jaist.ac.jp, logic.at, debian.org}
> JAIST, Japan                                 TeX Live & Debian Developer
> DSA: 0x09C5B094   fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
> ------------------------------------------------------------------------
> Program aborting:
> Close all that you have worked on.
> You ask far too much.
>                        --- Windows Error Haiku


