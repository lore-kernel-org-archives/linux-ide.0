From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata: make DVD drive recognisable on systems with Intel
 Sandybridge CPT chipset
Date: Sun, 25 Sep 2011 09:03:45 +0900
Message-ID: <20110925000345.GD29319@htj.dyndns.org>
References: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
 <20110924015859.GZ29319@htj.dyndns.org>
 <DEC3922D1904474A8862C7BFF516EA9A16E813AA@ORSMSX101.amr.corp.intel.com>
 <CACVXFVN20XfKab+7SVtT_BCLN0hs-sFHbhTzknF0gNGneERNUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:43243 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab1IYADw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Sep 2011 20:03:52 -0400
Received: by pzk1 with SMTP id 1so10795670pzk.1
        for <linux-ide@vger.kernel.org>; Sat, 24 Sep 2011 17:03:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACVXFVN20XfKab+7SVtT_BCLN0hs-sFHbhTzknF0gNGneERNUg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: "Heasley, Seth" <seth.heasley@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hello,

On Sat, Sep 24, 2011 at 09:34:09PM +0800, Ming Lei wrote:
> On Sat, Sep 24, 2011 at 9:58 AM, Tejun Heo <htejun@gmail.com> wrote:
> > Hello,
> > No, this wouldn't work. =A0Ops inheritance isn't dynamic.
>=20
> I am sure that I have tested the patch and it does work.

Yeah, but not by design.  That field is assumed to be static.
Inheritance currently is finalized during the first use of the
operation structure, where the first use also includes being inherited
by other ops structure, so doing it like that is asking for obscure
bugs.

> > Please define a separate ata_port_operations for controller which
> > require 16bit PIO - piix_pata16_ops, create a new controller id (sa=
y,
> > ich_snb_pata), add an accompanying port_info entry and device_id
> > entry.
>=20
> In fact, I am not familiar with sata, but just want to fix the proble=
m.
> If you have a better patch, please ignore mine and apply yours.

Sure I can do that but it would be better if you can revise your
patch.  Please take a look at how different ops are mapped to
different device IDs.  You just need to create another variant to be
mapped to the problematic device IDs.

> On Sat, Sep 24, 2011 at 12:28 PM, Heasley, Seth <seth.heasley@intel.c=
om> wrote:
> >>Have we successfully localized the problem to SNB? =A0If so, great.
> >
> > No, we haven't. =A0I've reproduced the issue on two newer Intel chi=
psets. =A0In > IDE mode, ATAPI just isn't working on SATA3 ports. =A0Wi=
th the provided
> > patch, the issue is resolved. =A0At what cost, I can't say. =A0But =
if a patch will
> > go in for the 6 Series, we need to apply it to the other platforms =
as well. =A0I > can provide the DeviceIDs.
>=20
> I have seen someone reported the same problem on the device with
> pci device id of 0x1c01[1]. I have asked them to test the patch but w=
ithout
> any response, so I had to not include the dev id in the patch.

Developing partial blacklist w/o knowing what's going on is messy.  If
we discover that something wasn't quite what we suspected it was and
had to revise, it'll be tricky to verify whicn ones need to remain.
Alan, can someone from intel verify the issue?  Is there an errata we
can look at?

Thanks.

--=20
tejun
