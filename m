From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 01/11] ide: task_end_request() fix
Date: Wed, 02 Mar 2005 00:56:18 -0500
Message-ID: <42255582.4050204@pobox.com>
References: <20050210083808.48E9DD1A@htj.dyndns.org>	 <20050210083809.63BF53E6@htj.dyndns.org>	 <58cb370e05022407587e86f8ad@mail.gmail.com>	 <20050227064922.GA27728@htj.dyndns.org> <58cb370e050301063069799c75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24515 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262190AbVCBF4e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Mar 2005 00:56:34 -0500
In-Reply-To: <58cb370e050301063069799c75@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Bartlomiej Zolnierkiewicz wrote:
> If somebody implements SG_IO ioctl and SCSI command pass-through
> from libata for IDE driver (and add possibility for discrete taskfiles), we can
> just deprecate HDIO_DRIVE_TASKFILE, forget about it and some time later
> remove this FPOS.

Can you explain what you mean by "add possibility for discrete taskfiles"?

	Jeff


