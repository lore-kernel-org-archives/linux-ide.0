From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: T10/04-262 ATA pass thru - patch.
Date: Tue, 5 Oct 2004 18:41:46 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041005224146.GA16514@havoc.gtf.org>
References: <20040928001633.A8363@florence.linkmargin.com> <415AFF27.7080906@tteng.com.br> <415AFFBB.8090503@pobox.com> <4162EDA3.1030202@tteng.com.br> <20041005140653.A13393@florence.linkmargin.com> <41631DEC.9090404@pobox.com> <20041005173703.D13871@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:40398 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266243AbUJEWlt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Oct 2004 18:41:49 -0400
Content-Disposition: inline
In-Reply-To: <20041005173703.D13871@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: "Luciano A. Stertz" <luciano@tteng.com.br>, linux-ide@vger.kernel.org

On Tue, Oct 05, 2004 at 05:37:03PM -0500, Andy Warner wrote:
> Jeff Garzik wrote:
> > [...]
> > Probably you were running as root, and Luciano was not (guessing)
> 
> Yup - but I was only doing it to get around the device
> permissions (or so I thought.) Do people think I should
> add ATA_16/ATA_12 to the approved list of scsi commands ?

If you do, it's not that simple -- you would need to check the ATA
command to see if it was permissible for an unpriveleged user to issue
that specific ATA command.

Otherwise, unpriveleged users could fry the hardware, or whatnot.

	Jeff



