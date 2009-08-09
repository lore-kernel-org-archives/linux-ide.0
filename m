From: Jim Duda <jim@duda.tzo.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Sun, 09 Aug 2009 19:32:52 -0400
Message-ID: <4A7F5CA4.2060905@duda.tzo.com>
References: <h5kn9c$51r$1@ger.gmane.org> <20090809072823.GA2130@liondog.tnic> <4A7F530C.9090209@duda.tzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:51731 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbZHIXdJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Aug 2009 19:33:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MaHsv-0004KQ-1G
	for linux-ide@vger.kernel.org; Sun, 09 Aug 2009 23:33:05 +0000
Received: from pool-96-252-13-163.bstnma.fios.verizon.net ([96.252.13.163])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 09 Aug 2009 23:33:05 +0000
Received: from jim by pool-96-252-13-163.bstnma.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 09 Aug 2009 23:33:05 +0000
In-Reply-To: <4A7F530C.9090209@duda.tzo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@googlemail.com>, linux-ide@vger.kernel.org


> The rc5 source uses DEBUG_LOG and not IDETAPE_DEBUG_LOG.

Ignore this comment.

I'm working on adding my own debug_log print statements in ide-tape to make sure I know I'm looking at the proper file, etc.

Jim

