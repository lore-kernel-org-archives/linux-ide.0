From: Ian Pilcher <i.pilcher@comcast.net>
Subject: Re: ATA/133 Problems with multiple cards
Date: Thu, 14 Oct 2004 13:12:42 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <ckmfiq$rc7$1@sea.gmane.org>
References: <Pine.LNX.4.44.0410141710390.1681-100000@beast.stev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:63650 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267386AbUJNTUo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Oct 2004 15:20:44 -0400
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CIB9X-0001YS-00
	for <linux-ide@vger.kernel.org>; Thu, 14 Oct 2004 21:20:43 +0200
Received: from c-24-0-215-208.client.comcast.net ([24.0.215.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 14 Oct 2004 21:20:42 +0200
Received: from i.pilcher by c-24-0-215-208.client.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 14 Oct 2004 21:20:42 +0200
In-Reply-To: <Pine.LNX.4.44.0410141710390.1681-100000@beast.stev.org>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org

James Stevenson wrote:
> 
> i seem to have run into an annoying problem with a machine which has
> 3 promise ata/133 card the PDC20269 type.
> 

....

> 
> Does anyone have an explenation of why this can happen ?
> 

Promise cards don't support more than two per machine.  If you can get a
third card to work in PIO mode, consider it an added (but unsupported)
bonus.

-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

