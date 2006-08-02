From: Matthieu CASTET <matthieu.castet@sagem.com>
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_Re=3A_[2=2E6=2E18-rc2-mm1]_pata=5Fvia_fails?=
Date: Wed, 2 Aug 2006 09:17:45 +0200
Message-ID: <OFF35F9EB5.995BFC42-ONC12571BE.0027D9D2-C12571BE.00281470@sagem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.sagem.com ([62.160.59.65]:25471 "EHLO mx1.sagem.com")
	by vger.kernel.org with ESMTP id S1751304AbWHBHRv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Aug 2006 03:17:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.A. =?ISO-8859-1?Q?Magall=F3n?=" <jamagallon@ono.com>, linux-ide@vger.kernel.org, linux-ide-owner@vger.kernel.org, "Linux-Kernel," <linux-kernel@vger.kernel.org>

Hi,

> Known insanity. With some ATAPI devices the VIA delivers the IRQ before
> the response is ready when we do a SET_FEATURES. Still being worked on.

The patch in -mm for pata_via was dropped ?


Matthieu
