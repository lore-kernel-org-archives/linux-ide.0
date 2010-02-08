From: Tim Small <tim@buttersideup.com>
Subject: Re: Corrupt data - RAID sata_sil 3114 chip
Date: Mon, 08 Feb 2010 14:25:18 +0000
Message-ID: <4B701ECE.5070101@buttersideup.com>
References: <4B630914.9010503@fs.ei.tum.de> <4B6338E2.1040507@gmail.com> <4B6CE7E0.1060209@kernel.org> <4B6D87DF.6030305@buttersideup.com> <4B6EE5D4.1010907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:33647 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab0BHO0j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Feb 2010 09:26:39 -0500
In-Reply-To: <4B6EE5D4.1010907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, "Ulli.Brennenstuhl" <Ulli.Brennenstuhl@fs.ei.tum.de>, linux-ide@vger.kernel.org

Robert Hancock wrote:
> It's something to check, yes. It would be somewhat surprising if that 
> were occurring - detected PCI parity errors should cause a target 
> abort and cause a transfer failure, not silent data corruption. But 
> again, on an old VIA chipset, for this to be handled improperly 
> wouldn't be shocking :-)

I believe that this is only the case if the motherboard BIOS sets bit 6 
in the Control register to tell the device to respond to parity errors.  
Most of the "server" motherboards I've seen do.  None of the non-server 
motherboards that I've just looked at do....

The Status flag "should" still work whether the "parity error response" 
flag is set, or not...

Cheers,

Tim.
