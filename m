From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Multiple MSI, take 3
Date: Fri, 11 Jul 2008 04:34:19 -0700
Message-ID: <m1iqvc7iys.fsf@frodo.ebiederm.org>
References: <20080711005719.GO14894@parisc-linux.org>
	<m1iqvc91li.fsf@frodo.ebiederm.org>
	<20080711102326.GR14894@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:33131 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbYGKLmI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2008 07:42:08 -0400
In-Reply-To: <20080711102326.GR14894@parisc-linux.org> (Matthew Wilcox's
	message of "Fri, 11 Jul 2008 04:23:26 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@parisc-linux.org, mingo@elte.hu, tglx@linutronix.de, jgarzik@pobox.com, linux-ide@vger.kernel.org, suresh.b.siddha@intel.com, benh@kernel.crashing.org, jbarnes@virtuousgeek.org, rdunlap@xenotime.net, mtk.manpages@gmail.com


There is one idea that seems to model this cleanly
without breaking all kinds of expectations.

That is an irq with a very small data payload.

In that case we wire all of the vectors up to a single
irq handler that computes the payload as:
payload = vector - base-vector.

And then we figure out how to pass that to the handler in irqaction.

To most of the system it is a single irq so it avoids breaking
expectations about what an irq is.

To everything else it is a little odd, and has it's own unique
set of rules (which is good as well).

Eric
