From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [patch 0/8] next bunch of IDE fixes (on the way to the driver-model)
Date: Sat, 22 Jan 2005 00:17:44 +0100 (CET)
Message-ID: <Pine.GSO.4.58.0501220010540.28844@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262593AbVAVAIg@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58069 "EHLO
	mion.elka.pw.edu.pl") by higgs.elka.pw.edu.pl with ESMTP
	id S50805AbVAUXRv (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Sat, 22 Jan 2005 00:17:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi,

All patches are against ide-dev-2.6 tree (== incremental to 5 previous
patches).  The main part of this series is adding reference counting to
IDE device drivers (ide-scsi is a problematic one and I need some help
from SCSI people).

Bartlomiej
