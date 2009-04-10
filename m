From: Tejun Heo <tj@kernel.org>
Subject: Re: Odd RAID failure
Date: Fri, 10 Apr 2009 10:01:01 -0700
Message-ID: <49DF7B4D.5080109@kernel.org>
References: <20090410044328.TFNN5844.cdptpa-omta02.mail.rr.com@Leslie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36494 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbZDJRAW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Apr 2009 13:00:22 -0400
In-Reply-To: <20090410044328.TFNN5844.cdptpa-omta02.mail.rr.com@Leslie>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lrhorer@satx.rr.com
Cc: linux-ide@vger.kernel.org

Leslie Rhorer wrote:
>>> If you can bear with slower operation, keeping issuing sync repeatedly
>>> (ie. something like while true; do sync; sleep 1; done) and see how
>>> the behavior changes might shed some light on what's going on too.
>> I wouldn't expect it to have any diagnostic value, really.  The sync
>> command
>> locks up just like every other disk I/O when the event occurs.
> 
> I tried this and it doesn't seem to have made a difference.  Neither does
> using noop as the scheduler.

Hmm... yeah, I was mostly thinking about ext3 for this and the next
suggestion, which often has large latency when flushing its journal to
disk.  I suppose the next stop is trying another filesystem?

Thanks.

-- 
tejun
