From: Kalev Toots <kalev.toots@probil.ee>
Subject: PIIX driver
Date: Wed, 02 Jan 2008 14:26:09 +0200
Message-ID: <477B82E1.4070209@probil.ee>
Reply-To: kalev.toots@probil.ee
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.neti.ee ([194.126.126.40]:59221 "EHLO smtp-out.neti.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbYABMz5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jan 2008 07:55:57 -0500
Received: from smtp-out.neti.ee (relay13.estpak.ee [88.196.174.168])
	by HOT-Bounce1.estpak.ee (Postfix) with ESMTP id 11B58715ECC
	for <linux-ide@vger.kernel.org>; Wed,  2 Jan 2008 14:30:21 +0200 (EET)
Received: from localhost (localhost [127.0.0.1])
	by MXR-13.estpak.ee (Postfix) with ESMTP id AB65711B7C
	for <linux-ide@vger.kernel.org>; Wed,  2 Jan 2008 14:26:13 +0200 (EET)
Received: from smtp-out.neti.ee ([127.0.0.1])
	by localhost (MXR-1.estpak.ee [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P8Hh40971oQ0 for <linux-ide@vger.kernel.org>;
	Wed,  2 Jan 2008 14:26:10 +0200 (EET)
Received: from Relayhost2.neti.ee (Relayhost2 [88.196.174.142])
	by MXR-13.estpak.ee (Postfix) with ESMTP id 337FA1223E
	for <linux-ide@vger.kernel.org>; Wed,  2 Jan 2008 14:26:10 +0200 (EET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello

For specific reason I need to install old FC4 ( kernel 2.6.11 ) to new 
hardware ( Intel DP35DP motherboard ).
Installation failed and the reason I think is that FC4 ata-piix driver 
don't have ICH9 support.
Is it possible to port new ata-piix driver ( from kernel 2.6.23 ) to  
old kernel. I had a look at the sources and
the task seems difficult because changes from ver. 1.03 to 2.12 are 
signifficant.
Or you can suggest some other solution to that problem.

Kalev

