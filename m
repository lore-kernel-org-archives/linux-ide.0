From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Faulty seagate drives, are going to be blacklisted?
Date: Tue, 20 Jan 2009 18:30:27 -0600
Message-ID: <49766CA3.7090508@shaw.ca>
References: <20090120002923.065f24ca@diego-desktop> <49753D09.8060503@shaw.ca> <20090120162612.7473aadf@diego-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:13652 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758799AbZAUAaa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jan 2009 19:30:30 -0500
In-Reply-To: <20090120162612.7473aadf@diego-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Diego Calleja wrote:
> El Mon, 19 Jan 2009 20:55:05 -0600, Robert Hancock <hancockr@shaw.ca>=
 escribi=C3=B3:
>=20
>> There are a few drives which are currently marked to disable NCQ and=
=20
>> warn the user that the firmware that should be upgraded:
>>
>> ST31500341AS
>> ST31000333AS
>> ST3640623AS
>> ST3640323AS
>> ST3320813AS
>> ST3320613AS
>>
>> all for firmware versions SD15 through SD19.
>=20
>=20
> Yes, I saw them, but apparently the NCQ bug is unrelated to this one.

I suspect it might be related, given that the firmware versions seem to=
=20
partially overlap.

With this issue though, there isn't anything the kernel can do about th=
e=20
problem, so blacklisting doesn't seem to really make much sense.
