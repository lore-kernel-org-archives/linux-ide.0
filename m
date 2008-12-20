From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] ide: Fix ata_id_has_dword_io to return DWORD I/O   support
 properly
Date: Fri, 19 Dec 2008 19:58:03 -0600
Message-ID: <494C512B.6090304@shaw.ca>
References: <494A5BBF.8000807@inf.tu-dresden.de>	<494A837A.50801@garzik.org> <20081218181015.2e160d5c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:52159 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373AbYLTB6T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Dec 2008 20:58:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LDr6f-0002zd-Vg
	for linux-ide@vger.kernel.org; Sat, 20 Dec 2008 01:58:17 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 20 Dec 2008 01:58:17 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 20 Dec 2008 01:58:17 +0000
In-Reply-To: <20081218181015.2e160d5c@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Alan Cox wrote:
>> This seems like a risky assumption...
> 
> Its wrong on various counts
> 
> - ata_id_major_version can't tell early ATA versions apart
> - on anything later than the early ISA IDE paddles (the ones that
> basically were just bus decoders) its invisible to the drive
> 
> Except for legacy ISA bus controllers (and even there it is questionable)
> I would favour simply ignoring it.

32-bit IO wouldn't work on any ISA controller, would it? What happens if 
you do 32-bit IO port access on something on the ISA bus?

