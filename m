From: khandelw@cs.fsu.edu
Subject: TCP/IP stack - doubts
Date: Wed, 21 Jul 2004 11:45:30 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1090424730.9cb5700b93c57@system.cs.fsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from CS2075.cs.fsu.edu ([128.186.122.75]:54439 "EHLO mail.cs.fsu.edu")
	by vger.kernel.org with ESMTP id S266519AbUGUPpc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jul 2004 11:45:32 -0400
Received: from websrv.cs.fsu.edu (websrv.cs.fsu.edu [128.186.120.244])
	by mail.cs.fsu.edu (Postfix) with ESMTP id DC5DDF2E48
	for <linux-ide@vger.kernel.org>; Wed, 21 Jul 2004 11:45:31 -0400 (EDT)
Received: (from system-vhost@localhost)
	by websrv.cs.fsu.edu (8.12.6/8.12.6/Submit) id i6LFjUhP029895
	for linux-ide@vger.kernel.org; Wed, 21 Jul 2004 11:45:30 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Linux IDE Mailing List <linux-ide@vger.kernel.org>

I have a few basic questions regarding the TCP/IP stack.

1. Is this an integrated part of the kernel? As in, if I modify the IP layer do
I need to recompile the kernel?
2. If its an integrated part of the kernel, would it make sense to make each
layer
a module? so that whoever is experimenting with it can modify that layer and
just do an insmod.
3. I am planning to implement a strip down version of IPSec protocol as
suggested by Radia Perlman in her paper "Analysis of the IPSec Key Exchange
Protocol" any comments about that?


Thanks in advance!
- Amit Khandelwal



