From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Samsung 840 EVO
Date: Mon, 04 May 2015 11:28:48 -0400
Message-ID: <yq16188tl8v.fsf@sermon.lab.mkp.net>
References: <5547685F.7000103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:31139 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbEDP2x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2015 11:28:53 -0400
In-Reply-To: <5547685F.7000103@web.de> (=?utf-8?Q?=22G=C3=BCnter?= Waller"'s
 message of "Mon, 04
	May 2015 14:38:55 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?utf-8?Q?G=C3=BCnter?= Waller <g.wal@web.de>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

>>>>> "G=C3=BCnter" =3D=3D G=C3=BCnter Waller <g.wal@web.de> writes:

G=C3=BCnter> the subject Samsung SSD is having performance issues with =
"old
G=C3=BCnter> data" which Samsung now addresses with a new firmware.

I wonder if they enabled the same botched queued discard that they did
in 850 Pro?

If someone has an 840 Evo with the new firmware it would be helpful for
us to receive the output of:

# hdparm -I /dev/sdN
# smartctl -l gplog,0x13 /dev/sdN

I think I might have an 840 in the lab. Will head down and update it
later this week unless somebody beats me to providing the information
above.

--=20
Martin K. Petersen	Oracle Linux Engineering
