From: "n" <xellos@bluebottle.com>
Subject: libata / pata drivers and smart , pata_via . pata_pdc202xx_old
Date: Sun, 2 Sep 2007 04:58:11 -0700
Message-ID: <200709021158.l82BwCcN013983@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mi0.bluebottle.com ([206.188.25.15]:35218 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965304AbXIBL6M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 07:58:12 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l82BwCcN013983
	for <linux-ide@vger.kernel.org>; Sun, 2 Sep 2007 04:58:12 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, patrizio.bassi@gmail.com
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, "Kernel," <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

is it possible to get the new libata drivers (pata_via . pata_pdc202xx_old) 
to support smart?
i was looking at smartcrl -a and it says Device does not support SMART even 
though it does.

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com/tag/1

