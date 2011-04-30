From: Mark Lord <kernel@teksavvy.com>
Subject: Re: How to perform SECURITY ERASE on a SEC4 (security enabled/locked)
 PATA drive ?
Date: Fri, 29 Apr 2011 22:26:09 -0400
Message-ID: <4DBB7341.1070600@teksavvy.com>
References: <BANLkTikZt4Nr3DK3CkZXZ_ORgqjy-MGOUA@mail.gmail.com>	<4DBAC18A.20407@teksavvy.com> <BANLkTimFg_=KmCRVL=QoO9s-4+T3DmbNQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:9733 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759069Ab1D3C0M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Apr 2011 22:26:12 -0400
In-Reply-To: <BANLkTimFg_=KmCRVL=QoO9s-4+T3DmbNQw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maciej Grela <maciej.grela@gmail.com>
Cc: linux-ide@vger.kernel.org

On 11-04-29 04:57 PM, Maciej Grela wrote:
> 2011/4/29 Mark Lord <kernel@teksavvy.com>:
..
>> Then, try this:
>>
>> hdparm --security-set-pass NULL /dev/sdx
>> hdparm --security-erase NULL /dev/sdx
..
> I downloaded the newest hdparm but the result is the same - the first
> command fails with "Input/output error", verbose shows:
> 
> 8< --------------------------------------------------
> enki@hikari:~/hdparm-9.37$ sudo ./hdparm --verbose --security-set-pass
> NULL /dev
> /sdb
> 
> security_password=""
> 
> 
> /dev/sdb:
>  Issuing SECURITY_SET_PASS command, password="", user=user, mode=high
..
> SG_IO: ATA_16 status=0x2, host_status=0x0, driver_status=0x8
> 
> SG_IO: sb[]:  72 0b 00 00 00 00 00 0e 09 0c 00 04 00 00 00 00 00 00 00
> 00 e0 51 00 00 00 00 00 00 00 00 00 00
> 
> SG_IO: desc[]:  09 0c 00 04 00 00 00 00 00 00 00 00 e0 51
> 
>       ATA_16 stat=51 err=04 nsect=00 lbal=00 lbam=00 lbah=00 dev=e0
> 
> I/O error, ata_op=0xf4 ata_status=0x51 ata_error=0x04
> 
> SECURITY_ERASE: Input/output error

Okay.  Now please do exactly this (and I mean EXACTLY):

1. shut down and completely power off the system.
2. boot up again, and immediately do "hdparm --Istdout /dev/sdb
and post the results here.

I want to see what the default security state of the drive is,
and that sequence above will tell all.

Thanks.  Oh, and perhaps COPY ME on subsequent emails,
or I might miss your followups.  IOW, use "reply to all".

