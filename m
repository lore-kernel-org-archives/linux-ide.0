From: Tejun Heo <htejun@gmail.com>
Subject: Re: 40-wire cable detected when directly connected
Date: Sun, 13 Jan 2008 15:06:17 +0900
Message-ID: <4789AA59.5010207@gmail.com>
References: <200801101824.04863.Tobias_Mueller@twam.info> <4786E82A.7010208@gmail.com> <47875755.4000109@twam.info> <47883378.9060507@gmail.com> <4788C342.2000308@twam.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:25441 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbYAMGGW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 01:06:22 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1390147rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 22:06:22 -0800 (PST)
In-Reply-To: <4788C342.2000308@twam.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?VG9iaWFzIE3DvGxsZXI=?= <Tobias_Mueller@twam.info>
Cc: linux-ide@vger.kernel.org

Tobias M=C3=BCller wrote:
> Hi
>=20
>> Please apply the attached patch and specify libata.force_cbl=3D80 as
>> kernel boot parameter.  If you load libata from initrd or after boot=
 you
>> need to pass 'force_cbl=3D80' as module parameter.  How you do it de=
pends
>> on your distro.

Ah.. right.  I'm brewing more complete debug helper patch.  I'll take
the above into consideration.

--=20
tejun
