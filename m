From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 10/11] ide: make ide_cmd_ioctl() use TASKFILE
Date: Sun, 27 Feb 2005 02:41:19 -0500
Message-ID: <4221799F.4050801@pobox.com>
References: <20050210083808.48E9DD1A@htj.dyndns.org> <20050210083854.BD13DFBD@htj.dyndns.org> <58cb370e050224075040f5c031@mail.gmail.com> <20050227065348.GB27728@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39302 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261363AbVB0Hli (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Feb 2005 02:41:38 -0500
In-Reply-To: <20050227065348.GB27728@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

For what it's worth...

Some vendor-specific commands on PATA devices require -exact- 
specification of registers in, and registers out.  You never want to 
read more registers than are flagged.  Ditto for write.

	Jeff



