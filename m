From: Bob Ham <rah@bash.sh>
Subject: Re: [PATCH 1/2] hpt366: fix PCI clock detection for HPT374
Date: Tue, 07 Aug 2007 10:01:10 +0100
Message-ID: <1186477270.4410.1.camel@localhost>
References: <200708060006.35511.sshtylyov@ru.mvista.com>
	 <1186420206.23890.7.camel@orchid.arb.net>  <46B757CE.2070700@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from waffl.ing.me.uk ([217.147.94.6]:55703 "EHLO waffl.ing.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755694AbXHGJBR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Aug 2007 05:01:17 -0400
In-Reply-To: <46B757CE.2070700@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

On Mon, 2007-08-06 at 21:18 +0400, Sergei Shtylyov wrote:
>     Hm, well, this is indeed tough case but at least it prodded me to fix some 
> issues.  Maybe it's worth for you to file a bug at bugzilla.kernel.org...

I've raised bug 8851:

  http://bugzilla.kernel.org/show_bug.cgi?id=8851

Bob


