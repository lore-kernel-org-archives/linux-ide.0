From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Tue, 17 Aug 2004 16:40:31 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200408171640.31986.bzolnier@elka.pw.edu.pl>
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171512.26568.bzolnier@elka.pw.edu.pl> <20040817140533.GB2019@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16004 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268257AbUHQOlz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Aug 2004 10:41:55 -0400
In-Reply-To: <20040817140533.GB2019@devserv.devel.redhat.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

On Tuesday 17 August 2004 16:05, Alan Cox wrote:
> > I hate HDIO_SCAN_HWIF and HDIO_UNREGISTER_HWIF and I still think we
> > should remove them - I waited with such changes for 2.7 but this plan
> > failed becuase there won't be 2.7 soon. :/
>
> Once you have drive and controller hot plug you don't need them. Until then
> some laptop users rely on them. I'd prefer to ignore the issue (its a
> privileged code path) until the hotplug is there, or patch it up by
> allowing unregister only of SCAN_HWIF added hwifs ?

IMO the correct approach is to remove them as a part of a patch series
which results in working hot plug support :)
