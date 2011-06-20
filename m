From: fl-00@gmx.de
Subject: Re: [PATCH] libata: Pioneer DVR-216D can't do SETXFER
Date: Mon, 20 Jun 2011 14:44:42 +0200
Message-ID: <20110620124442.159870@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:38753 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750945Ab1FTMop (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2011 08:44:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Unluckily, the patch is done for the pioneer dvd-216d with firmware rev. 1.08. I'm an owner with firmware rev. 1.09 and the patch does not work for me.
After some research I found lots of reports with various pioneer drives / variants concerning the same issue.

1) is it possible to include the dvd-216d with rev. 1.09 as well (or even better: with any revision)
2) is there some plan how to cope with such "broken" drives in general without the need to include every single drive in the code?

Regards,
Flo
-- 
NEU: FreePhone - kostenlos mobil telefonieren!			
Jetzt informieren: http://www.gmx.net/de/go/freephone
