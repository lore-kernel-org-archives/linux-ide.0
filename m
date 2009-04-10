From: "Leslie Rhorer" <lrhorer@satx.rr.com>
Subject: RE: Odd RAID failure
Date: Thu, 9 Apr 2009 23:43:23 -0500
Message-ID: <20090410044328.TFNN5844.cdptpa-omta02.mail.rr.com@Leslie>
References: <20090410022606.RHQT2520.cdptpa-omta04.mail.rr.com@Leslie>
Reply-To: <lrhorer@satx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.123]:35220 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbZDJEn3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Apr 2009 00:43:29 -0400
Received: from Leslie ([68.203.168.150]) by cdptpa-omta02.mail.rr.com
          with ESMTP
          id <20090410044328.TFNN5844.cdptpa-omta02.mail.rr.com@Leslie>
          for <linux-ide@vger.kernel.org>; Fri, 10 Apr 2009 04:43:28 +0000
In-Reply-To: <20090410022606.RHQT2520.cdptpa-omta04.mail.rr.com@Leslie>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> > If you can bear with slower operation, keeping issuing sync repeatedly
> > (ie. something like while true; do sync; sleep 1; done) and see how
> > the behavior changes might shed some light on what's going on too.
> 
> I wouldn't expect it to have any diagnostic value, really.  The sync
> command
> locks up just like every other disk I/O when the event occurs.

I tried this and it doesn't seem to have made a difference.  Neither does
using noop as the scheduler.

