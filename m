From: Andy Warner <andyw@pobox.com>
Subject: Re: [patch] libata: add ioctls to support SMART
Date: Mon, 30 Aug 2004 12:42:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040830124225.A4358@florence.linkmargin.com>
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com> <413361BF.8020805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268708AbUH3Rvt@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <413361BF.8020805@pobox.com>; from jgarzik@pobox.com on Mon, Aug 30, 2004 at 01:19:59PM -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> [...]
> That implies, then, that you would add code to libata-scsi.c that 
> translates the ATA-passthru SCSI command into an ATA command using the 
> ata_scsi_translate() infrastructure.

Speaking of which - I'm working on this and want to find like
minded people playing in the libata-scsi.c/04-262r<n>.pdf
sandbox, and collaborate with them.

If you're one of these people, ping me off list and we
can pool our efforts.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
