From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [BUG] libahci returns stale result tf much of the time.
Date: Fri, 24 Sep 2010 09:24:03 -0400
Message-ID: <4C9CA673.4090104@teksavvy.com>
References: <4C9C3878.9010206@teksavvy.com> <AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com> <4C9C44D0.1030409@teksavvy.com> <AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com> <4C9CA385.5090709@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:51123 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752221Ab0IXNYG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Sep 2010 09:24:06 -0400
In-Reply-To: <4C9CA385.5090709@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Seed <seedrubbish@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 10-09-24 09:11 AM, Mark Lord wrote:
> On 10-09-24 03:01 AM, Seed wrote:
>> On Fri, Sep 24, 2010 at 4:27 PM, Mark Lord<kernel@teksavvy.com> wrote:
>>> The bug seems to be in the libahci code somewhere.
>>
>> ahci_qc_fill_rtf seems to be the function converting FIS to result_tf.
> ..
>
> Yeah, that's as far as I got with it last night.
> If you apply this patch (below), it makes the problem more "obvious",
> though I still don't see exactly how that struct gets updated.
>
> --- a/drivers/ata/libahci.c 2010-09-24 02:40:24.722887047 -0400
> +++ b/drivers/ata/libahci.c 2010-09-24 09:10:21.761520099 -0400
> @@ -1838,6 +1838,7 @@
> d2h_fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
>
> ata_tf_from_fis(d2h_fis, &qc->result_tf);
> + memset(d2h_fis, 0xfd, AHCI_RX_FIS_SZ);
> return true;
> }
>
..

And here's an example of the bug, which should work (as a demo)
for most folks out there with the same controller ahci / JMB360:

Here, I'll use hdparm to do a "set acoustic" command
on a drive which does NOT have the "Acoustic Management" feature set.
Just look for the fd fd fd strings in the returned data,
and notice how the final IDENTIFY at the end works, but returns
bad ATA status 0x51 from the stale result_tf:

[~] hdparm --verbose -M128 /dev/sdb

/dev/sdb:
  setting acoustic management to 128
outgoing cdb:  85 06 20 00 42 00 80 00 00 00 00 00 00 40 ef 00
SG_IO: ATA_16 status=0x2, host_status=0x0, driver_status=0x8
SG_IO: sb[]:  72 00 00 00 00 00 00 0e 09 0c 00 00 00 80 00 00 00 00 00 00 e0 50 00 00 00 00 00 00 00 00 00 00
SG_IO: desc[]:  09 0c 00 00 00 80 00 00 00 00 00 00 e0 50
       ATA_16 stat=50 err=00 nsect=80 lbal=00 lbam=00 lbah=00 dev=e0
outgoing cdb:  85 08 2e 00 00 00 00 00 00 00 00 00 00 40 ec 00
SG_IO: ATA_16 status=0x2, host_status=0x0, driver_status=0x8
SG_IO: sb[]:  72 0b 47 00 00 00 00 0e 09 0c 00 fd 00 fd 00 fd 00 fd 00 fd fd fd 00 00 00 00 00 00 00 00 00 00
incoming_data:  5a 04 ff 3f c8 37 10 00 00 00 00 00 3f 00 00 00 00 00 00 00 20 20 20 20 20 20 4e 56 43 36 48 4d 43 43 54 44 32 59 44 4e 03 00 04 3e 04 00 33 56 4f 33 36 41 41 4d 44 48 37 53 32 32 31 35 56 32 53 4c 38 41 20 30 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 10 80 00 00 00 2f 00 40 00 02 00 02 07 00 ff 3f 10 00 3f 00 10 fc fb 00 00 01 40 41 61 0e 00 00 07 00 03 00 78 00 78 00 f0 00 78 00 00 00 00 00 00 00 00 00 00 00 00 00 1f 00 02 00 00 00 00 00 00 00 7c 00 19 00 eb 74 ea 7f 23 40 e9 74 02 3e 23 40 3f 20 21 00 00 00 00 00 fe ff 00 00 80 80 00 00 00 00 00 00 00 00 00 00 40 41 61 0e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 0b 00 00 0
 0 00 00 82 3a b1 0c 60 fe 01 00 00 40 00 00 00 00 00 00 00 00 f7 01 04 2a 00 14 00 04 80 02 7f 3f c0 00 40 00 00 ac 00 80 00 00 4f 33 36 43 00 00 13 c0 00 00 00 00 00 00 00 00 00 00 00 00 00
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a5 c0
SG_IO: desc[]:  09 0c 00 fd 00 fd 00 fd 00 fd 00 fd fd fd
       ATA_16 stat=fd err=fd nsect=fd lbal=fd lbam=fd lbah=fd dev=fd
I/O error, ata_op=0xec ata_status=0xfd ata_error=0xfd
outgoing cdb:  85 08 2e 00 00 00 00 00 00 00 00 00 00 40 a1 00
SG_IO: ATA_16 status=0x2, host_status=0x0, driver_status=0x8
SG_IO: sb[]:  72 0b 00 00 00 00 00 0e 09 0c 00 04 00 00 00 00 00 00 00 00 e0 51 00 00 00 00 00 00 00 00 00 00
incoming_data:  5a 04 ff 3f c8 37 10 00 00 00 00 00 3f 00 00 00 00 00 00 00 20 20 20 20 20 20 4e 56 43 36 48 4d 43 43 54 44 32 59 44 4e 03 00 04 3e 04 00 33 56 4f 33 36 41 41 4d 44 48 37 53 32 32 31 35 56 32 53 4c 38 41 20 30 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 10 80 00 00 00 2f 00 40 00 02 00 02 07 00 ff 3f 10 00 3f 00 10 fc fb 00 00 01 40 41 61 0e 00 00 07 00 03 00 78 00 78 00 f0 00 78 00 00 00 00 00 00 00 00 00 00 00 00 00 1f 00 02 00 00 00 00 00 00 00 7c 00 19 00 eb 74 ea 7f 23 40 e9 74 02 3e 23 40 3f 20 21 00 00 00 00 00 fe ff 00 00 80 80 00 00 00 00 00 00 00 00 00 00 40 41 61 0e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 0b 00 00 0
 0 00 00 82 3a b1 0c 60 fe 01 00 00 40 00 00 00 00 00 00 00 00 f7 01 04 2a 00 14 00 04 80 02 7f 3f c0 00 40 00 00 ac 00 80 00 00 4f 33 36 43 00 00 13 c0 00 00 00 00 00 00 00 00 00 00 00 00 00
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a5 c0
SG_IO: desc[]:  09 0c 00 04 00 00 00 00 00 00 00 00 e0 51
       ATA_16 stat=51 err=04 nsect=00 lbal=00 lbam=00 lbah=00 dev=e0
I/O error, ata_op=0xa1 ata_status=0x51 ata_error=0x04
  HDIO_DRIVE_CMD(identify) failed: Input/output error
