From: Tomas Lund <tlund@nxs.se>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED
Date: Wed, 14 Jul 2010 10:02:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.1007140955080.24693@envy.nxs.se>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se> <4C3D134B.2090604@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:54725 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427Ab0GNICh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jul 2010 04:02:37 -0400
In-Reply-To: <4C3D134B.2090604@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Robert Hancock <hancockrwd@gmail.com>

On Tue, 13 Jul 2010, Robert Hancock wrote:

> On 07/13/2010 03:09 PM, Tomas Lund wrote:
>
>> ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
>> ata9.00: irq_stat 0x00020002, device error via D2H FIS
>> ata9.00: failed command: READ DMA
>> ata9.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
>> res 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>> ata9.00: status: { DRDY ERR }
>> ata9.00: error: { ABRT }
>> ata9.00: configured for UDMA/100
>> ata9: EH complete
>
> This seems strange, the drive apparently reported command aborted when 
> trying to read the first sectors of the disk, but there's no indication 
> of why (there's nothing set in Serror).
>
> Can you test the controller in a different machine? It could be faulty..

Remotly compiled 2.6.27.48 and rebooted, just to test, and the problem 
persists.

Will pick up another sil3132 based-controller (different vendor) at lunch 
today and do more testing tonight.

The motherboard in the server is a Gigabyte 965P-DS4 with a 2.13GHz 
Core2Duo E6420

//tlund
