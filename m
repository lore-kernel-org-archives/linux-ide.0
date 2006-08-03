From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2] libata: Add support for SATA attachment to SAS adapters
Date: Thu, 03 Aug 2006 17:25:27 -0400
Message-ID: <44D269C7.1050208@pobox.com>
References: <200607131335.k6DDZpMD004925@d03av03.boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:27056 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932297AbWHCVZb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Aug 2006 17:25:31 -0400
In-Reply-To: <200607131335.k6DDZpMD004925@d03av03.boulder.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian King <brking@us.ibm.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

You shouldn't be duplicating all that init code from ata_host_init().

Fix that issue (presumably by factoring out common code), and I'll apply 
this SAS<->SATA attachment API patchset.

	Jeff



