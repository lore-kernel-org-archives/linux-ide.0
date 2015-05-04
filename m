From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Samsung 840 EVO
Date: Mon, 04 May 2015 12:24:22 -0400
Message-ID: <yq1twvss43t.fsf@sermon.lab.mkp.net>
References: <5547685F.7000103@web.de> <yq16188tl8v.fsf@sermon.lab.mkp.net>
	<55479C21.8020608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:31064 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbbEDQY1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2015 12:24:27 -0400
In-Reply-To: <55479C21.8020608@web.de> (=?utf-8?Q?=22G=C3=BCnter?= Waller"'s
 message of "Mon, 04
	May 2015 18:19:45 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?utf-8?Q?G=C3=BCnter?= Waller <g.wal@web.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

>>>>> "G=C3=BCnter" =3D=3D G=C3=BCnter Waller <g.wal@web.de> writes:

G=C3=BCnter> the second command, however, did not seem to produce anyth=
ing
G=C3=BCnter> useful.  But beware: this is the old firmware, EXT0BB6Q,

Yes, this confirms that the old firmware did not support queued
TRIM. Whereas the new one does.

I'll try to reach out to my contacts at Samsung again so we can get thi=
s
resolved.

Until then, I have sent out a patch that blacklists queued TRIM for all
Samsung 800-series drives. It appears to be generic to their
implementation and not tied to a particular drive model.

--=20
Martin K. Petersen	Oracle Linux Engineering
