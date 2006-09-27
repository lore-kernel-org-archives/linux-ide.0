From: "Trent George" <trent@norwalkdist.com>
Subject: Re: multiple irqs per card on the sata_sil24
Date: Tue, 26 Sep 2006 17:31:32 -0700
Message-ID: <KMS--2046545466-1840@mail.norwalkdist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adsl-64-165-178-101.dsl.lsan03.pacbell.net ([64.165.178.101]:12549
	"EHLO mail.norwalkdist.com") by vger.kernel.org with ESMTP
	id S1750809AbWI0AbD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Sep 2006 20:31:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


While reading the specs, I noticed that the pci-x cards support splitting each port to a unique irq pin.
If you have 6 cards with 4 ports, can you spread the load over 24 irqs ?
I dont know if the motherboard can support this, or the driver could be modified to do this.
It would be nice when there is a lot of of disk traffic on lots of drives.... adding port multiplier drives to each channel.
I am trying to build a VERY large duplication system using LOTS of bandwidth. the irq can really put stress on the system.

the final system would be 100+ drives all going over 22mb/s.
It should give a nice supermicro board with 3 buses a real workout.

Trent

