From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] Add lib/glob.c
Date: Mon, 12 May 2014 16:03:51 -0700
Message-ID: <20140512160351.c0f7b25d7fa79e1cb19d6a79@linux-foundation.org>
References: <20140313121032.GA9981@htj.dyndns.org>
	<20140510031356.22726.qmail@ns.horizon.com>
	<20140510122138.GA4721@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39785 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbaELXDx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 May 2014 19:03:53 -0400
In-Reply-To: <20140510122138.GA4721@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: George Spelvin <linux@horizon.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, torvalds@linux-foundation.org

On Sat, 10 May 2014 08:21:38 -0400 Tejun Heo <tj@kernel.org> wrote:

> > +int
> > +main(void)
> > +{
> > +	size_t i;
> > +
> > +	for (i = 0; i < sizeof(tests)/sizeof(*tests); i++)
> > +		test(tests + i);
> > +
> > +	return 0;
> > +}
> > +
> > +#endif	/* UNITTEST */
> 
> Again, I don't really think the userland testing code belongs here.
> If you wanna keep them, please make it in-kernel selftesting.  We
> don't really wanna keep code which can't get built and tested in
> kernel tree proper.

If the tests don't measurably increase boot times we could run them
unconditionally at boot.  Mark everything __init/__initdata and
the costs are very low.  lib/plist.c does this.
