From: Tejun Heo <tj@kernel.org>
Subject: Re: [libata/sata_sil] Error on startup
Date: Mon, 15 Sep 2008 03:24:54 -0700
Message-ID: <48CE37F6.40301@kernel.org>
References: <c58a7a270809120334r16164e3ej9f8ab769a09742ed@mail.gmail.com>	 <c58a7a270809120427p2af9885eo9cbc2d4455372882@mail.gmail.com>	 <48CBB831.9030403@ru.mvista.com>	 <c58a7a270809131023g6c5dad8em8cee2ace3b678209@mail.gmail.com>	 <48CE2389.9080205@kernel.org>	 <c58a7a270809150249qa0bb8e5ifdbfeb7fb5ef0565@mail.gmail.com>	 <48CE3497.4000604@kernel.org> <c58a7a270809150320qd275503lbd5101eb870511c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53884 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146AbYIOK1i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Sep 2008 06:27:38 -0400
In-Reply-To: <c58a7a270809150320qd275503lbd5101eb870511c4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex Gonzalez <langabe@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Hello,

Alex Gonzalez wrote:
> I haven't placed the drive under stress test, but it does work OK
> under normal conditions without errors or timeouts in the log.

Hmm... Okay.

>>From the cache error, I know that the physical region iomapped in
> 0xf0000000 - 0xf0000200 is the PCI memory space, so the exception is
> being caused by trying to access this area.
> 
> I haven't yet looked deeply into it, I was assuming the action of
> stopping the bmdma engine might have triggered the exception. If not,
> why not receive an immediate exception without the 10secs timeout?

Yeah, it's caused by EH trying to stop the BMDMA engine but it
shouldn't.  It works well on other platforms.  Can you try to diagnose
the bus failure?  Working EH will be able to tell us more about the
problem.

-- 
tejun
