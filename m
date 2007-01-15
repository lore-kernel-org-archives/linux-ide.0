From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [TEST] PATA Promise 20378
Date: Mon, 15 Jan 2007 07:52:48 +0100
Message-ID: <17835.9408.287006.978320@alkaid.it.uu.se>
References: <45AA9EDF.6060706@9online.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:49052 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932076AbXAOGxA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Jan 2007 01:53:00 -0500
In-Reply-To: <45AA9EDF.6060706@9online.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vincent Legoll <vlegoll@9online.fr>
Cc: Jeff Garzik <jeff@garzik.org>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, Vincent Legoll <vincent.legoll@gmail.com>

Vincent Legoll writes:
 > Hello,
 > 
 > I tested libata-dev#promise-sata-pata branch, then I saw Mikael
 > Pettersson's patch, which kind of obsoleted the testing.
 > So I did libata-dev#upstream too.
 > 
 > Nothig bad happened yet, after about 1h30 of test for each kernel.
 > bonnie++, dd, untar, mke[23]fs.

Thanks for the testing. The non-breakage is expected though, since
the new PATA patch really only affects the driver's interface with
libata, and does not (should not) affect how it accesses the hardware.

 > The only diff for libata-dev#upstream boot:
 > ata1: SATA link down (SStatus 0 SControl 0)
 > 
 > Is this expected, harmless, or what ?

Harmless.

/Mikael
