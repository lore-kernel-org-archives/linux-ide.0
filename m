From: "Martin K. Petersen" <mkp@mkp.net>
Subject: Re: [2.6 patch] pata_cs5536.c: fix array overrun
Date: Thu, 18 Oct 2007 12:36:20 -0400
Message-ID: <yq1sl48752z.fsf@sermon.lab.mkp.net>
References: <20071018105132.GI3778@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jaguar.mkp.net ([192.139.46.146]:54921 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755006AbXJRQgV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 12:36:21 -0400
In-Reply-To: <20071018105132.GI3778@stusta.de> (Adrian Bunk's message of "Thu\, 18 Oct 2007 12\:51\:32 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>>>>> "Adrian" == Adrian Bunk <bunk@kernel.org> writes:

Adrian> This patch fixes an obvious array overrun spotted by the
Adrian> Coverity checker.

Bart already posted a patch for this.

-- 
Martin K. Petersen      http://mkp.net/
