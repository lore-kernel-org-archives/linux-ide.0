From: Hannes Reinecke <hare@suse.de>
Subject: Re: State of resume for AHCI?
Date: Fri, 02 Jun 2006 08:39:46 +0200
Message-ID: <447FDD32.7070403@suse.de>
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca>	 <20060601183904.GR4400@suse.de>  <447F4BC2.8060808@goop.org> <1149210165.13451.4.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:19160 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751206AbWFBGjs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jun 2006 02:39:48 -0400
In-Reply-To: <1149210165.13451.4.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Jens Axboe <axboe@suse.de>, Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Thu, 2006-06-01 at 13:19 -0700, Jeremy Fitzhardinge wrote:
>> Jens Axboe wrote:
>>> It's a lot more complicated than that, I'm afraid. ahci doesn't eve=
n
>>> have the resume/suspend methods defined, plus it needs more work th=
an
>>> piix on resume.
>>>  =20
>> Hannes Reinecke's patch implements those functions, basically by=20
>> factoring out the shutdown and init code and calling them at=20
>> suspend/resume time as well.
>>
>> Is that correct/sufficient?  Or should something else be happening?
>=20
> According to our test of Hannes's patch, it's not sufficient to suppo=
rt
> AHCI suspend/resume.
>=20
> Now I'm writing a patch to try to provide complete support for AHCI
> suspend/resume and will send out patch soon, hopefully by the end of
> today.
>=20
Can I have details, please? What doesn't work?

Cheers,

Hannes
--=20
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstra=DFe 5				+49 911 74053 688
90409 N=FCrnberg				http://www.suse.de
