From: Matt Kowalczyk <matt.kowalczyk@gmail.com>
Subject: Re: array failure
Date: Thu, 24 Dec 2009 22:36:02 -0800
Message-ID: <4B345D52.5040307@gmail.com>
References: <4B345D07.7020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:45992 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbZLYGf0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Dec 2009 01:35:26 -0500
Received: by gxk3 with SMTP id 3so2648143gxk.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Dec 2009 22:35:25 -0800 (PST)
In-Reply-To: <4B345D07.7020007@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Matt Kowalczyk wrote:
> Hi,
>
> Can anyone help me better understand these messages? I'm trying to 
> determine the cause of the failure, cable, hd, disk controller, etc? 
> The below is what appears when I reset the disk array,
>
> Dec 24 22:31:40 atlas kernel: [ 1485.045504] ata2: hard resetting link
> Dec 24 22:31:42 atlas kernel: [ 1487.447432] ata2: SATA link up 3.0 
> Gbps (SStatus 123 SControl 0)
> Dec 24 22:31:42 atlas kernel: [ 1487.699172] ata2.15: qc timeout (cmd 
> 0xe8)
> Dec 24 22:31:42 atlas kernel: [ 1487.722552] ata2: failed to recover 
> some devices, retrying in 5 secs
> Dec 24 22:31:47 atlas kernel: [ 1492.718316] ata2: hard resetting link
> Dec 24 22:31:49 atlas kernel: [ 1494.916202] ata2: SATA link up 3.0 
> Gbps (SStatus 123 SControl 0)
> Dec 24 22:31:50 atlas kernel: [ 1495.167944] ata2.15: qc timeout (cmd 
> 0xe4)
> Dec 24 22:31:50 atlas kernel: [ 1495.179404] ata2: failed to recover 
> some devices, retrying in 5 secs
> Dec 24 22:31:55 atlas kernel: [ 1500.175099] ata2: hard resetting link
> Dec 24 22:31:57 atlas kernel: [ 1502.372985] ata2: SATA link up 3.0 
> Gbps (SStatus 123 SControl 0)
> Dec 24 22:31:57 atlas kernel: [ 1502.624727] ata2.15: qc timeout (cmd 
> 0xe4)
> Dec 24 22:31:57 atlas kernel: [ 1502.639478] ata2: failed to recover 
> some devices, retrying in 5 secs
> Dec 24 22:32:02 atlas kernel: [ 1507.635876] ata2: hard resetting link
> Dec 24 22:32:04 atlas kernel: [ 1509.833763] ata2: SATA link up 3.0 
> Gbps (SStatus 123 SControl 0)
> Dec 24 22:32:04 atlas kernel: [ 1509.833798] ata2: EH complete
>
> Thanks,
> Matt
>
>
Below are some more messages that may be helpful in understanding the 
failure,

Dec 24 22:33:06 atlas kernel: [ 1571.338228] ata2: hard resetting link
Dec 24 22:33:16 atlas kernel: [ 1581.350164] ata2: hard resetting link
Dec 24 22:33:26 atlas kernel: [ 1591.358851] ata2: hard resetting link
Dec 24 22:33:28 atlas kernel: [ 1593.556721] ata2: SATA link up 3.0 Gbps 
(SStatus 123 SControl 0)
Dec 24 22:33:28 atlas kernel: [ 1593.557002] ata2.15: Port Multiplier 
1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
Dec 24 22:33:28 atlas kernel: [ 1593.808467] ata2.15: qc timeout (cmd 0xe4)
Dec 24 22:33:28 atlas kernel: [ 1593.808503] ata2.01: failed to read SCR 
2 (Emask=0x4)
Dec 24 22:33:28 atlas kernel: [ 1593.808511] ata2.02: failed to read SCR 
2 (Emask=0x40)
Dec 24 22:33:28 atlas kernel: [ 1593.808517] ata2.03: failed to read SCR 
2 (Emask=0x40)
Dec 24 22:33:28 atlas kernel: [ 1593.808523] ata2.04: failed to read SCR 
2 (Emask=0x40)
Dec 24 22:33:28 atlas kernel: [ 1593.808530] ata2.05: failed to read SCR 
2 (Emask=0x40)
Dec 24 22:33:28 atlas kernel: [ 1593.808536] ata2.06: failed to read SCR 
2 (Emask=0x40)
Dec 24 22:33:28 atlas kernel: [ 1593.820775] ata2.15: retrying hardreset 
in 5 secs
Dec 24 22:33:33 atlas kernel: [ 1598.819614] ata2.15: hard resetting link
Dec 24 22:33:36 atlas kernel: [ 1601.017502] ata2.15: SATA link up 3.0 
Gbps (SStatus 123 SControl 0)
Dec 24 22:33:36 atlas kernel: [ 1601.017813] ata2.00: hard resetting link
Dec 24 22:33:36 atlas kernel: [ 1601.269243] ata2.15: qc timeout (cmd 0xe8)
Dec 24 22:33:36 atlas kernel: [ 1601.269278] ata2.00: failed to write 
SCR 2 (Emask=0x4)
Dec 24 22:33:36 atlas kernel: [ 1601.283353] ata2.00: failed to read SCR 
0 (Emask=0x40)
Dec 24 22:33:36 atlas kernel: [ 1601.295645] ata2.15: hard resetting link
Dec 24 22:33:46 atlas kernel: [ 1611.306776] ata2.15: hard resetting link
Dec 24 22:33:48 atlas kernel: [ 1613.501418] ata2.15: SATA link up 3.0 
Gbps (SStatus 123 SControl 0)

