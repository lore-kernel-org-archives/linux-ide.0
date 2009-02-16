From: Tejun Heo <tj@kernel.org>
Subject: Re: Drives which perform frequent head unloads under Linux
Date: Mon, 16 Feb 2009 12:52:39 +0900
Message-ID: <4998E307.2010903@kernel.org>
References: <200902031429.19457.fcartegnie@free.fr> <499380D2.5070306@kernel.org> <200902121414.46309.fcartegnie@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49121 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755965AbZBPDw5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Feb 2009 22:52:57 -0500
In-Reply-To: <200902121414.46309.fcartegnie@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Francois Cartegnie <fcartegnie@free.fr>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

=46rancois Cartegnie wrote:
> Le jeudi 12 f=C3=A9vrier 2009, vous avez =C3=A9crit :
>> Francois Cartegnie wrote:
>>> MSI Megabook S425
>>> MK8025GAS (unload every 8/10sec)
>>> Workaround with APM to 254 (but doesn't disable totally).
>> From the smartctl output,
>>
>>   9 Power_On_Hours     ...      2791
>> 193 Load_Cycle_Count   ...      100209
>>
>> Which gives us 35.9 load cycles per hour which is kind of okay.  Is
>> this because you have been running the system with APM value adjuste=
d?
>=20
> The system has been fixed early, so It's not revealant.
> The head clicks 3-4 seconds after the disk activity, which means that=
 if you=20
> are using ext3 with default commit time, you have a cycle every 5-6 s=
econds.

Alright, added and pushed out.  Thanks.

--=20
tejun
