From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: kernel 2.6.3 hdparm : HDIO_SET_DMA failed: Operation not permitted
Date: Fri, 5 Mar 2004 18:26:16 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403051826.16650.bzolnier@elka.pw.edu.pl>
References: <1078506007.2210.84.camel@tanna>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14731 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261964AbUCERSz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Mar 2004 12:18:55 -0500
In-Reply-To: <1078506007.2210.84.camel@tanna>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-15?q?Fran=E7ois=20Chenais?= <francois@chenais.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 05 of March 2004 18:00, Fran=E7ois Chenais wrote:
> Hello,

Hi,

> Since I use kernel 2.6.3, my disk has very low performance
> If I do nothing during about 30 sec, the system takes about 3 sec bef=
ore
> reaction because the disk seems awakened.
>
> So I asked around me how to tune it using hdparm but
> i have the following errors when setting on dma (logs bellow).
>
> Some persons around me have the same feeling of lowest performances.
>
>
> Perhaps my kernel .config has some bad values because I have no
> experience in disk tuning (see attached file).
>
> I use
>    - debian sid on a NEC VERSA L320 laptop with a 'home built' kernel=
=2E
>    - preemptive mode
>    - ACPI

CONFIG_BLK_DEV_PIIX is not set in your .config and due to the fact
that NEC VERSA L320 has Intel IDE chipset you need to set it to 'y'.

Regards,
Bartlomiej

