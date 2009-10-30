From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Does ICH9M support eSATA Port Multiplier?
Date: Thu, 29 Oct 2009 18:02:30 -0600
Message-ID: <4AEA2D16.50701@gmail.com>
References: <4AE9EEA3.1040404@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:35184 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbZJ3AC2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Oct 2009 20:02:28 -0400
Received: by yxe17 with SMTP id 17so2223494yxe.33
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2009 17:02:33 -0700 (PDT)
In-Reply-To: <4AE9EEA3.1040404@aon.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-ide@vger.kernel.org

On 10/29/2009 01:36 PM, Peter Klotz wrote:
> I have the following setup:
>
> Notebook (Ubuntu 9.10, 2.6.31-14 amd64) with ICH9M controller in AHCI
> mode and an external storage box (Sil5744, 2 HDDs) connected via eSATA.
>
> The box supports JBOD and the manufacturer says that a Port Multiplier
> capable eSATA port is needed to see both HDDs.
>
> I see only one HDD.
>
> Here is part of the dmesg output from startup:
>
> [ 0.725096] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 4 ports 3 Gbps
> 0x23 impl SATA mode
> [ 0.725099] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio
> slum part ems
>
>
> The pmp flag is not present but several sources claim that ICH9 supports
> Port Multiplier.

It seems like it may be variable between specific ICH versions (mobile, 
RAID, etc.) whether they support PMP or not. Obviously in your case the 
controller doesn't report PMP support in the AHCI capabilities register.

>
> Should Port Multiplier be available for ICH9M?
> Can I enable it somehow maybe by using a module option?

No module parameter for that, you'd have to hack the code in ahci.c to 
force the option on. No guarantees it's going to work if the controller 
doesn't report the capability, though.
