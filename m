From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: hpt36x/hpt37x fix
Date: Sun, 20 Jun 2004 21:29:49 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406202129.49038.bzolnier@elka.pw.edu.pl>
References: <0406192318180.26925@valeria.didjital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9431 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261500AbUFTTZK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Jun 2004 15:25:10 -0400
In-Reply-To: <0406192318180.26925@valeria.didjital.net>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jonas =?iso-8859-1?q?Th=F6rnblad?= <jonas@thornblad.net>
Cc: linux-ide@vger.kernel.org

On Saturday 19 of June 2004 23:59, Jonas Th=F6rnblad wrote:
> Hi,

Hi,

> There is a problem in the hpt366.c driver where the function
> ide_config_drive_speed(drive, speed) is called without using the
> correct speed variable. The speed variable should use the value retur=
ned
> by hpt3xx_ratefilter which decides the speed after checking against t=
he
> bad drives list.

Good catch.

*sigh* this bug has been present for almost 2 years now (since 2.4.21).

> I believe the following patch fixes the problem.

Yep, thanks.

Bartlomiej

