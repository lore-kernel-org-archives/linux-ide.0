From: Marc Bejarano <beej@beej.org>
Subject: Re: [PATCH]drivers/ata/libata-eh.c:1509 unneeded memset()
Date: Mon, 11 Jan 2010 16:55:45 -0800
Message-ID: <5543f88f1001111655t7ae4a4eamd4f010b5ab7e7c82@mail.gmail.com>
References: <5543f88f1001111129u362be554kd97027d977b5dff3@mail.gmail.com>
	 <5543f88f1001111141r5375d2a3kd726d2b70e124b94@mail.gmail.com>
	 <4B4B877A.8060106@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:41411 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab0ALAzr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jan 2010 19:55:47 -0500
In-Reply-To: <4B4B877A.8060106@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Bolldorf?= <xsecute@googlemail.com>
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, James Bottomley <James.Bottomley@suse.de>, linux-kernel@vger.kernel.org, jgarzik@pobox.com

2010/1/11 Ren=E9 Bolldorf <xsecute@googlemail.com>:
> I hope that's good enough explained :-).

definitely an improvement, but i think jeff is going to want your
S-O-B and at least a patch title, if no description :)


> + =A0 =A0 =A0 /* make sure sense_buf is cleared then atapi_eh_request=
_sense is
> called.

s/then/when/ ?

> + =A0 =A0 =A0 =A0* (to make sure nothing get's reused.)

probably not necessary

> + =A0 =A0 =A0 =A0* thanks to James Bottomley

this may be better in a patch description

cheers,
marc
