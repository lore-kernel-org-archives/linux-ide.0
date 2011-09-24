From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] ata: make DVD drive recognisable on systems with Intel
 Sandybridge CPT chipset
Date: Sat, 24 Sep 2011 21:34:09 +0800
Message-ID: <CACVXFVN20XfKab+7SVtT_BCLN0hs-sFHbhTzknF0gNGneERNUg@mail.gmail.com>
References: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
	<20110924015859.GZ29319@htj.dyndns.org>
	<DEC3922D1904474A8862C7BFF516EA9A16E813AA@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50835 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab1IXNeL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Sep 2011 09:34:11 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1R7SMr-0005rs-Sf
	for linux-ide@vger.kernel.org; Sat, 24 Sep 2011 13:34:09 +0000
Received: by wyg34 with SMTP id 34so4713787wyg.19
        for <linux-ide@vger.kernel.org>; Sat, 24 Sep 2011 06:34:09 -0700 (PDT)
In-Reply-To: <DEC3922D1904474A8862C7BFF516EA9A16E813AA@ORSMSX101.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Heasley, Seth" <seth.heasley@intel.com>
Cc: Tejun Heo <htejun@gmail.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hi,

On Sat, Sep 24, 2011 at 9:58 AM, Tejun Heo <htejun@gmail.com> wrote:
> Hello,
> No, this wouldn't work. =A0Ops inheritance isn't dynamic.
>

I am sure that I have tested the patch and it does work.

> Please define a separate ata_port_operations for controller which
> require 16bit PIO - piix_pata16_ops, create a new controller id (say,
> ich_snb_pata), add an accompanying port_info entry and device_id
> entry.

In fact, I am not familiar with sata, but just want to fix the problem.
If you have a better patch, please ignore mine and apply yours.


On Sat, Sep 24, 2011 at 12:28 PM, Heasley, Seth <seth.heasley@intel.com=
> wrote:
>>Have we successfully localized the problem to SNB? =A0If so, great.
>
> No, we haven't. =A0I've reproduced the issue on two newer Intel chips=
ets. =A0In > IDE mode, ATAPI just isn't working on SATA3 ports. =A0With=
 the provided
> patch, the issue is resolved. =A0At what cost, I can't say. =A0But if=
 a patch will
> go in for the 6 Series, we need to apply it to the other platforms as=
 well. =A0I > can provide the DeviceIDs.

I have seen someone reported the same problem on the device with
pci device id of 0x1c01[1]. I have asked them to test the patch but wit=
hout
any response, so I had to not include the dev id in the patch.


[1], https://bugs.launchpad.net/bugs/782389

thanks,
--
Ming Lei
