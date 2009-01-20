From: Phil Sutter <n0-1@freewrt.org>
Subject: review of pata-rb532-cf
Date: Tue, 20 Jan 2009 17:40:55 +0100
Message-ID: <20090120164314.07AD3400E137@mail.nwl.cc>
References: <20081128194607.93677386B1A7@mail.ifyouseekate.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:53823 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757272AbZATQtl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 11:49:41 -0500
In-Reply-To: <20081128194607.93677386B1A7@mail.ifyouseekate.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, bzolnier@gmail.com, florian@openwrt.org


Hi,

I did some review of pata-rb532-cf in order to simplify the code a bit
in which I think have succeeded.

After finding the first patch by accident, patches two and three were
quite obvious. Patch four also solves the discussed changes to
rb532_pata_data_xfer() as it drops it completely, replacing it by
a standard libata function. Patch 5 is rather experimental and hopefully
triggers a discussion about the changes it introduces.

Greetings, Phil
