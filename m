From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
Date: Thu, 30 Oct 2003 18:48:19 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200310301848.19065.bzolnier@elka.pw.edu.pl>
References: <200310301601.55588.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64129 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262695AbTJ3Roo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Oct 2003 12:44:44 -0500
In-Reply-To: <200310301601.55588.schlicht@uni-mannheim.de>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


[ Jens - IDE TCQ maintainer 8) added to cc: ]

On Thursday 30 of October 2003 16:01, Thomas Schlichter wrote:
> Hello,

Hi,

Could you also send dmesg output and retry with vanilla -test9?

--bartlomiej

> today I tried to test TCQ with the linux-2.6.0-test9-mm1 kernel. The
> config.gz is attached. But after enabling TCQ with 'hdparm -Q1 /dev/hda'
> newly started processes die due to a received SIGSEGV. No bad kernel
> messages appear...
>
> Disabling TCQ again doesn't help, only e reboot does...
> When I let the kernel enable TCQ at boot time, it set the TCQ buffer depth
> to 8 and even the init script was killed!

