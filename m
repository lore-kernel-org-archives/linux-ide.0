From: Douglas Gilbert <dougg@torque.net>
Subject: Re: [PATCH] libata: fix ATA passthrough handling for ATAPI devices
Date: Sat, 21 Oct 2006 17:18:14 -0400
Message-ID: <453A8E96.9040702@torque.net>
References: <20061020050948.GF13677@htj.dyndns.org> <453A720C.6070905@pobox.com> <453A7C6B.3050108@torque.net> <453A7F6B.1010205@pobox.com>
Reply-To: dougg@torque.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:32408 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161066AbWJUVQs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Oct 2006 17:16:48 -0400
In-Reply-To: <453A7F6B.1010205@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Douglas Gilbert wrote:
>> The 16 byte CDB that Tejun is talking about is the
>> ATA PASS THROUGH (16) SCSI command. That is valid to
> 
> I'm talking about the changes to the implementation, which appear to
> mistakenly allow 16-byte CDBs through to the ATAPI device, even if it
> only supports 12-byte CDBs.
> 
> I am quite aware of the ATA passthru SCSI command.  Heck, the spec had
> input from me.  I'm talking about something different.

This is what I saw, with the new ATA subsystem in
lk 2.6.19-rc1:

[root@sas ~]# lsscsi -H
[0]    sata_nv
[1]    sata_nv
[2]    sata_nv
[3]    sata_nv
[4]    pata_amd
[5]    pata_amd
[6]    mptsas
[7]    aic94xx

[root@sas ~]# lsscsi
[1:0:0:0]    disk    ATA      ST380013AS       3.18  /dev/sdb
[4:0:0:0]    disk    ATA      ST380011A        8.01  /dev/sda
[5:0:1:0]    cd/dvd  HL-DT-ST DVD-ROM GDR8163B 0L23  /dev/scd0

[root@sas ~]# sg_sat_identify --packet /dev/scd0 -vv
open /dev/scd0 with flags=0x802
    ATA pass through (16) cdb: 85 08 0e 00 00 00 01 00 00 00 00 00 00 00 a1 00
ATA pass through (16): transport error: Host_status=0x05 [DID_ABORT]
Driver_status=0x00 [DRIVER_OK, SUGGEST_OK]
ATA pass through (16) failed

[root@sas ~]# sg_sat_identify --packet --len=12 /dev/scd0 -vv
open /dev/scd0 with flags=0x802
    ATA pass through (12) cdb: a1 08 0e 00 01 00 00 00 00 a1 00 00
ATA pass through:  Fixed format, current;  Sense key: Illegal Request
 Additional sense: Invalid command operation code



The above were attempts to send IDENTIFY PACKET DEVICE
to the PATAPI cd/dvd drive via the ATA PASS THROUGH
(16 and 12) commands respectively. The first one caught
my attention. Why did it fail with a DID_ABORT?

Whatever the reason both responses are wrong. The second
one is wrong because
  - the cd/dvd drive does support that opcode (the error
    should be either not ready or incompatible format), or
  - it didn't do the ATA PASS THROUGH (12) properly

>> The only clash between MMC and SATL SCSI opcodes is
>> with opcode 0xA1: BLANK in MMC and ATA PASS THROUGH (12)
> 
> Ok, so the answer is, yes there is a clash, and thus this change will
> remove the ability for working-today setups to use BLANK.
> 
> In order to avoid breaking working setups, a method must be found which
> tells the SATL to not filter out the ATA passthru commands.

Or, as a temporary solution, if the device is ATAPI
carrying a SCSI command set with pdt=5 then:
  1) opcode 0xa1 goes straight through (i.e. BLANK)
  2) opcode 0x85 works as defined by sat-r09.pdf
     (implements the ATA PASS THROUGH (16) SCSI command)

>> This is all about being able to send ATA commands to
>> ATAPI devices that are valid for PACKET devices, examples:
>>     IDENTIFY PACKET DEVICE
>>     SET FEATURES
>>     IDENTIFY DEVICE (should abort command + set signature)
>>     DEVICE RESET
>> and I assume there are others.
> 
> I am quite aware of the purpose of ATA passthru :)

... and I do comparative analysis of SAT layers and
send bug reports.

Doug Gilbert
