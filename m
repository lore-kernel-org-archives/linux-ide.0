From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Mon, 16 Aug 2004 19:23:19 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200408161923.19024.bzolnier@elka.pw.edu.pl>
References: <20040815151346.GA13761@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:4340 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267813AbUHPRXk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Aug 2004 13:23:40 -0400
In-Reply-To: <20040815151346.GA13761@devserv.devel.redhat.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

On Sunday 15 August 2004 17:13, Alan Cox wrote:
> There really isnt any sane way to break this patch down because all the
> changes are interlinked so closely.

at least /proc/ide/hd?/settings:ide-scsi removal and doc fixes are very easy 
to separate, I also think that locking fixes should be separated from 
hotplugging ones
