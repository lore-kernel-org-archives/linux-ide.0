From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 01/11] ide: task_end_request() fix
Date: Wed, 2 Mar 2005 17:07:36 +0100
Message-ID: <58cb370e05030208077189e7@mail.gmail.com>
References: <20050210083808.48E9DD1A@htj.dyndns.org>
	 <20050210083809.63BF53E6@htj.dyndns.org>
	 <58cb370e05022407587e86f8ad@mail.gmail.com>
	 <20050227064922.GA27728@htj.dyndns.org>
	 <58cb370e050301063069799c75@mail.gmail.com>
	 <42255582.4050204@pobox.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.193]:46448 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262337AbVCBQHo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2005 11:07:44 -0500
Received: by wproxy.gmail.com with SMTP id 68so255319wra
        for <linux-ide@vger.kernel.org>; Wed, 02 Mar 2005 08:07:43 -0800 (PST)
In-Reply-To: <42255582.4050204@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Wed, 02 Mar 2005 00:56:18 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > If somebody implements SG_IO ioctl and SCSI command pass-through
> > from libata for IDE driver (and add possibility for discrete taskfiles), we can
> > just deprecate HDIO_DRIVE_TASKFILE, forget about it and some time later
> > remove this FPOS.
> 
> Can you explain what you mean by "add possibility for discrete taskfiles"?

I mean flagged taskfiles.
