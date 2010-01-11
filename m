From: Tejun Heo <tj@kernel.org>
Subject: Re: Rapidly increasing Load_Cycle_Count on Acer 2930z
Date: Mon, 11 Jan 2010 17:33:55 +0900
Message-ID: <4B4AE273.9050005@kernel.org>
References: <200912151956.02364.kailed@kailed.net> <4B2F3034.1030208@kernel.org> <200912211833.26000.kailed@kailed.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55433 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187Ab0AKI2O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Jan 2010 03:28:14 -0500
In-Reply-To: <200912211833.26000.kailed@kailed.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kailed@kailed.net
Cc: linux-ide@vger.kernel.org

On 12/22/2009 02:33 AM, Daniele wrote:
> Il luned=C3=AC 21 dicembre 2009, Tejun Heo scrisse:
>> On 12/16/2009 03:56 AM, Daniele wrote:
>>> Hi folks,
>>> on my acer2930z Load_Cycle_Count increase every 5 seconds when
>>> idle.
>>>
>>> Setting APM_LEVEL to 200 (default 128) fix the issue, LCC doesn't
>>> not increase anymore.
>>
>> Can you please *attach* the outputs and also include the output of
>> dmidecode for later reference?
> Which outputs ? hdparm, smarctl or both ?
>=20
> So tell me exactly which outputs do you want and if before or after=20
> changing the APM value.
>=20
> Dmidecode attached.

Added to storage-fixup and recorded on ata-wiki.

Thanks.

--=20
tejun
