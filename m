From: Tejun Heo <tj@kernel.org>
Subject: Re: libata pata_jmicron: kernel 2.6.26-rc6 wait for a long time to
 probe HDD
Date: Mon, 23 Jun 2008 22:57:30 +0900
Message-ID: <485FABCA.6070208@kernel.org>
References: <ff05f3d00806192015t30617527uc3b87b81452b9ee9@mail.gmail.com>	 <485EF190.3020000@kernel.org> <ff05f3d00806230654x231c3353ya316456422936b5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51622 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605AbYFWN5j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jun 2008 09:57:39 -0400
In-Reply-To: <ff05f3d00806230654x231c3353ya316456422936b5a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Edward Shao <laface.tw@gmail.com>
Cc: linux-ide@vger.kernel.org

Edward Shao wrote:
> Yes, it is a laptop but not on my hand now.
> The drive is a 1.8-inch embedded HDD.
> I'm not sure if I can try the drive on a different controller.
> Once I got the laptop back, I will try it.

When you get your hands on it, please also post the result of
"dmidecode" and "hdparm -I /dev/sdX".

-- 
tejun
