From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: fixup return type of wait_for_completion_timeout
Date: Tue, 10 Feb 2015 10:56:03 -0500
Message-ID: <20150210155603.GK3220@htj.duckdns.org>
References: <1423557576-18984-1-git-send-email-hofrat@osadl.org>
 <20150210145341.GJ3220@htj.duckdns.org>
 <20150210155517.GB1883@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:62502 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbbBJP4I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Feb 2015 10:56:08 -0500
Content-Disposition: inline
In-Reply-To: <20150210155517.GB1883@opentech.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Feb 10, 2015 at 04:55:17PM +0100, Nicholas Mc Guire wrote:
> On Tue, 10 Feb 2015, Tejun Heo wrote:
> 
> > On Tue, Feb 10, 2015 at 03:39:36AM -0500, Nicholas Mc Guire wrote:
> > > -	if (!rc) {
> > > +	if (irq_timeout == 0) {
> > 
> > Why == 0 tho?  This always bothers me.  To match this style, we'd use
> > != 0 to test the other direction.  In what way is "if (ret != 0)"
> > better than "if (ret)"?  We're negating the two tests needlessly.
> >
> The == 0 seemed better to me than ! here because it would read
> 
>   if (not irq_timeout) {
> 
> while it actually did time out - but this could be resolved by renaming
> irq_timeout to time_left (as was suggested by Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> for a similar patch) and then it 
> would read:
> 
>    if (time_left == 0) {
> 
> which would nicely describe the timeout state.
> 
> if that addresses your concerns then I'll fix it up and repost.

Plesae just do !

Thanks.

-- 
tejun
