From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 1/3] libata: Add another column to the ata_timing table.
Date: Wed, 10 Dec 2008 17:50:33 -0800
Message-ID: <494071E9.2010808@caviumnetworks.com>
References: <494052D1.10208@caviumnetworks.com> <1228952353-12323-1-git-send-email-ddaney@caviumnetworks.com> <49405640.4020205@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13587 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbYLKBvG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Dec 2008 20:51:06 -0500
In-Reply-To: <49405640.4020205@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org

Sergei Shtylyov wrote:
> Hello.
>=20
> David Daney wrote:
>> The forthcoming OCTEON SOC Compact Flash driver needs an additional
>> timing value that was not available in the ata_timing table.  I add =
a
>> new column for dmack_hold time.  The values were obtained from the
>> Compact Flash specification Rev 4.1.
>>  =20
>=20
>   Note that I wasn't telling you to drop t4, just to correct its valu=
e=20
> for SWDMA modes.
>=20

I decided I don't need it, so I tried to drop it...


>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>>  =20
>=20
>   NAK, patch broken.
>=20
[...]
>
>> @@ -864,6 +866,8 @@ struct ata_timing {
>>      unsigned short cyc8b;        /* t0 for 8-bit I/O */
>>      unsigned short active;        /* t2 or tD */
>>      unsigned short recover;        /* t2i or tK */
>> +    unsigned short write_hold;    /* t4 */
>> +    unsigned short dmack_hold;    /* tj */
>>      unsigned short cycle;        /* t0 */
>>      unsigned short udma;        /* t2CYCTYP/2 */
>>  };
>>  =20
>=20
>   This is broken. You're still adding 2 fields but initializer doesn=FD=
=20
> much that.
>=20

Sorry about that.  I am testing a fixed version.

David Daney
