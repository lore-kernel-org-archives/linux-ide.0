From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Samsung 840 EVO
Date: Mon, 04 May 2015 12:35:50 -0400
Message-ID: <yq1pp6gs3kp.fsf@sermon.lab.mkp.net>
References: <5547685F.7000103@web.de> <yq16188tl8v.fsf@sermon.lab.mkp.net>
	<mi84f3$vjo$1@ger.gmane.org> <yq1y4l4s47z.fsf@sermon.lab.mkp.net>
	<55479DF0.9090405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:38148 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbbEDQfy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2015 12:35:54 -0400
In-Reply-To: <55479DF0.9090405@gmail.com> ("Sven =?utf-8?Q?K=C3=B6hler=22'?=
 =?utf-8?Q?s?= message of "Mon, 04
	May 2015 19:27:28 +0300")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sven =?utf-8?Q?K=C3=B6hler?= <sven.koehler@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

>>>>> "Sven" =3D=3D Sven K=C3=B6hler <sven.koehler@gmail.com> writes:

>> It is helpful. It shows us that Samsung has indeed enabled queued
>> TRIM functionality in this firmware update.

Sven> Are you saying that previous firmwares didn't claim that the driv=
e
Sven> supports queued TRIM. But the new firmware does - even though the
Sven> feature appears to be broken?

Correct. The old firmware releases for this drive did not advertise
support for queued TRIM whereas the new one does. We saw exactly the
same issue with a firmware update for 850 Pro.

--=20
Martin K. Petersen	Oracle Linux Engineering
