From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: [patch ide-dev 1/9] use struct ata_taskfile in ide_task_t
Date: Sun, 27 Feb 2005 17:40:51 +0100
Message-ID: <200502271740.51670.bzolnier@elka.pw.edu.pl>
References: <Pine.GSO.4.58.0502241535240.13534@mion.elka.pw.edu.pl> <20050227045439.GB25723@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:56462 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261592AbVB1Nd5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Feb 2005 08:33:57 -0500
In-Reply-To: <20050227045439.GB25723@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


> On Thu, Feb 24, 2005 at 03:36:44PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > + tf->device = 0x40;
> 
>  Wouldn't ATA_LBA be clearer?

I will change it, thanks.
