From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Implementing CONFIG_IDE_POLL
Date: Thu, 22 Apr 2004 06:07:06 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404220607.06819.bzolnier@elka.pw.edu.pl>
References: <20040407034240.GA31195@flea>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43206 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263147AbUDVEHY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Apr 2004 00:07:24 -0400
In-Reply-To: <20040407034240.GA31195@flea>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Marc Singer <elf@buici.com>
Cc: linux-ide@vger.kernel.org


> is an ide_poll() function which is called at a couple of different
> places.  It does what it can if the device is ready, or it sets a

ide_poll() is also needed in do_rw_taskfile() in ide-taskfile.c
and maybe in some other places too...

