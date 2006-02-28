From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] Fixup ahci suspend / resume
Date: Tue, 28 Feb 2006 15:59:14 +0100
Message-ID: <44046542.9030209@suse.de>
References: <44045FB1.5040408@suse.de> <44046222.4090008@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:16101 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751179AbWB1O7P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Feb 2006 09:59:15 -0500
In-Reply-To: <44046222.4090008@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Hannes Reinecke wrote:
>> Hi all,
>>
[ .. ]
>> This patch rearranges the suspend / resume code to properly initiali=
se
>> those registers after a resume. It also contains some initialisation
>> fixes to make the driver behave more spec-compliant.
> ..
>=20
> Is ahci the *only* interface afflicted with this problem?
Good question.

Can't tell. So far this is ahci specific as the ahci requires the DMA
addresses to be written in some register. One would have to look up the
individual specs to check whether this is also true for other drivers.

AFAICS the SATA spec doesn't require you to implement it this way, thou=
gh.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstra=DFe 5				+49 911 74053 688
90409 N=FCrnberg				http://www.suse.de

