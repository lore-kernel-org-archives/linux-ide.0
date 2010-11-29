From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: kernel problems with smart on LSI-92xx
Date: Mon, 29 Nov 2010 08:09:14 +0100
Message-ID: <878w0cmwrp.fsf@nemi.mork.no>
References: <4CD9A09D.7000508@ngs.ru> <87y690hs3r.fsf@nemi.mork.no>
	<4CEFD55D.8060200@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:44058 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341Ab0K2HWu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Nov 2010 02:22:50 -0500
In-Reply-To: <4CEFD55D.8060200@ngs.ru> (Artem Bokhan's message of "Fri, 26 Nov
	2010 21:42:21 +0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: linux-ide@vger.kernel.org

Artem Bokhan <aptem@ngs.ru> writes:

>   It appears that passing self-test command to SATA disk does not wor=
k
> too. Although nobody reports any error, self-test actually just does
> not start.
>
> smartctl -d megaraid,10 -t long /dev/sg0
>
> smartctl 5.40 2010-10-16 r3189 [x86_64-unknown-linux-gnu] (local buil=
d)
> Copyright (C) 2002-10 by Bruce Allen, http://smartmontools.sourceforg=
e.net
>
> /dev/sg0 [megaraid_disk_10] [SAT]: Device open changed type from 'meg=
araid' to 'sat'
> =3D=3D=3D START OF OFFLINE IMMEDIATE AND SELF-TEST SECTION =3D=3D=3D
> Sending command: "Execute SMART Extended self-test routine immediatel=
y
> in off-line mode".
> Drive command "Execute SMART Extended self-test routine immediately i=
n
> off-line mode" successful.
> Testing has begun.
> Please wait 255 minutes for test to complete.
> Test will complete after Sat Nov 27 01:54:44 2010
>
> Use smartctl -X to abort test.

I'm not sure I understand you correctly.  The above output looks
normal.  You mean that "smartctl -l selftest" doesn't show any test in
progress or finished?=20


Bj=C3=B8rn
