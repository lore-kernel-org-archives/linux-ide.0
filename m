From: Mark Lord <kernel@teksavvy.com>
Subject: Re: WD20EARS: finally reporting 4KByte sector size!
Date: Wed, 18 May 2011 15:13:26 -0400
Message-ID: <4DD41A56.3080601@teksavvy.com>
References: <4DD0A00D.3030104@teksavvy.com> <87zkmm7b6f.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:7395 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933393Ab1ERTN2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 May 2011 15:13:28 -0400
In-Reply-To: <87zkmm7b6f.fsf@nemi.mork.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: linux-ide@vger.kernel.org

On 11-05-16 02:27 PM, Bj=C3=B8rn Mork wrote:
> Mark Lord <kernel@teksavvy.com> writes:
>=20
>> I picked up my third WD 2TB "Green" drive today,
>> and lo and behold.. the firmware (51.0AB51) actually
>> reports the real physical sector size (finally!).
>>
>> TA device, with non-removable media
>>
>>         Model Number:       WDC WD20EARS-60MVWB0
>>
>>         Serial Number:      WD-WCAZA4297731
>>
>>         Firmware Revision:  51.0AB51
>=20
> It's not the firmware revision.  The '6' in the model number seems to
> make the difference. =20
>=20
> I've got two drives with exactly the same firmware revision, but with=
 a
> WD20EARS-00MVWB0 model mumber and lower serial number (it's still the=
 3
> platter version), and they both report 512 bytes:

Same here.  I have two drives which report the same "firmware revision"=
,
but one has the -6 in the model number and the other doesn't.
The one with the -6 reports 4096B sectors, the other does not.

I think WD is simply using the wrong field for firmware revisions,
as there are other apparent firmware differences between my two drives,
despite them having the same "firmware revision" numbers.

Gotta love WD.

Cheers
