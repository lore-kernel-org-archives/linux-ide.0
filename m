From: Pat LaVarre <p.lavarre@ieee.org>
Subject: satapi auto sense begun again
Date: 07 Jun 2004 18:13:34 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1086653614.3410.30.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:62101 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265137AbUFHANr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Jun 2004 20:13:47 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

Jeff G:

Can you suggest a specific thing for me to try or to study, to make
progress?

Where I left this work was that we can issue an unsolicited PIO op
xA0:03 "REQUEST SENSE" (for a multiple of four bytes) immediately after
op xA1 "IDENTIFY" ... but later we cannot inject even a PIO op x00
"NOP".

I imagine somehow interrupt handling is the issue?

Pat LaVarre


