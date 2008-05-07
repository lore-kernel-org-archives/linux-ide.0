From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: Compact Flash Question
Date: Wed, 07 May 2008 09:27:42 +0200
Message-ID: <482159EE.7070108@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:37246 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757045AbYEGH1s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2008 03:27:48 -0400
Received: from postfix1.syneticon.net (postfix1.syneticon.net [192.168.112.6])
	by mail2.syneticon.net (Postfix) with ESMTP id 92F3763F9A
	for <linux-ide@vger.kernel.org>; Wed,  7 May 2008 09:27:47 +0200 (CEST)
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by postfix1.syneticon.net (Postfix) with ESMTP id 9B5839381
	for <linux-ide@vger.kernel.org>; Wed,  7 May 2008 09:27:46 +0200 (CEST)
Received: from postfix1.syneticon.net ([192.168.113.4])
	by localhost (mx03.syneticon.net [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id BfrLTb+vfqiD for <linux-ide@vger.kernel.org>;
	Wed,  7 May 2008 09:27:44 +0200 (CEST)
Received: from [192.168.10.145] (koln-4d0b6d9e.pool.mediaWays.net [77.11.109.158])
	by postfix1.syneticon.net (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Wed,  7 May 2008 09:27:44 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

Bart Van Assche wrote:

> For most Linux filesystems you really need wear leveling. E.g. ext3's
> superblock is at a fixed location and gets overwritten frequently.
> Without wear leveling you risk that the flash sector where the
> superblock resides wears out early.

Compact Flash (and other similar media) does wear levelling, so essentially,
even if we write to the same fixed location, in reality, it will mostly go to a
different area on flash each time.

As Compact Flash and its wear levelling does not know about free space on the
filesystem, the wear levelling's effectiveness can be only limited - writes
won't spread on the whole free area of the flash.

Does anyone know how wear levelling is done in these devices? Perhaps it will
differ from a manufacturer to manufacturer, but I guess they have a free area we
normally use to store data, and some reserved area used just for wear levelling
and bad block handling, but that's just my guess.


> When using ext3 on a CompactFlash, you can limit the number of writes
> to the CompactFlash significantly by mounting the medium with
> parameters like noatime,nodiratime,commit=300.

noatime implies nodiratime, so there is no need to add the latter.


-- 
Tomasz Chmielewski
http://wpkg.org


