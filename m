From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: make DVD drive recognisable on systems with Intel
 Sandybridge CPT chipset
Date: Fri, 30 Sep 2011 20:22:21 -0400
Message-ID: <4E865D3D.5030504@pobox.com>
References: <1316656512-4829-1-git-send-email-ming.lei@canonical.com> <20110924015859.GZ29319@htj.dyndns.org> <DEC3922D1904474A8862C7BFF516EA9A16E813AA@ORSMSX101.amr.corp.intel.com> <CACVXFVN20XfKab+7SVtT_BCLN0hs-sFHbhTzknF0gNGneERNUg@mail.gmail.com> <20110925000345.GD29319@htj.dyndns.org> <CACVXFVOo3CYxGJrwi0cZRwx=PWaK16EEuMfN1WDzFFA=TU0AuA@mail.gmail.com> <CACVXFVMWn4o3WKznydUqdhfZK2xTQ-+=SFqYtP0J4DzagWphcQ@mail.gmail.com> <CACVXFVPR2qA-N2wi6c2ranOLuhRVuQQ5nhdE=4m1hxjW-Z=Ohw@mail.gmail.com> <20110930030913.GE10425@mtj.dyndns.org> <CACVXFVPf2opHpR=03iWo4-fOn-UTswUPEqY=v8pbu8hdQY8Y6Q@mail.gmail.com> <DEC3922D1904474A8862C7BFF516EA9A16E83AAA@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50753 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353Ab1JAAWX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2011 20:22:23 -0400
Received: by qadb15 with SMTP id b15so679770qad.19
        for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2011 17:22:23 -0700 (PDT)
In-Reply-To: <DEC3922D1904474A8862C7BFF516EA9A16E83AAA@ORSMSX101.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Heasley, Seth" <seth.heasley@intel.com>
Cc: Ming Lei <ming.lei@canonical.com>, Tejun Heo <htejun@gmail.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 09/30/2011 08:02 PM, Heasley, Seth wrote:
>> Seth, could you help to test the patch on your machines with other pci
>> device
>> IDs(0x1c01, 0x1d00, 0x1e00, 0x1e01)?
>
> I've now tested the patch on all five DeviceIDs, including 0x1c00.  It resolves the issue.

Great, thanks.

Can someone please resend the patch to me?  Ming Lei's patch from today 
is word-wrapped.

	Jeff




