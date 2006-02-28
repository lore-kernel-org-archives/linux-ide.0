From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] Fixup ahci suspend / resume
Date: Tue, 28 Feb 2006 16:57:42 +0100
Message-ID: <440472F6.6090905@suse.de>
References: <44045FB1.5040408@suse.de> <440468DB.5060605@pobox.com> <20060228151928.GC24981@suse.de> <44046AC2.1060002@pobox.com> <20060228152847.GE24981@suse.de> <44046DC3.4060508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:13471 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751493AbWB1P5n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Feb 2006 10:57:43 -0500
In-Reply-To: <44046DC3.4060508@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Jens Axboe wrote:
>> I'm sure Hannes will regenerate against upstream as well if necessar=
y,
>> however that depends on when this should be applied.
>=20
> It's far too late and too intrusive for 2.6.16-rc.
>=20
> It's #upstream or <null>.
>=20
Calm down. Of course I will regenerate is against #upstream.
In fact, I've done so initially but wasn't sure what the status of
libata-dev is. So I've diffed it against linux-git instead.

Updated patch to follow.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstra=DFe 5				+49 911 74053 688
90409 N=FCrnberg				http://www.suse.de

