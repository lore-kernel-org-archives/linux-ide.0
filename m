From: "Paul Check" <paul@thechecks.ca>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Thu, 15 Jul 2010 13:06:01 -0400
Message-ID: <026d427816dcd2b34b0411305210e58f.squirrel@thechecks.ca>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
    <4B5D26EF.4030709@kernel.org> <loom.20100205T041929-66@post.gmane.org>
    <12193ff15b0deef3609ea93f54e5b485.squirrel@thechecks.ca>
    <13096cdf5e0e6704e30364a746e60467.squirrel@thechecks.ca>
    <8276efbfebcbfc3e58033ab8d5996d9d.squirrel@thechecks.ca>
    <4C3DACFF.2060504@kernel.org>
    <0d9ccbbb9ed0fb46dc9497888cd92c6e.squirrel@thechecks.ca>
    <4C3E4A04.5030000@kernel.org>
    <6cb5020f769580a1f431ed5bb8709b6a.squirrel@thechecks.ca>
    <4C3ED2C3.9050907@kernel.org> <4C3ED4E2.9080806@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from d72-38-7-254.commercial1.cgocable.net ([72.38.7.254]:1656 "EHLO
	max" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932588Ab0GORGF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jul 2010 13:06:05 -0400
In-Reply-To: <4C3ED4E2.9080806@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Ok, I've applied the patch and had a successful boot on the first try. Of
course the problem appears only about 40% of the time, so I'll re-boot
several times later and see if I can get 10 in a row.  I'm busy now
(unsuccessful => raid re-build, no time for that now)...will report back
later today.  P

> On 07/15/2010 11:20 AM, Tejun Heo wrote:
>> Hmm... it looks like SStatus and SControl are swapped here.  Maybe
>> there's a race condition in SIDPR code.  I'll look into it a bit more.
>
> So, something like this.  Can you please apply the patch and see
> whether the problem goes away?


