From: =?iso-8859-1?Q?Oddbj=F8rn?= Kvalsund <oddbjorn@nixx.no>
Subject: Re: Possible performance issue with sata_sil og Gigabyte i-Ram
Date: Wed, 24 Jan 2007 14:18:36 +0100
Message-ID: <20070124131836.GM1054@nixx.no>
References: <20070123205301.GK1054@nixx.no> <45B6884E.3030100@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nixx.no ([80.68.92.62]:34390 "EHLO nixx.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbXAXNWs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Jan 2007 08:22:48 -0500
Content-Disposition: inline
In-Reply-To: <45B6884E.3030100@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Tue 23 Jan 17:12, Jeff Garzik wrote:
> However, I am unable to keep it from corrupting data.  I primarily us=
e=20
> it on sil3114, just like your hardware, but I have the same problems=20
> with other controllers.
>=20
> My gut feeling is that the i-RAM has very strict RAM model requiremen=
ts,=20
> and needs the latest firmware, but I have not yet tested these hypoth=
eses.

Hm, that's a pity! I have used an Apacer 512 MB PC2700 module in my i-R=
am
for testing, but I have ordered two Kingston KVR400X64C3A/1G sticks
that are on Gigabytes list of recommended ram modules[1].

The Apacer module hasn't given my any trouble though. I ran some stress
tests on it last night, bonnie++[2] and stress[3] for a few hours, and
as far as I could tell this didn't screw up the file system in any way.
Do you have any test applications that can reproduce the error on your
i-Ram? I'd be more than happy to do some testing both using my old
Apacer module and the new Kingston modules when they arrive.

With regards to the i-Ram being picky about RAM, check this post:
http://www.nerdnos.net/?newsarchives
According to this guy, the i-Ram does not support high density ram
modules. Could this be what's causing your data/file system corruption?

[1]: http://www.gigabyte.com.tw/Support/Peripherals/FAQ_Model.aspx?FAQI=
D=3D2152&ProductID=3D2076
[2]: http://www.coker.com.au/bonnie++/
[3]: http://weather.ou.edu/~apw/projects/stress/

--=20
Oddbj=F8rn Kvalsund
