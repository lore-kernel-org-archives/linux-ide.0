From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 07/10] pata_hpt3x2n: Add HPT371N support and other bits
Date: Sat, 28 Apr 2007 15:13:50 -0400
Message-ID: <46339CEE.3050406@garzik.org>
References: <200704260719.l3Q7JQ48023697@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53665 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754784AbXD1TNy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 15:13:54 -0400
In-Reply-To: <200704260719.l3Q7JQ48023697@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@redhat.com

> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Yes its no longer 3x2n but 3xxn, I can rename it if you want Jeff

Choose whatever you feel is the best long term name; I have no 
preference here.

If you do rename, please follow this slightly special procedure:

* add a MODULE_ALIAS() for the old name
* send me a patch with everything BUT the file move.  I will do the 
rename in git.

