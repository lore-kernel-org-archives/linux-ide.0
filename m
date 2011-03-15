From: Maxime Bizon <mbizon@freebox.fr>
Subject: Re: "irq 4: nobody cared" when loading ahci driver on ce4100
Date: Tue, 15 Mar 2011 18:03:41 +0100
Message-ID: <1300208621.10827.46.camel@sakura.staff.proxad.net>
References: <1300129707.28545.34.camel@sakura.staff.proxad.net>
	 <4D7EB9EB.8030807@gmail.com> <1300162840.2118.4.camel@kero>
	 <20110315071937.GB8635@htj.dyndns.org>
	 <1300200509.10827.27.camel@sakura.staff.proxad.net>
	 <1300201422.10827.39.camel@sakura.staff.proxad.net>
	 <20110315151931.GA17376@htj.dyndns.org>
Reply-To: mbizon@freebox.fr
Mime-Version: 1.0
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:35693 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932446Ab1CORDt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Mar 2011 13:03:49 -0400
In-Reply-To: <20110315151931.GA17376@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>


On Tue, 2011-03-15 at 16:19 +0100, Tejun Heo wrote:

> Hmm... I don't really like INITIALIZING being tested there.  It's much
> more cumbersome to explain.  Can you please change ata_port_alloc() to
> set pflags to INITIALIZING|FROZEN?  And add a comment in ahci briefly
> noting why the test is necessary?

will do

I'm trying to test the patch on linus tree instead of old vendor kernel,
and I will submit it once it's done.

-- 
Maxime


