From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI driver problem on ICH (Re: AHCI driver problem on
 SB700/SB800 w/ Acer Ferrari One)
Date: Fri, 13 May 2011 19:39:51 +0200
Message-ID: <BANLkTimqxmbpP1-+HxhPQS-YoLTh=bHd1Q@mail.gmail.com>
References: <201105120025.34531.rjw@sisk.pl>
	<20110513143758.33f68a77@xenia.leun.net>
	<201105131856.44250.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33906 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab1EMRjx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 May 2011 13:39:53 -0400
In-Reply-To: <201105131856.44250.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Michael Leun <lkml20100708@newton.leun.net>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

Hello,

Can you guys please take a look at bug#34692?  It seems to be the same problem.

  https://bugzilla.kernel.org/show_bug.cgi?id=34692

The offending commit seems to be 270dac35c2.  Does reverting it
resolves the problem for you guys too?

Thanks.

--
tejun
