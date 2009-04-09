From: Tejun Heo <tj@kernel.org>
Subject: Re: Odd RAID failure
Date: Thu, 09 Apr 2009 13:05:11 -0700
Message-ID: <49DE54F7.1070408@kernel.org>
References: <20090404173205.GIRT22375.cdptpa-omta01.mail.rr.com@Leslie>	 <49DE3AB2.5030503@kernel.org> <87f94c370904091142m79c60d7cy2e377c40b2f7f0c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35729 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759901AbZDIUEm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 16:04:42 -0400
In-Reply-To: <87f94c370904091142m79c60d7cy2e377c40b2f7f0c1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: lrhorer@satx.rr.com, linux-ide@vger.kernel.org

Hello,

Greg Freemyer wrote:
> On Thu, Apr 9, 2009 at 2:13 PM, Tejun Heo <tj@kernel.org> wrote:
>> Lelsie Rhorer wrote:
>> ...
>>> The issue is the entire array will occasionally pause completely for about
>>> 40 seconds when a file is created.  This does not always happen, but the
>>> situation is easily reproducible.
>> Does the kernel whine about anything when this happens?
> 
> Tejun,
> 
> There is a long thread on linux-raid about this issue:
> 
> http://markmail.org/message/a32fsnsaa5mmpthw
> 
> Per the thread, Leslie is not seeing anything in the logs.

That was a long thread.  Heh... yeah, at the first look, it looks like
more of VM / FS interaction problem than low level driver problem.
Using blktrace/blkparse to track IO insertion, issue and completion
latencies would help to whether the problem is above the block layer
or below it.

If you can bear with slower operation, keeping issuing sync repeatedly
(ie. something like while true; do sync; sleep 1; done) and see how
the behavior changes might shed some light on what's going on too.
Also, disabling journal and seeing how the behavior changes could be
revealing too.

Thanks.

-- 
tejun
