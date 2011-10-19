From: Tobias Geiger <tobias.geiger@vido.info>
Subject: AHCI not working with VT-d enabled
Date: Wed, 19 Oct 2011 14:04:26 +0200
Message-ID: <201110191404.27193.tobias.geiger@vido.info>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.vido.info ([78.47.43.171]:43011 "EHLO mail.vido.info"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754377Ab1JSMMV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Oct 2011 08:12:21 -0400
Received: from localhost (ip6-localhost [127.0.0.1])
	by mail.vido.info (Postfix) with ESMTP id 18ED0D3462F
	for <linux-ide@vger.kernel.org>; Wed, 19 Oct 2011 14:04:40 +0200 (CEST)
Received: from mail.vido.info ([127.0.0.1])
	by localhost (mail.vido.info [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lFt7vNTGkZcJ for <linux-ide@vger.kernel.org>;
	Wed, 19 Oct 2011 14:04:36 +0200 (CEST)
Received: from lxgeigert.localnet (et-1-10.gw-nat.bs.kae.de.oneandone.net [212.227.35.74])
	by mail.vido.info (Postfix) with ESMTPSA id B09C2D34610
	for <linux-ide@vger.kernel.org>; Wed, 19 Oct 2011 14:04:36 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

short description of my problem is:
with vt-d enabled in bios the sata 6g ports are not recognized;
when vt-d is disabled the sata6g ports work...

Sata ports are on 
04:00.0 SATA controller: Marvell Technology Group Ltd. Device 9120 (rev 12)

kernel is 3.1.0-rc8+
Dmesg with vt-d enabled is here: http://pastebin.com/YLJU8yMJ

Thanks for your input on this!
Greetings
Tobias



