From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [BK-Patch] ST3160023AS needs mod15
Date: Fri, 2 Jul 2004 18:48:37 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200407021848.37222.bzolnier@elka.pw.edu.pl>
References: <Pine.GSO.4.33.0407021149400.25702-100000@sweetums.bluetronic.net> <40E58BE9.7090000@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:60601 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264717AbUGBQn0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2004 12:43:26 -0400
In-Reply-To: <40E58BE9.7090000@superbug.demon.co.uk>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: James Courtier-Dutton <James@superbug.demon.co.uk>, Ricky Beam <jfbeam@bluetronic.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Friday 02 of July 2004 18:23, James Courtier-Dutton wrote:

> What does SIL_QUIRK_MOD15WRITE do?
> I have used ST3160023AS for a long time now without any problems in
> kernel 2.6.x

Do you have Silicon Image controller?  Are you using sata_sil driver?

If not this issue+patch doesn't affect you.

