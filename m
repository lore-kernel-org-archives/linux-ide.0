From: Tejun Heo <tj@kernel.org>
Subject: Re: HDD not suspending properly / dead on resume
Date: Sat, 10 Jul 2010 12:03:44 +0200
Message-ID: <4C384580.2080507@kernel.org>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <201007100104.38693.stephan.diestelhorst@gmail.com> <201007100206.13401.rjw@sisk.pl> <201007100850.36889.stephan.diestelhorst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52417 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754047Ab0GJKEu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jul 2010 06:04:50 -0400
In-Reply-To: <201007100850.36889.stephan.diestelhorst@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@lists.osdl.org, stephan.diestelhorst@amd.com

On 07/10/2010 08:50 AM, Stephan Diestelhorst wrote:
>> I have a box where this problem is kind of reproducible, but it happens _very_
>> rarely.  Also I can't reproduce it on demand running suspend-resume in a tight
>> loop.  Are you able to reproduce it more regurarly?
> 
> For me it is much more reproducible. If I run multiple direct writing
> dd-s to the disk in question I trigger it rather reliably (~75% or
> higher). See the attached script from an earlier email.
> Maybe that helps triggering your case more reliabl, too?

Can you please try the following git tree?

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git libata-irq-expect

Thanks.

-- 
tejun
