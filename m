From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 09:32:59 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40667FAB.2090802@stesmi.com>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:42675 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262089AbUC1HdS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 02:33:18 -0500
In-Reply-To: <406616EE.80301@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Hi Jeff.

> I'm about to add a raft of SATA-2 hardware, all of which are queued. The 
> standard depth is 32, but one board supports a whopping depth of 256.

Speaking of which .. I just read an announcement that someone (of course
the name eludes me) announced a DVD Burner that's SATA.

Found it:

http://www.plextor.com/english/news/press/712SA_pr.htm

a) Are there provisions in the SATA (1) SPEC for support of
non-disk units?

b) if (strcmp(a, "no"))
      Do you know anything about it, ie is it SATA1 or 2 or what?

c) Let's ponder one gets a unit like this - is it usable with
libata yet?

d) if (strcmp(c, "no"))
      Will it? :)

// Stefan
