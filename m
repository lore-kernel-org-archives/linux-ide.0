From: "Heasley, Seth" <seth.heasley@intel.com>
Subject: RE: [PATCH] ata: make DVD drive recognisable on systems with Intel
 Sandybridge CPT chipset
Date: Sat, 1 Oct 2011 00:02:29 +0000
Message-ID: <DEC3922D1904474A8862C7BFF516EA9A16E83AAA@ORSMSX101.amr.corp.intel.com>
References: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
	<20110924015859.GZ29319@htj.dyndns.org>
	<DEC3922D1904474A8862C7BFF516EA9A16E813AA@ORSMSX101.amr.corp.intel.com>
	<CACVXFVN20XfKab+7SVtT_BCLN0hs-sFHbhTzknF0gNGneERNUg@mail.gmail.com>
	<20110925000345.GD29319@htj.dyndns.org>
	<CACVXFVOo3CYxGJrwi0cZRwx=PWaK16EEuMfN1WDzFFA=TU0AuA@mail.gmail.com>
	<CACVXFVMWn4o3WKznydUqdhfZK2xTQ-+=SFqYtP0J4DzagWphcQ@mail.gmail.com>
	<CACVXFVPR2qA-N2wi6c2ranOLuhRVuQQ5nhdE=4m1hxjW-Z=Ohw@mail.gmail.com>
	<20110930030913.GE10425@mtj.dyndns.org>
 <CACVXFVPf2opHpR=03iWo4-fOn-UTswUPEqY=v8pbu8hdQY8Y6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19104 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754301Ab1JAACa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2011 20:02:30 -0400
In-Reply-To: <CACVXFVPf2opHpR=03iWo4-fOn-UTswUPEqY=v8pbu8hdQY8Y6Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>, Tejun Heo <htejun@gmail.com>
Cc: "alan@linux.intel.com" <alan@linux.intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

>Seth, could you help to test the patch on your machines with other pci
>device
>IDs(0x1c01, 0x1d00, 0x1e00, 0x1e01)?

I've now tested the patch on all five DeviceIDs, including 0x1c00.  It resolves the issue.

-Seth
