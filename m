From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Corrupt data - RAID sata_sil 3114 chip
Date: Sun, 07 Feb 2010 10:09:56 -0600
Message-ID: <4B6EE5D4.1010907@gmail.com>
References: <4B630914.9010503@fs.ei.tum.de> <4B6338E2.1040507@gmail.com> <4B6CE7E0.1060209@kernel.org> <4B6D87DF.6030305@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:45160 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905Ab0BGQKA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Feb 2010 11:10:00 -0500
Received: by iwn12 with SMTP id 12so6045546iwn.26
        for <linux-ide@vger.kernel.org>; Sun, 07 Feb 2010 08:09:59 -0800 (PST)
In-Reply-To: <4B6D87DF.6030305@buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>
Cc: Tejun Heo <tj@kernel.org>, "Ulli.Brennenstuhl" <Ulli.Brennenstuhl@fs.ei.tum.de>, linux-ide@vger.kernel.org

On 02/06/2010 09:16 AM, Tim Small wrote:
> Tejun Heo wrote:
>> It would be great if there's some knob we can turn in the controller
>> PCI config space but I really have no idea whatsoever.  :-(
>>
>
> I wonder if enabling EDAC PCI parity error detection would show up these
> problems - either on the controller itself, or its upstream PCI bridge chip?
>
> modprobe edac_core check_pci_errors=1
>
> alternatively, "setpci -s<slot>  STATUS" should also show status
> register bit 15 having been asserted, I think, and lspci -vv should say
> "<PERR+"

It's something to check, yes. It would be somewhat surprising if that 
were occurring - detected PCI parity errors should cause a target abort 
and cause a transfer failure, not silent data corruption. But again, on 
an old VIA chipset, for this to be handled improperly wouldn't be 
shocking :-)
