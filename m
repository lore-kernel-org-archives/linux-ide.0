From: Tejun Heo <tj@kernel.org>
Subject: Re: [libata/sata_sil] Error on startup
Date: Mon, 15 Sep 2008 01:57:45 -0700
Message-ID: <48CE2389.9080205@kernel.org>
References: <c58a7a270809120334r16164e3ej9f8ab769a09742ed@mail.gmail.com>	 <c58a7a270809120427p2af9885eo9cbc2d4455372882@mail.gmail.com>	 <48CBB831.9030403@ru.mvista.com> <c58a7a270809131023g6c5dad8em8cee2ace3b678209@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37828 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbYIOJAO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Sep 2008 05:00:14 -0400
In-Reply-To: <c58a7a270809131023g6c5dad8em8cee2ace3b678209@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex Gonzalez <langabe@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Alex Gonzalez wrote:
> Thanks for the tip Sergei. The timeout in question lasts several
> seconds and is unrecoverable, finishing with a bus error. I could be
> looking at a hardware problem, but I have tried different drives,
> cables and I even see it on different units.
> 
> And most of the times everything works fine.

Care to post the kernel log, preferably with timestamps?

-- 
tejun
