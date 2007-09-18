From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Problems with Promise controller or Seagate 500g ST3500630AS ?
Date: Tue, 18 Sep 2007 10:43:39 +0200
Message-ID: <18159.36795.897189.988906@alkaid.it.uu.se>
References: <ef5d62f60709162150j44a8bc63r230e89f6c46cc729@mail.gmail.com>
	<46EE43D8.4080907@gmail.com>
	<ef5d62f60709172008n4c049324jac0e6034999f74a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:37931 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbXIRInq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Sep 2007 04:43:46 -0400
In-Reply-To: <ef5d62f60709172008n4c049324jac0e6034999f74a3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Glen Larkins <ghlave@gmail.com>
Cc: linux-ide@vger.kernel.org

Glen Larkins writes:
 > Corrected. With only 1 of the 500g drives connected, I can boot fine.
 > With all drives connected, I suddenly began getting COMRESET failed
 > (errno=-16) and hearing physical noises from the two 80g drives
 > connected to the motherboard sata. This has never occurred.

This report, and the fact that you wrote that things worked until
you added 4 drives on a second controller, makes me suspect that
the PSU simply cannot cope with the load.
