From: "SMALL, Timothy" <timothy.small@astrium.eads.net>
Subject: RE: sata_sil24 corruption details
Date: Mon, 7 Nov 2005 16:05:29 -0000
Message-ID: <C2D16922D674664C9CCA61127AC9B77B03E0D6@auk52177.ukr.astrium.corp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viruswall.astrium.eads.net ([194.203.13.70]:5390 "EHLO
	viruswall.astrium.eads.net") by vger.kernel.org with ESMTP
	id S964854AbVKGQBi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Nov 2005 11:01:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "'linux@horizon.com'" <linux@horizon.com>
Cc: linux-ide@vger.kernel.org


Sounds good, if you wanted extra confidence, you could apply this as well:

http://bluesmoke.sourceforge.net

It will flag ECC, and also some PCI errors...  Try
http://prdownloads.sourceforge.net/bluesmoke/bluesmoke-devel-20051027.tar.gz
?download but don't include the NMI code (it's less invasive).

Cheers,

Tim.

> doesn't look like RAM errors, and in any case, the machine has ECC
> memory, not overclocked, and was burned in with memtest86+ and prime95
> for multiple days to make sure RAM was reliable.

> Hardware is single-core AMD64 processor,

This email is for the intended addressee only.
If you have received it in error then you must not use, retain, disseminate or otherwise deal with it.
Please notify the sender by return email.
The views of the author may not necessarily constitute the views of EADS Astrium Limited.
Nothing in this email shall bind EADS Astrium Limited in any contract or obligation.

EADS Astrium Limited, Registered in England and Wales No. 2449259
Registered Office: Gunnels Wood Road, Stevenage, Hertfordshire, SG1 2AS, England
