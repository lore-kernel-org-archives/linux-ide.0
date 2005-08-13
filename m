From: Francesco Aruta <a.francesco@mclink.it>
Subject: Re: Promise PDC20775 (SATA300 TX2plus) PATA support
Date: Sat, 13 Aug 2005 18:24:25 +0200
Message-ID: <42FE1EB9.9080000@mclink.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adsl203-152-141.mclink.it ([213.203.152.141]:12686 "HELO
	arf.no-ip.org") by vger.kernel.org with SMTP id S1751351AbVHMQWO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Aug 2005 12:22:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Thu, 2005-08-11 at 16:23 +0200, Raphael Bossek wrote:
> Will
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-libat=
a-dev1.patch.bz2
> add support for PDC20775 PATA interface? Could not find any reference
> to this device within the sources.

Yes... I'm currently using that patch and a Tx2Plus with one Sata and one Pata 
drive attached to tx2. But seems that there are some problems using two pata drives. See this bug
report: http://marc.theaimsgroup.com/?l=linux-ide&m=111321657925294&w=2
Btw, I've not tried to attach two pata drives yet.

Bye,
Francesco


