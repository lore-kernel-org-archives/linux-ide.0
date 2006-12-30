From: Mark Lord <liml@rtr.ca>
Subject: Re: bug: AHCI: Serial ATA to CompactFlash adapter loops endlessly
Date: Sat, 30 Dec 2006 11:48:15 -0500
Message-ID: <4596984F.4020604@rtr.ca>
References: <20061117211135.GO7299@kvack.org> <45842390.1000102@pobox.com> <20061220021309.GY1104@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3635 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755174AbWL3RJo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Dec 2006 12:09:44 -0500
In-Reply-To: <20061220021309.GY1104@kvack.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

>Got any ideas for things to try?

Just for extra info, try redoing your tests *without* smartd running.
(possible theory is that S.M.A.R.T. commands may be interfering
 or triggering some kind of buggy behaviour somewhere).

Cheers
