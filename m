From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] libata: Build fix for drivers/scsi users
Date: Mon, 14 Aug 2006 14:13:16 -0400
Message-ID: <44E0BD3C.5090203@pobox.com>
References: <200608101516.k7AFG0Ov030312@d03av03.boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41117 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751600AbWHNSNT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Aug 2006 14:13:19 -0400
In-Reply-To: <200608101516.k7AFG0Ov030312@d03av03.boulder.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian King <brking@us.ibm.com>
Cc: linux-ide@vger.kernel.org

Brian King wrote:
> When moving libata to drivers/ata, SCSI/SAS drivers were
> broken. Alter the build process for libata to be done in
> a similar manner to how scsi is done today.
> 
> Signed-off-by: Brian King <brking@us.ibm.com>

applied manually, since I had already changed all the symbol names

	Jeff



