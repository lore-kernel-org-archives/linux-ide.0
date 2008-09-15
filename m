From: Tejun Heo <tj@kernel.org>
Subject: Re: XFS shutting down due to IO timeout on SATA disk (pata_via for
 CX700)
Date: Mon, 15 Sep 2008 13:43:30 -0700
Message-ID: <48CEC8F2.4040904@kernel.org>
References: <20080911193511.7960bc82@neptune.home>	<48CE22E5.9090403@kernel.org> <20080915190242.58d21a8f@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56973 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbYIOUp1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Sep 2008 16:45:27 -0400
In-Reply-To: <20080915190242.58d21a8f@neptune.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Hello,

Bruno Pr=E9mont wrote:
> On Mon, 15 September 2008 Tejun Heo <tj@kernel.org> wrote:
>> (please try to wrap paragraphs for 80 column)
> I try not to break lines from dmesg, lspci and and other commands'
> (formatted) output as those tend to get pretty hard to read when
> line-wrapped.  Sorry if I wrapped my text after 80 columns.

Yeap, I was talking only about the text.  Not wrapping outputs and
code snippets is definitely better.

>> Timeout on FLUSH_EXT.  That's a bad sign.  Patch to retry FLUSH is
>> pending but at any rate FLUSH failure is often accompanied by loss o=
f
>> data and XFS is doing the right thing of giving up on it.
>>
>> Can you please post the result of "smartctl -a /dev/sda"?
> I checked it though there were no errors logged nor any other informa=
tion
> that would catch attention. The disk/machine is pretty unused (a year=
 old
> but low uptime, a few hours those days with uptime)
>=20
> Anyhow smaprtctl's output is blow.
>=20

>   5 Reallocated_Sector_Ct   0x0033   100   100   024    Pre-fail  Alw=
ays       -       8589934592000

Whee... That's unusally high realloc count but I'm not sure whether it
indicates actual problem or it's just the drive's way of saying I'm
okay.  But this does look quite suspicious.

> 196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Alw=
ays       -       441778176

Hmmm.. Do you happen to have drives of the same model?  If so, can you
please check what other drives are reporting?

Thanks.

--=20
tejun
