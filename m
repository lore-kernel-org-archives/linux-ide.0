From: Douglas Gilbert <dougg@torque.net>
Subject: Re: [PATCH] libata: fix ATA passthrough handling for ATAPI devices
Date: Sat, 21 Oct 2006 16:00:43 -0400
Message-ID: <453A7C6B.3050108@torque.net>
References: <20061020050948.GF13677@htj.dyndns.org> <453A720C.6070905@pobox.com>
Reply-To: dougg@torque.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:39352 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423388AbWJUT7T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Oct 2006 15:59:19 -0400
In-Reply-To: <453A720C.6070905@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> libata used to pass all SCSI commands directly to ATAPI devices.
>> However, this is incorrect for ATA passthrough commands as they must
>> be handled by the SAT layer in libata.  Also, regardless of the
>> attached ATAPI device's supported packet length, SAT says that both
>> flavors of passthrough commands (ATA12 and ATA16) should work.
>>
>> This patch makes the following changes to fix ATA passthrough handling
>> for ATAPI devices.
>>
>> * implement atapi_get_xlat_func() and make libata handle ATA12 and
>>   ATA16 in SAT layer instead of passing it directly to the target
>>   device even if the device is ATAPI.
>>
>> * Always allow 16byte CDBs for ATAPI devices.  This makes
> 
> This is definitely wrong.  Some ATAPI devices are limited to 12-byte CDBs.

Jeff,
The 16 byte CDB that Tejun is talking about is the
ATA PASS THROUGH (16) SCSI command. That is valid to
send to SATL (in front of a ATAPI device) for certain
values of EXTEND and T_LENGTH in that CDB (see
sat-r09.pdf section 12.2.4).

> Also, are we sure that no ATAPI device ever implements these opcodes?

The SATL is on the computer side of the ATAPI host
(initiator) so the ATA PASS THROUGH (12+16) SCSI
commands should never be seen by the ATAPI device
(target). Reason: the SATL translates those SCSI
commands into ATA commands prior to them being presented
to the ATAPI host.

> Prior to the SAT spec -- which includes most ATAPI firmwares -- those
> opcodes might have been vendor-reserved space.  Did you or Doug verify
> against the older specifications who might care about these opcodes?

The only clash between MMC and SATL SCSI opcodes is
with opcode 0xA1: BLANK in MMC and ATA PASS THROUGH (12)
in SAT. So, in the future, one way to resolve this is
to optionally tell the SATL not to translate the ATA PASS
THROUGH (12) SCSI command and send it through to the
ATAPI device which would interpret it as BLANK. That would
leave SATL users with the ATA PASS THROUGH (16) SCSI command
for sending ATA commands to the ATAPI device. And that ....
is definitely valid IMO.

> Or maybe there is a flag somewhere we can abuse, that permits support of
> both scenarios -- passing the command to the device, and handling the
> command internally?

This is all about being able to send ATA commands to
ATAPI devices that are valid for PACKET devices, examples:
    IDENTIFY PACKET DEVICE
    SET FEATURES
    IDENTIFY DEVICE (should abort command + set signature)
    DEVICE RESET
and I assume there are others.

Doug Gilbert

