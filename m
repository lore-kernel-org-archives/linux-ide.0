From: Tejun Heo <tj@kernel.org>
Subject: Re: Port Multiplier access with Sil 3124
Date: Wed, 11 Feb 2009 11:09:26 +0900
Message-ID: <49923356.6050405@kernel.org>
References: <498F42B6.8030607@tlinx.org>	 <87f94c370902090635h2fc3e604n990bdd70be9c48cd@mail.gmail.com>	 <4990AC91.8010104@tlinx.org> <87f94c370902091501h96ecb8dp7acac1fa80a82d8a@mail.gmail.com> <4990C70E.1010707@garzik.org> <4990D349.4050408@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51678 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698AbZBKCJm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Feb 2009 21:09:42 -0500
In-Reply-To: <4990D349.4050408@tlinx.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linda Walsh <lkml@tlinx.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Linda Walsh wrote:
>     I also had a triple Seagate drive failure within 2 months,
> two of them within a week -- and I did lose *backups* of my primary
> drives!

My test disks go through a lot of unusual workloads which often
include frequent emergency head unloads with immediately following
spin up and Seagate has been the sturdiest for quite some time now.
It's sad to hear that they're degressing.  :-(

-- 
tejun
