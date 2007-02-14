From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCHSET] libata: PATA driver
	for Celleb
Date: Wed, 14 Feb 2007 14:19:54 +0900
Message-ID: <200702140518.l1E5IoWA008692@toshiba.co.jp>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
 <45B9B1CD.4040600@garzik.org>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24]:33614 "EHLO
	inet-tsb5.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932306AbXBNFSy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Feb 2007 00:18:54 -0500
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l1E5IpCK017315
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2007 14:18:51 +0900 (JST)
Received: (from root@localhost)
	by tsb-wall.toshiba.co.jp  id l1E5IpWU018064
	for linux-ide@vger.kernel.org; Wed, 14 Feb 2007 14:18:51 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l1E5IpDR007380
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2007 14:18:51 +0900 (JST)
In-Reply-To: (Your message of "Fri, 26 Jan 2007 02:46:21 -0500")
  <45B9B1CD.4040600@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com, alan@lxorguk.ukuu.org.uk

Hi, Jeff-san.

>Jeff Garzik wrote:
>> This patchset consists of
>> [1] add another IRQ calls (core and headers)
>> [2] add another IRQ calls (libata drivers)
>> [3] PATA driver for Celleb
>> 
>> And patch[3] depends on patch[1,2].
>> 
>> This patchset is based on the Tejun's "devres" git tree, which is
>> available at the followin URL.
>
>Everything looks great, thanks!
>
>I'll apply this patchset immediately after applying Tejun's devres patchset.
>

Thank you for applying some parts of my patches (patch[1,2]).
But it is my goal that this Celleb patch (patch[3]) is merged into your git tree.
What's the status of this patch?

2.6.20 has been released and (I think) it is the time of merge-window
for 2.6.21. I want this patch to be merged at this time.
Please tell me if there are anything I should do.


Best regards,
Akira Iguchi

