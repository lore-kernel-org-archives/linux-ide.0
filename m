From: Jeff Garzik <jeff@garzik.org>
Subject: Re: No NCQ support on X61s Ultrabay?  (Intel ICH8 SATA controller
 question)
Date: Wed, 29 Apr 2009 22:27:46 -0400
Message-ID: <49F90CA2.4080602@garzik.org>
References: <E1LzLgA-0004j6-9W@closure.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44431 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754509AbZD3C1t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Apr 2009 22:27:49 -0400
In-Reply-To: <E1LzLgA-0004j6-9W@closure.thunk.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@linux.intel.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>

Theodore Ts'o wrote:

(you should cc linux-ide...)

> [ 4563.614247] ata4.00: 390721968 sectors, multi 16: LBA48 NCQ (depth 0/32)
>                                                                 ^^^^^^^

That generally means your disk is capable of NCQ, but your controller is 
not.

As Tejun noted, try switching to AHCI mode in BIOS.

	Jeff



