From: Tomas Lund <tlund@nxs.se>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED
Date: Wed, 21 Jul 2010 14:06:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.1007211404480.24693@envy.nxs.se>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se> <4C3D134B.2090604@gmail.com>
 <Pine.LNX.4.61.1007140955080.24693@envy.nxs.se> <Pine.LNX.4.61.1007152103081.24693@envy.nxs.se>
 <Pine.LNX.4.61.1007171422530.24693@envy.nxs.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:52274 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab0GUMGn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jul 2010 08:06:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by envy.nxs.se (Postfix) with ESMTP id E2AA02BEBE
	for <linux-ide@vger.kernel.org>; Wed, 21 Jul 2010 14:06:41 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.1007171422530.24693@envy.nxs.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Put the "LYCOM SATA PE-103 2-CH" back in the server with the Gigabyte 
965P-DS4 motherboard and installed the debian backports kernel 
2.6.32-bpo.5-amd64.

Problem persists and a dmesg and console output (since dmesg buffer is too 
small to fit everything) is available at:

http://tlund.pp.se/sil24/console_2.6.32-bpo.5-amd64.txt
http://tlund.pp.se/sil24/dmesg_2.6.32-bpo.5-amd64.txt

//tlund
