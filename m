From: Jure =?UTF-8?Q?Pe=C3=A8ar?= <pegasus@nerv.eu.org>
Subject: Re: [chrisc@terminalarrogance.com: RE: Bug#258500: Installer fails
 to recognise SiI3112 hw RAID array]
Date: Mon, 19 Jul 2004 00:21:18 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040719002118.3a3a134c.pegasus@nerv.eu.org>
References: <20040718210453.GO26350@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from feather2.animeslovenija.org ([193.77.122.70]:7852 "EHLO
	mail.animeslovenija.org") by vger.kernel.org with ESMTP
	id S264538AbUGRWQ3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Jul 2004 18:16:29 -0400
Received: from localhost (disko [192.168.200.4])
	by mail.animeslovenija.org (8.7.6/8.7.6) with ESMTP id CCB7D9BE0
	for <linux-ide@vger.kernel.org>; Mon, 19 Jul 2004 00:16:34 +0200 (CEST)
Received: from mail.animeslovenija.org ([192.168.200.3])
 by localhost (disko [192.168.200.4]) (amavisd-new, port 10024) with LMTP
 id 31834-03-3 for <linux-ide@vger.kernel.org>;
 Mon, 19 Jul 2004 00:16:30 +0200 (CEST)
Received: from moonlight.pecar.org (jarse [193.95.219.68])
	by mail.animeslovenija.org (8.7.6/8.7.6) with ESMTP id 637529BD9
	for <linux-ide@vger.kernel.org>; Mon, 19 Jul 2004 00:16:33 +0200 (CEST)
In-Reply-To: <20040718210453.GO26350@triplehelix.org>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sun, 18 Jul 2004 14:04:53 -0700
linux-ide-owner@vger.kernel.org wrote:

> Hello SATA people,
>=20
> Here's a message from Chris Carr who tried to get his Silicon Image
> "RAID" adapter working during his test of the Debian Installer. Is
> there any chance of being able to enumerate the adapter's RAID
> configuration in Linux-space? Is the support already implemented
> (excuse my ignorance if it already is)? Are there plans to do so
> at all in the future?
>=20
> The Debian Installer currently uses kernel version 2.6.7 and 2.4.26 w=
ith
> SATA support patches.


There's a tool being developed to handle these kind of 'raids':

http://people.redhat.com/~heinzm/sw/dmraid/

It should handle SilImage (aka Medley) raid arrays just fine via device
mapper.


--=20

Jure Pe=E8ar
