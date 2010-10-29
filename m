From: Wolfgang Karall <lists+linux-ide@karall-edv.at>
Subject: Possible regression when going from 2.6.26 to 2.6.32
Date: Fri, 29 Oct 2010 10:26:12 +0200
Message-ID: <20101029082612.GA6525@lenny.spiney.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lenny.fqdn.at ([188.40.128.251]:56591 "EHLO lenny.spiney.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760380Ab0J2IeZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Oct 2010 04:34:25 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: saeed.bishara@gmail.com, mlord@pobox.com, tbm@cyrius.com

Hello,

when upgrading my QNAP TS-409 device (Marvell Orion based) from kernel
version 2.6.26 (current Debian 5.0/lenny) to 2.6.32 (Martin Michlmayr's
repository at http://people.debian.org/~tbm/orion who's also pointed me
to this list and recipients) only 2 out of the 4 HDD drives connected get
recognized.

Attached are dmesg outputs from both a successful boot with 2.6.26
showing all 4 drives and a failed boot with 2.6.32 showing only 2
drives.

If you need any more information, please let me know.

Best regards
Wolfgang Karall

PS: no need to CC me, I'm subscribed to the list.
