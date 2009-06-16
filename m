From: Thomas Jackowski <aXe@hadiko.de>
Subject: Re: Errors on ICH10R with Seagate HDDs
Date: Tue, 16 Jun 2009 03:59:25 +0200
Message-ID: <4A36FC7D.5050805@hadiko.de>
References: <49D4A232.3090504@hadiko.de> <49DE39E2.7070505@kernel.org> <49E847A3.9070100@hadiko.de> <49EAE746.4040303@kernel.org> <49F2E47C.5010803@hadiko.de> <49F3C03C.1090803@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.rz.uni-karlsruhe.de ([129.13.185.218]:44714 "EHLO
	smtp2.rz.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbZFPC2J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jun 2009 22:28:09 -0400
Received: from postamt.hadiko.de ([2001:638:204:10:21b:21ff:fe22:d9c2])
	by jordan.hadiko.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <aXe@hadiko.de>)
	id 1MGNxO-0006P7-0x
	for linux-ide@vger.kernel.org; Tue, 16 Jun 2009 03:59:26 +0200
In-Reply-To: <49F3C03C.1090803@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm using 2.6.29-2-amd64 now and the bug still exists (see previous
mails) with AHCI and NCQ enabled.

Maybe I should contact Seagate Support now?

I wonder that nobody else reported this sort of problem?

Tejun Heo wrote:
> Hello,
>=20
> Thomas Jackowski wrote:
>> some additional information (2.6.26-1) and ata_piix:
>> [653158.828848] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 actio=
n
>> 0x6 frozen
>> [653158.828856] ata3.00: cmd e5/00:00:00:00:00/00:00:00:00:00/00 tag=
 0
>> [653158.828857]          res 40/00:01:00:00:00/00:00:00:00:00/00 Ema=
sk
>> 0x4 (timeout)
>=20
> Hmmm... that's timeout on CHECK POWER.
>=20
>> [653158.828860] ata3.00: status: { DRDY }
>> [653158.828868] ata3: hard resetting link
>> [653159.331110] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
>> [653159.355648] ata3.00: configured for UDMA/133
>> [653159.355666] ata3: EH complete
>> [653159.371885] sd 2:0:0:0: [sde] 1953523055 512-byte hardware secto=
rs
>> (1000204 MB)
>> [653159.374081] sd 2:0:0:0: [sde] Write Protect is off
>> [653159.374081] sd 2:0:0:0: [sde] Mode Sense: 00 3a 00 00
>> [653159.390212] sd 2:0:0:0: [sde] Write cache: enabled, read cache:
>> enabled, doesn't support DPO or FUA
>>
>> I tried 2.6.29 and I had no outputs in kernel.log with AHCI and w/o =
NCQ.
>> But my system still had hiccups (system hangs for a second) so I am =
not
>> sure if there was just no output to kernel.log (due using debian
>> unstable kernel with eventually mysterious options).
>>
>> I will observe this and report if any error occurs again.
>=20
> Thanks.
>=20

--=20
Gru=DF,
Thomas

WWW: http://nice-pic.de
Hadifon: ~2127
E-Mail: aXe@hadiko.de

