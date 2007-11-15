From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: sata_mv: hard resetting port
Date: Thu, 15 Nov 2007 11:26:46 +0100
Message-ID: <473C1EE6.3070304@wpkg.org>
References: <473AC34B.8000709@wpkg.org> <473B13D6.3080202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:59337 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756333AbXKOK0x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2007 05:26:53 -0500
In-Reply-To: <473B13D6.3080202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Mark Lord schrieb:

(...)

>> ata6: exception Emask 0x10 SAct 0x0 SErr 0x180000 action 0x6 frozen
>> ata6: edma_err 0x00000020
>> ata6: hard resetting port
>> ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata6.00: configured for UDMA/133
>> ata6: EH pending after completion, repeating EH (cnt=4)
>> ata6: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0x7
>> ata6: edma_err 0x00000010, dev connect
>> ata6: hard resetting port

> ..
> 
> Translation:
> "libata reset the link, and everything appeared okay,
> so it reissued the failed command and continued.
> No data loss."

And today kernel (2.6.23.1) in the same machine have spoken to 
not-mere-mortals again:

ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6: edma_err 0x00000020
ata6: hard resetting port
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: configured for UDMA/133
ata6: EH complete
sd 5:0:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
sd 5:0:0:0: [sde] Write Protect is off
sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA


As I understand it now, your previous translation would fit here (or 
not, as SErr differs?):

 > Translation:
 > "libata reset the link, and everything appeared okay,
 > so it reissued the failed command and continued.
 > No data loss."


But why was the port reseted? There was no CRC error as before, was there?


What worries me is that it always happens for the same drive.



-- 
Tomasz Chmielewski
http://wpkg.org
