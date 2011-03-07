From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] libata: Power off empty ports
Date: Mon, 7 Mar 2011 09:37:42 -0800
Message-ID: <20110307093742.4aaf8386@kcaccard-MOBL3>
References: <20110304090644.GC20499@htj.dyndns.org>
	<1299263051-3739-1-git-send-email-kristen@linux.intel.com>
	<20110304183836.GZ20499@htj.dyndns.org>
	<20110304104756.20451b33@kcaccard-MOBL3>
	<20110305080158.GC20499@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12035 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754940Ab1CGRfc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Mar 2011 12:35:32 -0500
In-Reply-To: <20110305080158.GC20499@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Sat, 5 Mar 2011 09:01:58 +0100
Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> On Fri, Mar 04, 2011 at 10:47:56AM -0800, Kristen Carlson Accardi wrote:
> > > Why not just do the following?
> > > 
> > > 	scontrol &= ~(0x3 << 8);
> > 
> > because, the IPM value is meaningless if we have no devices,
> > so this is a wasted operation.
> 
> What?  You're trying to save one AND operation to a value which is
> already in register in libata powersave path?  That's wrong on so many
> levels (it's not even a proper optimization, think about it).  Just
> make it easier on the eyes.

debating this is even more of a waste of an operation, so I'll be glad
to do this whatever way suites your taste.

