From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: IDE hackery: lock fixes and hotplug controller stuff
Date: Tue, 10 Aug 2004 19:16:17 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200408101916.17489.bzolnier@elka.pw.edu.pl>
References: <20040810161911.GA10565@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8616 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267547AbUHJRVp
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Aug 2004 13:21:45 -0400
In-Reply-To: <20040810161911.GA10565@devserv.devel.redhat.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Tuesday 10 August 2004 18:19, Alan Cox wrote:
> Apply this patch at your peril. Its a work in progress but my IDE exposure
> meter is beeping and the sick bucket needs emptying 8)

Could you please split it off on separate patches?

- it is easier for everybody to review and comment them

- some changes just can't defend themselves when are not
  the part of the bigger patch

> -	Remove unsafe and essentially unfixable proc code for flipping
> 	between ide-cd and ide-scsi. Its no longer relevant with SG_IO.

Shouldn't we deprecate it first...?

> -	Added pci IDE helpers to do hot unplug

Locking for ide_hwifs[] should be added first...

[ I'm still on vacations but I'm watching what's going on... ]
Bartlomiej
