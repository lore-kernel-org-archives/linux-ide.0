From: Tejun Heo <htejun@gmail.com>
Subject: Re: Serial ATA (SATA) shutdown info
Date: Wed, 16 May 2007 12:46:03 +0200
Message-ID: <464AE0EB.9080300@gmail.com>
References: <1179232945.16527.25.camel@quest.netsplit.com>	 <711b967b0705150834sdd14538x459119386c19a7ac@mail.gmail.com> <1179243992.16527.56.camel@quest.netsplit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:43631 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169AbXEPKqR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 06:46:17 -0400
Received: by wr-out-0506.google.com with SMTP id 76so150622wra
        for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 03:46:16 -0700 (PDT)
In-Reply-To: <1179243992.16527.56.camel@quest.netsplit.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Scott James Remnant <scott@ubuntu.com>
Cc: linux-ide@vger.kernel.org, 114683@bugs.launchpad.net

Hello, Scott.

Scott James Remnant wrote:
> Since we've been running with 2.6.x and libata for a while, without
> bothering to do this, is there any harm in continuing to not do this?

No, I don't think so.

> It's obviously not a regression for us, and we can answer "upgrade to
> 7.10" quite cheerfully if it turns out there are people with bugs (which
> they will have always had).

If that works for you and your userbase, you don't need to do anything.

> 
> I'll keep an eye on the thread you linked to, if we don't even need to
> write any zeros, we're definitely happy people :-)

Me happy too.  :-)

-- 
tejun
