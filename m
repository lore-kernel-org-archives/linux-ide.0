From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Continuing ata_piix PCS saga...
Date: Tue, 26 Sep 2006 17:33:26 -0400
Message-ID: <45199CA6.3050308@pobox.com>
References: <450F6F21.7080909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:14483 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964825AbWIZVd6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Sep 2006 17:33:58 -0400
In-Reply-To: <450F6F21.7080909@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: nabiki@teleline.es, Keith Owens <kaos@ocs.com.au>, stevenm@umd.edu, jfs@keytradebank.com, 0602@eq.cz, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Judging from early Intel responses, on ICH >= 6, we should use SATA phy 
registers via AHCI space rather than PCS.

[implying, I suppose, that PCS must be used when there is no AHCI PCI 
BAR address assigned]

Still waiting on further response from Intel...

	Jeff





