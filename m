From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Bug #4580: hda: lost interrupt when resuming from S3 - Sony VGN-T1XP
Date: Sun, 7 Oct 2007 22:17:06 +0200
Message-ID: <200710072217.07656.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55032 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755351AbXJGUBy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Oct 2007 16:01:54 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hi,

IDE/ATA wizzards are kindly requested to have a look at:

http://bugzilla.kernel.org/show_bug.cgi?id=4580#c21

as I have no idea of what we can do about the "hard drive password vs suspend"
problem, if anything.

Greetings,
Rafael
