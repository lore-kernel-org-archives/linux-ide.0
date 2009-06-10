From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] ahci: add warning messages for hp laptops
 with broken suspend
Date: Wed, 10 Jun 2009 16:38:54 +0900
Message-ID: <4A2F630E.3080904@gmail.com>
References: <4A211D74.5070208@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:4042 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbZFJHi4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jun 2009 03:38:56 -0400
Received: by rv-out-0506.google.com with SMTP id f9so203932rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 10 Jun 2009 00:38:58 -0700 (PDT)
In-Reply-To: <4A211D74.5070208@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
Cc: kernel.org@epperson.homelinux.net, emisca@gmail.com, Gadi Cohen <dragon@wastelands.net>, Paul Swanson <paul@procursa.com>, s@ourada.org, Trevor Davenport <trevor.davenport@gmail.com>, corruptor1972 <steven_tierney@yahoo.co.uk>, Victoria Wilson <mail@vwilson.co.uk>, khiraly <khiraly.list@gmail.com>, Sean <wollombi@gmail.com>

Tejun Heo wrote:
> Harddisks on HP dv[4-6] and HDX18 fail to come online after resume on
> earlier BIOSen.  Fortunately, HP recently released BIOS updates for
> all machines to fix the issue.  Detect old BIOSen, warn the user to
> update BIOS on boot and suspend attempts and fail suspend.

Ping.

-- 
tejun
