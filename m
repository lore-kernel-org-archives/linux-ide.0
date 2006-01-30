From: Tejun <htejun@gmail.com>
Subject: Re: I/O errors while dding between 2 SATA drives
Date: Tue, 31 Jan 2006 00:04:52 +0900
Message-ID: <43DE2B14.7090309@gmail.com>
References: <aa4c40ff0601261021m1fe746feq172f0a34b6afd9ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:8230 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932302AbWA3PFC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2006 10:05:02 -0500
Received: by zproxy.gmail.com with SMTP id 13so1151567nzn
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2006 07:05:01 -0800 (PST)
In-Reply-To: <aa4c40ff0601261021m1fe746feq172f0a34b6afd9ad@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Lamanna <jlamanna@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

James Lamanna wrote:
> I received the following errors while executing a
> dd if=/dev/sdb of=/dev/sda bs=1M
> between 2 500GB SATA Seagate Barracuda drives on 2.6.12 (Gentoo 2005.1
> "Live" CD)
> 
> ata1: command 0x35 timeout stat 0xd1 host_stat 0x21
> ata1: status=0xd1 { Busy }
> end request: I/O Error dev sda, sector 51188392
> Buffer I/O Error on device sda, logical block 6398549
> lost page write due to I/O Error on sda
> ATA: abnormal status 0xD1 on port 0x9F7
> ATA: abnormal status 0xD1 on port 0x9F7
> ATA: abnormal status 0xD1 on port 0x9F7
> 
> The message repeats every so often with the sector count increasing by
> 8 and logical block count increasing by 1.
> 
> Is it bad hardware? (sda is brand new)
> And is the copy hosed?
> 

[CC'ing linux-ide]

Hi, James.

Please post full dmesg and yeah the copy is probably hosed.  dd's exit 
code will tell you.  Do 'echo $$'.

-- 
tejun
