From: "Leslie Rhorer" <lrhorer@satx.rr.com>
Subject: RE: Odd RAID failure
Date: Fri, 10 Apr 2009 20:34:28 -0500
Message-ID: <20090411013434.TGVC5844.cdptpa-omta02.mail.rr.com@Leslie>
References: <49DF7B4D.5080109@kernel.org>
Reply-To: <lrhorer@satx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:60433 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbZDKBej (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Apr 2009 21:34:39 -0400
Received: from Leslie ([68.203.168.150]) by cdptpa-omta02.mail.rr.com
          with ESMTP
          id <20090411013434.TGVC5844.cdptpa-omta02.mail.rr.com@Leslie>
          for <linux-ide@vger.kernel.org>; Sat, 11 Apr 2009 01:34:34 +0000
In-Reply-To: <49DF7B4D.5080109@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> >>> If you can bear with slower operation, keeping issuing sync repeatedly
> >>> (ie. something like while true; do sync; sleep 1; done) and see how
> >>> the behavior changes might shed some light on what's going on too.
> >> I wouldn't expect it to have any diagnostic value, really.  The sync
> >> command
> >> locks up just like every other disk I/O when the event occurs.
> >
> > I tried this and it doesn't seem to have made a difference.  Neither
> does
> > using noop as the scheduler.
> 
> Hmm... yeah, I was mostly thinking about ext3 for this and the next
> suggestion, which often has large latency when flushing its journal to
> disk.  I suppose the next stop is trying another filesystem?
Well, I thought of that, of course.  With over 6T of data, that means taking
the array down (mostly) for more than 3 days.  'Not a propect I cherish,
especially since it measn most of the data will then only exost on the
backup system, and over a period of 3 days there are a lot of opportunities
to lose the backup system , especially since it is JBOD.  Indeed, the last
time I re-formatted the RAID array, the backup system did fail.  The
motherboard shorted and took the power supply with it.  Fortunately, I was
able to recover the backup system and only lost a few files.

