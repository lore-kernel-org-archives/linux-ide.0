From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017 ata_sff_hsm_move+0x45e/0x750()
Date: Sat, 10 Jan 2009 16:01:44 +0300
Message-ID: <49689C38.1040607@ru.mvista.com>
References: <200901091334.55823.borntraeger@de.ibm.com>	<200901101009.13699.borntraeger@de.ibm.com>	<20090110104114.633cacd8@lxorguk.ukuu.org.uk>	<200901101242.05203.borntraeger@de.ibm.com>	<49688B63.5030105@ru.mvista.com> <20090110122130.318cf168@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:63678 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750813AbZAJNBJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jan 2009 08:01:09 -0500
In-Reply-To: <20090110122130.318cf168@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, lkml <linux-kernel@vger.kernel.org>

Hello.

Alan Cox wrote:

>>   That's the typical REQUEST SENSE command with 18-byte data length.

> Which means something has become horribly broken in the core libata stack.
> An 18 byte inquiry would have 18 bytes as the *last* sg element. That

    Did you get me right? 18 bytes is the typical REQUEST SENSE payload 
(libata requested 96 bytes), not INQUIRY. For the INQUIRY 36 bytes was 
requested and received (divisible by 4).
    And I doubt there can be more than one S/G segment with such lengths...

WBR, Sergei
