From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA II NCQ and multi-port support for ICH7
Date: Thu, 23 Jul 2009 14:24:01 +0900
Message-ID: <4A67F3F1.4020405@kernel.org>
References: <0KN6003ZATOVGH70@vms173017.mailsrvcs.net> <4A674306.9040305@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44614 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbZGWFYO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jul 2009 01:24:14 -0400
In-Reply-To: <4A674306.9040305@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: dhdurgee@verizon.net, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> ata_piix is loaded for legacy IDE emulation, and is limited by IDE
> interface in number of supported ports.  NCQ is not supported by this
> interface.
> 
> ahci driver supports "native mode", with full NCQ and all ports.
> 
> ICH7 chip usually supports both legacy IDE and native AHCI modes.

Also, IIRC, ich7 ahci doesn't support PMP.

-- 
tejun
