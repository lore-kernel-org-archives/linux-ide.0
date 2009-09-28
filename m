From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] ide-iops: fix for drive side 80-wire cable detection failure f
	or IBM-DJNA-371350 HD
Date: Mon, 28 Sep 2009 12:23:31 +0200
Message-ID: <19136.36515.143240.883054@pilspetsen.it.uu.se>
References: <20090927.193419.17010.1@webmail21.vgs.untd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:56224 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbZI1KXc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Sep 2009 06:23:32 -0400
In-Reply-To: <20090927.193419.17010.1@webmail21.vgs.untd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Gavlick <mgavl69@juno.com>
Cc: linux-ide@vger.kernel.org, davem@davemloft.net

Michael Gavlick writes:
 >   The IDE driver complains about an 80-wire cable detection failure and falls back to UDMA/33 for the old IBM-DJNA-371350 Rev. J7NOA30K HD even though it is an UDMA/66 HD.
 > 
 > Kernel Message:
 > "hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
 > hdb: drive side 80-wire cable detection failed, limiting max speed to UDMA33
 > hdb: UDMA/33 mode selected"
 > 
 >   This patch disables the word 93 validity check in /drivers/ide/ide-iops.c for this particular hardware by adding it to the buggy firmware ivb_list. 

Have you verified that the cable actually is 80-wire? If the problem
is buggy disk firmware, the message should disappear if you connect
a different known good UDMA/66 or better disk to this cable.

What model is the IDE controller?
