From: Tomas Lund <tlund@nxs.se>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED
Date: Sat, 17 Jul 2010 14:29:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.1007171422530.24693@envy.nxs.se>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se> <4C3D134B.2090604@gmail.com>
 <Pine.LNX.4.61.1007140955080.24693@envy.nxs.se> <Pine.LNX.4.61.1007152103081.24693@envy.nxs.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:40862 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753805Ab0GQMaE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jul 2010 08:30:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by envy.nxs.se (Postfix) with ESMTP id AA19A2BEBE
	for <linux-ide@vger.kernel.org>; Sat, 17 Jul 2010 14:29:58 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.1007152103081.24693@envy.nxs.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have now tried both of my sil3132-based controllers with a different 
motherboard (Asus P6T Core i7) and I get the same problem with both of 
them. I tested them with different disks.

"dmesg" output from booting at http://tlund.pp.se/sil24/dmesg2.txt and 
http://tlund.pp.se/sil24/dmesg3.txt

The tests on the P6T motherboard were made with the same 2.6.27.48 kernel 
that I reverted to on the real server and I am starting to think that it 
might be something in my configuration that makes it not work? Two 
different controllers on two different motherboards with two different 
disks?

Full config at http://tlund.pp.se/sil24/config_2.6.27.48.txt

//tlund
