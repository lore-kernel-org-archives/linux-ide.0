From: "James Olson" <big_spender12@lycos.com>
Subject: driver for Promise FastTrak SX4000
Date: Wed, 22 Feb 2006 17:20:16 -0500
Message-ID: <20060222222016.E37F93384C@ws7-3.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:44217 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S1751527AbWBVWUf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2006 17:20:35 -0500
Received: from unknown (unknown [192.168.9.180])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id 0C9551800318
	for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2006 22:20:30 +0000 (GMT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

  Hi Jeff,
The proprietary Promise driver for the FastTrak SX4100 sata also supported the FastTrak SX4000 pata and it used to compile and work with the 2.6 kernel but it compiles but does not work on kernel 2.6.14 and above.  Both controllers use the same controller chip the PDC20261 I believe, but the PCI device ID for the SX4000 is 0x6621 and for the SX4100 it is 0x6622.  What do you think about the possibility of modifying the sata_sx4 driver to support the pata version of this controller chip?  I tried it myself and it sees and identifies the parallel drives but I get command timeout errors with status drive ready seek complete.
    -James

-- 
_______________________________________________

Search for businesses by name, location, or phone number.  -Lycos Yellow Pages

http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.asp?SRC=lycos10

