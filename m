From: Hannes Reinecke <hare@suse.de>
Subject: Re: State of resume for AHCI?
Date: Fri, 02 Jun 2006 08:43:58 +0200
Message-ID: <447FDE2E.5010401@suse.de>
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca> <20060601183904.GR4400@suse.de> <447F4BC2.8060808@goop.org> <20060602060323.GS4400@suse.de> <1149228204.13451.8.camel@forrest26.sh.intel.com> <20060602064148.GT4400@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:1241 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751215AbWFBGoA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jun 2006 02:44:00 -0400
In-Reply-To: <20060602064148.GT4400@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Fri, Jun 02 2006, zhao, forrest wrote:
>> On Fri, 2006-06-02 at 08:03 +0200, Jens Axboe wrote:
>>> On Thu, Jun 01 2006, Jeremy Fitzhardinge wrote:
>>>> Jens Axboe wrote:
>>>>> It's a lot more complicated than that, I'm afraid. ahci doesn't e=
ven
>>>>> have the resume/suspend methods defined, plus it needs more work =
than
>>>>> piix on resume.
>>>>> =20
>>>> Hannes Reinecke's patch implements those functions, basically by=20
>>>> factoring out the shutdown and init code and calling them at=20
>>>> suspend/resume time as well.
>>>>
>>>> Is that correct/sufficient?  Or should something else be happening=
?
>>> No that's it, I know for a fact that suspend/resume works perfectly=
 with
>>> the 10.1 suse kernel. You can give that a shot, if you want.
>> You may mean the Hannes's patch for 10.1 SUSE kernel. Hannes's patch
>> posted in open source community(or in linux-ide mailing list) didn't
>> work.
>=20
> I didn't say Hannes patch, I said I know that 10.1 works. And that is
> probably in large due to the patch that Hannes did, which implents
> resume/suspend and takes care of reinitializing the resources.
>=20
Indeed. I didn't post the latest set of patches to the open-source
community as Jeff indicated he would only accept patches against
libata-dev. And as I didn't have time to port them yet I didn't feel th=
e
need to do so.

=46orrest, please drop me a mail if I can be of further assistance.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstra=DFe 5				+49 911 74053 688
90409 N=FCrnberg				http://www.suse.de
