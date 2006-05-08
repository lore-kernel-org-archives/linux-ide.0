From: "Dario Oliva" <DOliva@ARCOIDE.COM>
Subject: Infinite loop on MODE-SENSE with a removable ATAPI sata device on VIA chipset
Date: Mon, 8 May 2006 09:28:23 -0400
Message-ID: <E656D53DA4B96C409683999F573A360723E4B4@sbs.ARCO.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 67.104.187.164.ptr.us.xo.net ([67.104.187.164]:8949 "EHLO
	ARCOIDE.COM") by vger.kernel.org with ESMTP id S1751255AbWEHN2Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 May 2006 09:28:25 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello Mr. Garzik:

We have a removable, ATAPI, SATA device and we are having the following
problem with Linux (kernel version 2.6.15.6). The device recieves a MODE
SENSE command. After receiving this command, it is supposed to receive a
12-byte packet command, which it recieves. Afterwards there is supposed
to be an IRQ, and then the data is read from the device. However, in one
computer we have with a VIA chipset, the device keeps getting zeroes
without stopping. In other words, it gets the 12-bytes and the continues
to recive bytes all of which are zero. The device never gets the IRQ,
therefore it does not respond.

Any ideas on this?

Thanks in advance for any help.
 
 
 
Dario Oliva
Linux Software Engineer
Data Protection Solutions
