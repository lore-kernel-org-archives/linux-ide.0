From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: no hotplugging support (FIXME)
Date: Sun, 22 Feb 2009 01:40:17 -0600
Message-ID: <49A10161.6060206@gmail.com>
References: <Pine.LNX.4.10.10301040547120.421-100000@master.linux-ide.org> <499F171D.5020600@verizon.net> <499F52C8.90205@gmail.com> <49A0B1D8.10303@verizon.net> <49A0C8F5.30405@gmail.com> <49A0CFFF.3050806@verizon.net> <49A0D167.9060707@gmail.com> <49A0D74F.1010009@verizon.net> <49A0D7F6.902@gmail.com> <49A0D989.8030106@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.182]:17574 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbZBVHkV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Feb 2009 02:40:21 -0500
Received: by el-out-1112.google.com with SMTP id b25so801395elf.1
        for <linux-ide@vger.kernel.org>; Sat, 21 Feb 2009 23:40:19 -0800 (PST)
In-Reply-To: <49A0D989.8030106@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Todd and Margo Chester <ToddAndMargo@verizon.net>
Cc: linux-ide@vger.kernel.org

Todd and Margo Chester wrote:
> Robert Hancock wrote:
> 
>> Normally all the ports are AHCI if it's switched into that mode, so it 
>> shouldn't be an issue. However, you could leave in ata_piix as the 
>> third entry, so that the system will still boot if it's not in AHCI 
>> mode properly. There's no real harm in having unnecessary drivers in 
>> there..
> 
> Sorry for the thousand questions.  Thank you for being so gracious.
> 
> Question: once I boot up, is there a way to tell which drive
> is using which driver?

You should be able to tell from the bootup dmesg output which driver 
ends up detecting the ports..
