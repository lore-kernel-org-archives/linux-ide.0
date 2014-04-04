From: Marc MERLIN <marc@merlins.org>
Subject: Re: [PATCH 1/2] libata: Expose trim capability in sysfs
Date: Fri, 4 Apr 2014 10:29:11 -0700
Message-ID: <20140404172911.GR19277@merlins.org>
References: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com> <20140402170916.GH16631@htj.dyndns.org> <yq1zjk3wslj.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:46683 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209AbaDDR3O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Apr 2014 13:29:14 -0400
Content-Disposition: inline
In-Reply-To: <yq1zjk3wslj.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Chris Samuel <chris@csamuel.org>

On Wed, Apr 02, 2014 at 01:26:16PM -0400, Martin K. Petersen wrote:
> >>>>> "Tejun" == Tejun Heo <tj@kernel.org> writes:
> 
> >> Now that drives with support for queued trim are starting to appear,
> >> it would be helpful to expose the chosen trim mode to
> >> userland. Create a
> 
> Tejun> Can you please be a bit more elaborate with how it'd be helpful?
> Tejun> Do we have actual use cases for it?
> 
> There have been several threads on linux-btrfs and elsewhere where
> people have asked whether queued trim is supported by their drive or
> not. This information currently isn't reported anywhere. I thought it
> would be convenient to have a sysfs attribute that people could inspect
> to find out.

Hi Tejun,

I haven't had time to pull a new kernel and install the patches I need and
this one yet (sorry), but I wanted to give a +1 to that.

If queued trim is not available, people may want to disable trim if they
want fast performance for rm.
But indeed currently it's pretty hard to know if your drive supports it.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
