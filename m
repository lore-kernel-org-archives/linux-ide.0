From: "Heasley, Seth" <seth.heasley@intel.com>
Subject: RE: [PATCH] ata: make DVD drive recognisable on systems with Intel
 Sandybridge CPT chipset
Date: Sat, 24 Sep 2011 04:28:46 +0000
Message-ID: <DEC3922D1904474A8862C7BFF516EA9A16E813AA@ORSMSX101.amr.corp.intel.com>
References: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
 <20110924015859.GZ29319@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35830 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab1IXE2r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Sep 2011 00:28:47 -0400
In-Reply-To: <20110924015859.GZ29319@htj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, "ming.lei@canonical.com" <ming.lei@canonical.com>
Cc: "alan@linux.intel.com" <alan@linux.intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

>Have we successfully localized the problem to SNB?  If so, great.

No, we haven't.  I've reproduced the issue on two newer Intel chipsets.  In IDE mode, ATAPI just isn't working on SATA3 ports.  With the provided patch, the issue is resolved.  At what cost, I can't say.  But if a patch will go in for the 6 Series, we need to apply it to the other platforms as well.  I can provide the DeviceIDs.

--Seth
