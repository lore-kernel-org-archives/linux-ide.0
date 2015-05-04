From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Samsung 840 EVO
Date: Mon, 04 May 2015 12:21:52 -0400
Message-ID: <yq1y4l4s47z.fsf@sermon.lab.mkp.net>
References: <5547685F.7000103@web.de> <yq16188tl8v.fsf@sermon.lab.mkp.net>
	<mi84f3$vjo$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36112 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbEDQV4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2015 12:21:56 -0400
In-Reply-To: <mi84f3$vjo$1@ger.gmane.org> ("Sven =?utf-8?Q?K=C3=B6hler=22'?=
 =?utf-8?Q?s?= message of "Mon, 04
	May 2015 18:49:56 +0300")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sven =?utf-8?Q?K=C3=B6hler?= <sven.koehler@gmail.com>
Cc: linux-ide@vger.kernel.org

>>>>> "Sven" =3D=3D Sven K=C3=B6hler <sven.koehler@gmail.com> writes:

>> # hdparm -I /dev/sdN # smartctl -l gplog,0x13 /dev/sdN

Sven> I'm not sure the smartctl is helpful, since my machine has been
Sven> running with discard disabled for about half a day now.

It is helpful. It shows us that Samsung has indeed enabled queued TRIM
functionality in this firmware update.

--=20
Martin K. Petersen	Oracle Linux Engineering
