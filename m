From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Promise IDE controller crashes 2.4.22
Date: Thu, 27 Nov 2003 20:42:19 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200311272042.19568.bzolnier@elka.pw.edu.pl>
References: <slrnbsche8.2ir.jgoerzen@christoph.complete.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53382 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264586AbTK0TlR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Nov 2003 14:41:17 -0500
In-Reply-To: <slrnbsche8.2ir.jgoerzen@christoph.complete.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
Cc: linux-ide@vger.kernel.org


[ linux-kernel@ replaced by linux-ide@ ]

Can you try setting drive to use UDMA100 instead of UDMA133
(by something like 'hdparm -Xudma100 /dev/hda')?

Also please send full dmesg and config.

--bart

On Thursday 27 of November 2003 19:43, John Goerzen wrote:
> Hi,
>
> I have a Promise 20269-based UDMA 133 IDE controller.  If I have DMA
> enabled on this controller, then when it is seeing heavy write activity,
> the system freezes.  No messages on the console, ctrl-alt-del does
> nothing, magic sysrq does nothing.
>
> Reads do not appear to cause this problem, and the problem also
> disappears if I disable DMA on the drive connected to the controller by
> using hdparm.
>
> System information:
> Linux pi 2.4.22 #3 Sat Oct 25 15:45:50 CDT 2003 i586 GNU/Linux
> AMD K6 400MHz processor
>
> lspci:
> 00:08.0 Unknown mass storage controller: Promise Technology, Inc. 20269
> (rev 02)
>
> Drive: Maxtor 6Y160P0 150GB UDMA 133
>
> I have, in my .config:
>
> CONFIG_BLK_DEV_PDC202XX_NEW=y
> CONFIG_BLK_DEV_PDC202XX=y
>
> Thanks for any insight.
>
> -- John Goerzen

