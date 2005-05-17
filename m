From: "Eric A. Cottrell" <eac@shore.net>
Subject: Re: [PATCH 2.6.12-rc2 2/2] libata: add basic atapi error reporting
Date: Mon, 16 May 2005 23:02:31 -0400
Message-ID: <42895EC7.4060706@shore.net>
References: <4261C20B.7010403@shore.net> <428808B4.8040102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.primushost.com ([209.58.220.66]:3793 "EHLO
	smtp2.primushost.com") by vger.kernel.org with ESMTP
	id S261315AbVEQDCV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 May 2005 23:02:21 -0400
In-Reply-To: <428808B4.8040102@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Eric A. Cottrell wrote:
>> Hello Jeff,
>>
>> Problem:
>> ATAPI errors are not fully reported to the SCSI subsystem.  A check 
>> condition was returned but the SCSI subsystem does not get the sense 
>> from the device.  This causes problems when unimplemented and bad SCSI 
>> commands are sent to an atapi device.
> 
> This is a bit strange.  It should get the sense from the device.  It is 
> requested from ata_qc_timeout().  Is this not happening for you?
> 
>     Jeff
> 
> 
> 
Hello,

It does not seem to work in all cases.  I had the most trouble with the 
AHCI driver.  I wish to withdraw part 2 of the patch because I realize 
that this is only an incomplete solution.  Full sense information needs 
to be sent to the SCSI subsystem for it to work properly.  I was able to 
modify the driver to Autosense on ATAPI errors and improved it.  It is 
not complete yet.

I am still having problems.  I can burn a CD but not a DVD.  On a 
working drive there is a long delay as the DVD lead-in is written then 
the written data amount will increase.  With libata it appears that 
something is timing out way too quickly (within a second) and the 
burning program stops with an error.

I need to setup git and grab the libata-dev stuff before I continue.

73 Eric
