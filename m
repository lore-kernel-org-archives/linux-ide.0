From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata: ATA_PIIX missing ICH8M PCIIDs.
Date: Mon, 18 Jun 2007 15:47:40 -0400
Message-ID: <4676E15C.80300@garzik.org>
References: <39B20DF628532344BC7A2692CB6AEE07016FE51B@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53058 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764333AbXFRTro (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Jun 2007 15:47:44 -0400
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE07016FE51B@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: chunkeey@web.de, linux-ide@vger.kernel.org

Gaston, Jason D wrote:
> I don't think we want to have the same DeviceID supported in more then one driver.  Would they not conflict with each other?

In Fedora 7, CONFIG_IDE is disabled.  ata_piix drives all hardware at 
that point.

	Jeff



