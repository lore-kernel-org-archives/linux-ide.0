From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix ATA passthrough handling for ATAPI devices
Date: Sat, 21 Oct 2006 16:13:31 -0400
Message-ID: <453A7F6B.1010205@pobox.com>
References: <20061020050948.GF13677@htj.dyndns.org> <453A720C.6070905@pobox.com> <453A7C6B.3050108@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:25985 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161494AbWJUUNf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Oct 2006 16:13:35 -0400
In-Reply-To: <453A7C6B.3050108@torque.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dougg@torque.net
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Douglas Gilbert wrote:
> The 16 byte CDB that Tejun is talking about is the
> ATA PASS THROUGH (16) SCSI command. That is valid to

I'm talking about the changes to the implementation, which appear to 
mistakenly allow 16-byte CDBs through to the ATAPI device, even if it 
only supports 12-byte CDBs.

I am quite aware of the ATA passthru SCSI command.  Heck, the spec had 
input from me.  I'm talking about something different.


> The only clash between MMC and SATL SCSI opcodes is
> with opcode 0xA1: BLANK in MMC and ATA PASS THROUGH (12)

Ok, so the answer is, yes there is a clash, and thus this change will 
remove the ability for working-today setups to use BLANK.

In order to avoid breaking working setups, a method must be found which 
tells the SATL to not filter out the ATA passthru commands.


> This is all about being able to send ATA commands to
> ATAPI devices that are valid for PACKET devices, examples:
>     IDENTIFY PACKET DEVICE
>     SET FEATURES
>     IDENTIFY DEVICE (should abort command + set signature)
>     DEVICE RESET
> and I assume there are others.

I am quite aware of the purpose of ATA passthru :)

	Jeff


