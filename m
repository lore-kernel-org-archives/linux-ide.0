From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch] scsi/libata: correct bug for ULi M5281
Date: Sun, 06 Feb 2005 02:08:45 -0500
Message-ID: <4205C27D.7070303@pobox.com>
References: <OF934C846F.FCC47C36-ON48256FA0.0024A886@uli.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54456 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S272869AbVBFHI7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Feb 2005 02:08:59 -0500
In-Reply-To: <OF934C846F.FCC47C36-ON48256FA0.0024A886@uli.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer.Chen@uli.com.tw
Cc: Clear.Zhang@uli.com.tw, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Emily.Jiang@uli.com.tw, Eric.Lo@uli.com.tw

Peer.Chen@uli.com.tw wrote:
> Hi,Jeff:
> We didn't add the ULi-specific code to libata-core,just export some
> functions of it,is it ok?
> The problem is ULi-specific,so the reset procedures must be in sata_uli.c.

OK, thanks for explaining.

We still have the problem that code is duplicated from libata-scsi.c,
unless I am missing the latest patch from ULi?

	Jeff



