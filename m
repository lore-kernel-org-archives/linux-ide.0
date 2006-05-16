From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
Date: Tue, 16 May 2006 10:59:27 -0400
Message-ID: <4469E8CF.9030506@garzik.org>
References: <20060512132437.GB4219@htj.dyndns.org> <e4coc8$onk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:14720 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751191AbWEPO7a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 10:59:30 -0400
In-Reply-To: <e4coc8$onk$1@sea.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: schierlm@gmx.de
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Michael Schierl wrote:

> On Fri, 12 May 2006 22:24:37 +0900, Tejun Heo wrote:
> 
>> ahci:		new EH, irq-pio, NCQ, hotplug
> 
> Should suspend-to-RAM work now on AHCI?

It probably still needs Hannes' AHCI patch, and possibly the SATA ACPI 
patches too.

	Jeff


