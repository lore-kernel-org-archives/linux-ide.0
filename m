From: linux@horizon.com
Subject: Re: sata_sil24 testing results
Date: 20 Nov 2005 21:06:04 -0500
Message-ID: <20051121020604.29510.qmail@science.horizon.com>
References: <20051120222121.16443.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:65327 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932175AbVKUCGF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Nov 2005 21:06:05 -0500
In-Reply-To: <20051120222121.16443.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org, linux@horizon.com


H'm!  One more addition... the badblocks process was not *quite*
kill -9 resistant.  I killed all of the others to compile 2.6.15-rc2
shich just came out, and when I finished compiling, I noticed that
the kernel had stopped complaining and the badblocks on /dev/sde had
exited.

Further, /dev/sde is working again.  I have a new badblocks running on it,
without rebooting.

Anyway, just a data point.
