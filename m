From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv, io stucks
Date: Thu, 23 Oct 2008 12:07:11 -0400
Message-ID: <4900A12F.3030307@rtr.ca>
References: <48F88449.1000704@ngs.ru> <49003B9C.1010303@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:33404 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757142AbYJWQGi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Oct 2008 12:06:38 -0400
In-Reply-To: <49003B9C.1010303@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: linux-ide@vger.kernel.org

Artem Bokhan wrote:
> Any thought?
>=20
> Artem Bokhan =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> I try to simulate random reads  with "sysbench --test=3Dfileio=20
>> --num-threads=3D16 --max-requests=3D9999999 --max-time=3D60 --init-r=
ng=3Don=20
>> --file-num=3D16 --file-fsync-freq=3D0 --file-test-mode=3Drndrd=20
>> --file-total-size=3D30G run"
>>
>> Two marvell controllers, 16 disks, software raid10, IO stucks on=20
>> different disks, kernel 2.6.26.5.
>> With default ubuntu's 8.04 2.6.24 kernel the problem can not be repe=
ated
>>
>>
>> [  289.851609] ata11.00: exception Emask 0x0 SAct 0x1 SErr 0x0 actio=
n=20
>> 0x6 frozen
>> [  289.851695] ata11.00: cmd 61/08:00:60:1e:bf/00:00:01:00:00/40 tag=
 0=20
>> ncq 4096 out
>> [  289.851697]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emas=
k=20
>> 0x4 (timeout)
>> [  289.851774] ata11.00: status: { DRDY }
>> [  289.851834] ata11: hard resetting link
>> [  290.649259] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
>> [  290.749239] ata11.00: max_sectors limited to 256 for NCQ
>> [  290.809189] ata11.00: max_sectors limited to 256 for NCQ
>> [  290.809194] ata11.00: configured for UDMA/133
>> [  290.809200] ata11: EH complete
>> [  290.809242] sd 10:0:0:0: [sdk] 1953525168 512-byte hardware secto=
rs=20
>> (1000205 MB)
>> [  290.809258] sd 10:0:0:0: [sdk] Write Protect is off
>> [  290.809263] sd 10:0:0:0: [sdk] Mode Sense: 00 3a 00 00
>> [  290.809286] sd 10:0:0:0: [sdk] Write cache: enabled, read cache:=20
>> enabled, doesn't support DPO or FUA
=2E..

I've just returned here from a month holiday in Italy,
and I'll have a look at this and other sata_mv issues
next week or so.

Cheers
