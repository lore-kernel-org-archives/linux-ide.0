From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: [patch ide-dev 4/9] add ide_task_init_flush() helper
Date: Sun, 27 Feb 2005 17:23:02 +0100
Message-ID: <200502271723.02313.bzolnier@elka.pw.edu.pl>
References: <Pine.GSO.4.58.0502241540250.13534@mion.elka.pw.edu.pl> <20050227045637.GC25723@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:56462 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261591AbVB1Nd4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Feb 2005 08:33:56 -0500
In-Reply-To: <20050227045637.GC25723@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Sunday 27 February 2005 05:56, Tejun Heo wrote:
>  Hello,
> 
>  Just one minor thing.  Doesn't moving ide_task_s upward belong to
> patch #7?

It is needed for ide_task_init_flush() prototype.

> > +void ide_task_init_flush(ide_drive_t *, ide_task_t *);
