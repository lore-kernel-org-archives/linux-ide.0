From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Tue, 6 Jan 2009 19:21:55 +0000
Message-ID: <20090106192155.40addc92@lxorguk.ukuu.org.uk>
References: <49615667.9020408@iwl.com>
	<20090105113642.19679726@lxorguk.ukuu.org.uk>
	<49629664.9050604@iwl.com>
	<4963557D.1020504@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41732 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751230AbZAFTVy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2009 14:21:54 -0500
In-Reply-To: <4963557D.1020504@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com

>    Judging on what you have posted, IDE driver would not probably give 
> any speed improvement, only soewhat lesser memory footprint...

Except he is also using USB storage so the shared stack with the libata
code is already loaded ...
