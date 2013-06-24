From: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Subject: AHCI and SSS
Date: Mon, 24 Jun 2013 21:16:31 +0200
Message-ID: <20130624191631.GA5402@lazy.lzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:48626 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750936Ab3FXTQm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2013 15:16:42 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mx.arcor.de (Postfix) with ESMTP id C38C9E3D7C
	for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2013 21:16:40 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id BF7956F3A8A
	for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2013 21:16:40 +0200 (CEST)
Received: from lazy.lzy (p57B85B8D.dip0.t-ipconnect.de [87.184.91.141])
	(Authenticated sender: piergiorgio.sartor@arcor.de)
	by mail-in-05.arcor-online.net (Postfix) with ESMTPSA id 153B8E3D7C
	for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2013 21:16:36 +0200 (CEST)
Received: from lazy.lzy (localhost [127.0.0.1])
	by lazy.lzy (8.14.7/8.14.5) with ESMTP id r5OJGWnc005458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2013 21:16:36 +0200
Received: (from red@localhost)
	by lazy.lzy (8.14.7/8.14.6/Submit) id r5OJGV6g005457
	for linux-ide@vger.kernel.org; Mon, 24 Jun 2013 21:16:31 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

I've a couple of questions about AHCI and SSS.

If I understand it correctly, SSS is used to
honor the PUS (Power Up in Standby) otherwise
known as SSU (Staggered Spin Up).
That is, if the HDDs at boot are in idle, they
will be waked up one after the other and not
all together, in order to reduce the power spike.

How about a system already running, where the
HDDs are set to idle?
For example, assuming we have a RAID-5, with
5~6 HDDs and we put them to sleep.
When the RAID is accessed, all the HDDs are
wakeup in parellel.
Is there any way to serialize all the accesses
to the HDDs?
Or, is there an other solution to the problem?

Second question.
As far as I know, only the ahci driver supports
this SSS.
How about other drivers?
How about the SAS drivers (I know, this is linux-ide,
but maybe someone will know as well)?

Thanks a lot in advance,

bye,

-- 

piergiorgio
