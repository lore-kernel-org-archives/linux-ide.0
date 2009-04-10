From: "Leslie Rhorer" <lrhorer@satx.rr.com>
Subject: RE: Odd RAID failure
Date: Thu, 9 Apr 2009 21:26:01 -0500
Message-ID: <20090410022606.RHQT2520.cdptpa-omta04.mail.rr.com@Leslie>
References: <49DE54F7.1070408@kernel.org>
Reply-To: <lrhorer@satx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:59552 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbZDJEWo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Apr 2009 00:22:44 -0400
Received: from Leslie ([68.203.168.150]) by cdptpa-omta04.mail.rr.com
          with ESMTP
          id <20090410022606.RHQT2520.cdptpa-omta04.mail.rr.com@Leslie>
          for <linux-ide@vger.kernel.org>; Fri, 10 Apr 2009 02:26:06 +0000
In-Reply-To: <49DE54F7.1070408@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> > Per the thread, Leslie is not seeing anything in the logs.
> 
> That was a long thread.  Heh... yeah, at the first look, it looks like
> more of VM / FS interaction problem than low level driver problem.

Either that, or a bug in Reiserfs, would be my guess.

> Using blktrace/blkparse to track IO insertion, issue and completion
> latencies would help to whether the problem is above the block layer
> or below it.

I'll look into this, too.  I may need some guidance.

 
> If you can bear with slower operation, keeping issuing sync repeatedly
> (ie. something like while true; do sync; sleep 1; done) and see how
> the behavior changes might shed some light on what's going on too.

I wouldn't expect it to have any diagnostic value, really.  The sync command
locks up just like every other disk I/O when the event occurs.

> Also, disabling journal and seeing how the behavior changes could be
> revealing too.

Well, first of all, I would not expect this to have much effect (one never
knows, of course), because the event can transpire when there are no writes
at all going on and no dirty blocks, although once again one never knows.
Secondly, how does one disable the journal in Reiserfs?

