From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: silicon image 3124 support PATA
Date: Sat, 16 Jan 2010 11:48:34 -0600
Message-ID: <4B51FBF2.7070501@gmail.com>
References: <9edb119c1001160231v3081a2e4u79884988fc5e2359@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:58476 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab0APRsh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jan 2010 12:48:37 -0500
Received: by iwn35 with SMTP id 35so1245551iwn.4
        for <linux-ide@vger.kernel.org>; Sat, 16 Jan 2010 09:48:36 -0800 (PST)
In-Reply-To: <9edb119c1001160231v3081a2e4u79884988fc5e2359@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: amruth pattanada <amruth.vamadev@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 01/16/2010 04:31 AM, amruth pattanada wrote:
> Hi
> I am currently working on porting linux sata silicon image 3124 to
> RTOS based kernel. I have checked the code and found that it supports
> native sata mode only.
> I have legacy ide driver and want to integrate 3124 controller. I
> wanted to run 3124 in PATA mode. I checked libata and found that it
> only supports 3112.
> Can anybody please point what steps needs to be taken for making 3124
> run in PATA mode.

If you mean run in SFF-compatible mode like the 3112, you can't. The 
3124 is a pure FIS-based SATA controller and doesn't support a legacy 
SFF-style interface. If you're trying to make an IDE driver for the 3124 
I think you will have a lot of trouble, the IDE code was not really 
designed to handle such a device.

> Here is my observation so far.
> I have MMIO for both port and host using PCI configuration space.
> I can read global control register and after reset I can see that the
> default values are set correctly.
> I have port map of 8192
> bytes(0-2000,2000-4000,4000-6000,6000-8000)ports 0..3 respectively,
> and planning to reset the port, followed steps from linux code but
> unable to validate if the port is successfully reset.
> I have PRB mapped but after softreset, reading low,mid and high LBA
> but signature is not as per data sheet.
> Can I can use default standard ATA PRB and map it to legacy ide driver
> or is there any register setting needs to be done to bring in PATA
> mode.
> Any pointers will be appreciated.
> Thanks
> Amruth p.v
> Sr.Embedded Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

