From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: ide lockup
Date: Sat, 6 Sep 2003 18:49:23 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200309061849.23430.bzolnier@elka.pw.edu.pl>
References: <200309061229.00331.cryst@golden.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:36313 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263189AbTIFQrb
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Sep 2003 12:47:31 -0400
In-Reply-To: <200309061229.00331.cryst@golden.net>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Chris Bruner <cryst@golden.net>
Cc: linux-ide@vger.kernel.org

On Saturday 06 of September 2003 18:29, Chris Bruner wrote:
> ve included some of the /proc files (including the ikconfig directory) in
> the hopes that this give a clue. Let me know if there is anything else I
> can provide.

You have Intel IDE support compiled as module, it should be built-in.
CONFIG_BLK_DEV_PIIX=y instead of CONFIG_BLK_DEV_PIIX=m.

You have nvidia binary-only module loaded, please try to recreate problem
without nvidia module loaded (its binary-only we can't debug it).

--bartlomiej

