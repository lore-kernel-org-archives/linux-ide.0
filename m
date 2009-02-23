From: Sagar Borikar <sagar.borikar@gmail.com>
Subject: Re: Synopsis SATA AHCI support
Date: Mon, 23 Feb 2009 14:46:11 +0530
Message-ID: <3fb94e50902230116n32e1fad0jad3e8f4bbd1274@mail.gmail.com>
References: <3fb94e50902182156y62da0f6dhfb5d99ad5de9d0fd@mail.gmail.com>
	 <499D1EEB.3000200@kernel.org>
	 <3fb94e50902190318p4e423594o4be96bf0ee70007f@mail.gmail.com>
	 <499D6201.9040705@kernel.org>
	 <3fb94e50902190635g5f47e244w2631c9a3103fa6a@mail.gmail.com>
	 <499DFB06.9020701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:46034 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbZBWJQM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Feb 2009 04:16:12 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1861229rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 23 Feb 2009 01:16:12 -0800 (PST)
In-Reply-To: <499DFB06.9020701@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Tejun,

The interface block is like this:

AHB to AXI Bridge
-------------------------------------------------------------------------------------------------------------

----------------------------------
----------------------------------------------
|         AHB Slave        |                           |         AHB
Master (DMA)        |
---------------------------------
----------------------------------------------


----------------------------------
----------------------------------------------
|         AHCI registers    |                           |
DMAC                        |
-----------------------------------
-----------------------------------------------


I need to convert PCI interface to AHB. Has anyone done that before?

Thanks
Sagar


On Fri, Feb 20, 2009 at 6:06 AM, Tejun Heo <tj@kernel.org> wrote:
> Sagar Borikar wrote:
>> Hi Tejun
>>
>> Its not PCI interface but AHB. This SATA IP is intergated and
>> connected to AXI through AHB bridge. And as the ARM core based board
>> is in development stage, I haven't added all SATA functionalities. I
>> am debugging based on the serial output
>
> Dunno anything about AHB or AXI but it's not a PCI device at all?
> Then, how is the ahci driver supposed to find it?  Currently, libata
> ahci driver only supports pci devices.  You'll at least need to modify
> the init function to get the controller recognized by the driver.
>
> --
> tejun
>
