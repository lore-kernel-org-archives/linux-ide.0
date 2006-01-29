From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [PATCH] libata queue updated
Date: Sun, 29 Jan 2006 17:11:42 +0100
Message-ID: <200601291711.43426.ioe-lkml@rameria.de>
References: <20060128182522.GA31458@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:42717 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751056AbWA2QLq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Jan 2006 11:11:46 -0500
In-Reply-To: <20060128182522.GA31458@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hi Jeff,


On Saturday 28 January 2006 19:25, Jeff Garzik wrote:
> Testing and merge point in Tejun's flood of patches :)  The patch
> below is against current linux-2.6.git.

These "function(unsigned int *classes)" style functions in 
"libata-core.c" worry me somewhat.  Esp. that sometimes you have one class,
sometimes two.
This looks like a bug waiting to happen for me.

Could we somehow get a 

struct ata_classes {
	unsigned int master;
	unsigned int slave;
}

here (or similiar), before this is in used everywhere?

Usage would be function(struct ata_classes *classes) then.


Thanks & Regards

Ingo Oeser


