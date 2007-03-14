From: =?UTF-8?B?TWF0aGlldSBCw6lyYXJk?= <Mathieu.Berard@crans.org>
Subject: Re: [3/6] 2.6.21-rc2: known regressions
Date: Wed, 14 Mar 2007 11:49:45 +0100
Message-ID: <45F7D349.10006@crans.org>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org> <20070305015036.GH3441@stusta.de> <45EE9E39.3010800@garzik.org> <45F20541.9090208@crans.org> <45F53B60.8020908@gmail.com> <45F69989.70702@crans.org> <45F69C02.2020206@gmail.com> <45F71003.4030003@crans.org> <45F7910C.6060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx-b.polytechnique.fr ([129.104.30.15]:40885 "EHLO
	mx-b.polytechnique.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161095AbXCNKtu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 06:49:50 -0400
In-Reply-To: <45F7910C.6060502@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Tejun Heo a =C3=A9crit :
> Hello,
>
>
> Due to blacklisting, NCQ
> won't be turned on your drive in future kernels.
>
>  =20
Hello thanks.
I have found on Hitachi website the technical datasheets of my drive
model:
http://www.hitachigst.com/tech/techlib.nsf/techdocs/28DCCB17E0EEC5A0862=
56F4E006E2F5B/$file/5K100_SATA_sp1.2.pdf
It seems to state that the drive does not support NCQ...

--
Mathieu

