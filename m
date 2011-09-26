From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] ata: make DVD drive recognisable on systems with Intel
 Sandybridge CPT chipset
Date: Mon, 26 Sep 2011 14:51:41 +0800
Message-ID: <CACVXFVOo3CYxGJrwi0cZRwx=PWaK16EEuMfN1WDzFFA=TU0AuA@mail.gmail.com>
References: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
	<20110924015859.GZ29319@htj.dyndns.org>
	<DEC3922D1904474A8862C7BFF516EA9A16E813AA@ORSMSX101.amr.corp.intel.com>
	<CACVXFVN20XfKab+7SVtT_BCLN0hs-sFHbhTzknF0gNGneERNUg@mail.gmail.com>
	<20110925000345.GD29319@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46424 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab1IZGvn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Sep 2011 02:51:43 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1R852T-0000Tu-R1
	for linux-ide@vger.kernel.org; Mon, 26 Sep 2011 06:51:41 +0000
Received: by wwf22 with SMTP id 22so6302209wwf.1
        for <linux-ide@vger.kernel.org>; Sun, 25 Sep 2011 23:51:41 -0700 (PDT)
In-Reply-To: <20110925000345.GD29319@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Heasley, Seth" <seth.heasley@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hi,

On Sun, Sep 25, 2011 at 8:03 AM, Tejun Heo <htejun@gmail.com> wrote:
> Sure I can do that but it would be better if you can revise your
> patch. =C2=A0Please take a look at how different ops are mapped to
> different device IDs. =C2=A0You just need to create another variant t=
o be
> mapped to the problematic device IDs.

OK=EF=BC=8C I will do it.

>
>> On Sat, Sep 24, 2011 at 12:28 PM, Heasley, Seth <seth.heasley@intel.=
com> wrote:
>> >>Have we successfully localized the problem to SNB? =C2=A0If so, gr=
eat.
>> >
>> > No, we haven't. =C2=A0I've reproduced the issue on two newer Intel=
 chipsets. =C2=A0In > IDE mode, ATAPI just isn't working on SATA3 ports=
=2E =C2=A0With the provided
>> > patch, the issue is resolved. =C2=A0At what cost, I can't say. =C2=
=A0But if a patch will
>> > go in for the 6 Series, we need to apply it to the other platforms=
 as well. =C2=A0I > can provide the DeviceIDs.
>>

Seth, could you provide the DeviceIDs so that we can make a quirk for t=
hem
now?

>> I have seen someone reported the same problem on the device with
>> pci device id of 0x1c01[1]. I have asked them to test the patch but =
without
>> any response, so I had to not include the dev id in the patch.
>
> Developing partial blacklist w/o knowing what's going on is messy. =C2=
=A0If
> we discover that something wasn't quite what we suspected it was and
> had to revise, it'll be tricky to verify whicn ones need to remain.
> Alan, can someone from intel verify the issue? =C2=A0Is there an erra=
ta we
> can look at?

thanks,
---
Ming Lei
