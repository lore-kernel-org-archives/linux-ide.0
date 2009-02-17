From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] libata-sff: fix 32-bit PIO ATAPI regression
Date: Tue, 17 Feb 2009 03:20:26 +0300
Message-ID: <499A02CA.7050509@ru.mvista.com>
References: <200902152224.25144.sshtylyov@ru.mvista.com> <4999FD1A.3080407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3991 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750888AbZBQAUd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Feb 2009 19:20:33 -0500
In-Reply-To: <4999FD1A.3080407@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, rjw@sisk.pl, akpm@linux-foundation.org

Hello.

Jeff Garzik wrote:

>> Commit 871af1210f13966ab911ed2166e4ab2ce775b99d (libata: Add 32bit 
>> PIO support)
>> has caused all kinds of errors on the ATAPI devices, so it has been 
>> empirically

  It started to look as we still don't really know what caused all these 
errors... :-/

MBR, Sergei


