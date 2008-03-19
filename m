From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Wed, 19 Mar 2008 12:26:23 +0900
Message-ID: <47E087DF.7070101@gmail.com>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <200803181159.48327.volker.armin.hemmann@tu-clausthal.de> <47DFBBE2.7050304@gmail.com> <200803181433.12584.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.190]:23930 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932898AbYCSUXx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Mar 2008 16:23:53 -0400
Received: by rn-out-0910.google.com with SMTP id v46so545220rnb.15
        for <linux-ide@vger.kernel.org>; Wed, 19 Mar 2008 13:23:52 -0700 (PDT)
In-Reply-To: <200803181433.12584.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Volker Armin Hemmann wrote:
> On Dienstag, 18. M=E4rz 2008, Tejun Heo wrote:
>>  failed message on reboots).
>>
>>> Of course, I booted and rebooted several times. And it stays.
>>>
>>> Maybe it is the hardware. But I replaced the cables already and sma=
rt
>>> says the disk is ok.
>> Does the attached patch make any difference?
>=20
> patching file drivers/ata/ahci.c
> Hunk #1 succeeded at 397 (offset -5 lines).
> Hunk #2 succeeded at 1819 (offset -45 lines).

It's okay.  It's because I was lazy and generated the patch against
devel tree.

> built&booted, same results as allways. With non-raid setting, IDENTIF=
Y error=20
> on cold boot and sofreset error on reboot:
> (with patch, without nosmi):

Oh... I see.  I made a mistake.  In ahci.c, what I intended was making
ahci_softreset NULL not ahci_hardreset.  Can you please change that and
test again?

--=20
tejun
