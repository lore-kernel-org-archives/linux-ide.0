From: Jay Cliburn <jacliburn@bellsouth.net>
Subject: Re: [RESEND][PATCH] sata_via: Add SATA support for vt8237a
Date: Sat, 19 Aug 2006 15:11:40 -0500
Message-ID: <44E7707C.4090907@bellsouth.net>
References: <20060814031030.GA3088@osprey.hogchain.net> <20060819182553.GA11985@unjust.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imf23aec.mail.bellsouth.net ([205.152.59.71]:50123 "EHLO
	imf23aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1751492AbWHSULr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 16:11:47 -0400
Received: from ibm66aec.bellsouth.net ([70.152.106.23])
          by imf23aec.mail.bellsouth.net with ESMTP
          id <20060819201142.RIVR27575.imf23aec.mail.bellsouth.net@ibm66aec.bellsouth.net>
          for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 16:11:42 -0400
In-Reply-To: <20060819182553.GA11985@unjust.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Martin Michlmayr wrote:
> * Jay Cliburn <jacliburn@bellsouth.net> [2006-08-13 22:10]:
>> This patch adds support for the VIA Technologies VT8237A SATA controller.
>>
>> Signed-off-by: Jay Cliburn <jacliburn@bellsouth.net>
>>
>>  static const struct pci_device_id svia_pci_tbl[] = {
>> +	{ 0x1106, 0x0591, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
>>  	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
>>  	{ 0x1106, 0x3249, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6421 },
> 
> What's the status of this patch?  Someone just reported a bug to
> Debian saying that their controller is not supported and that this
> patch works.

It has not been ACKed, NACKed, or applied.  I can only assume it's queued.

Jay
