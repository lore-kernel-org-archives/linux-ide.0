From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 1/2] ata_piix: add Intel ICH8 device IDs
Date: Tue, 17 Jan 2006 07:53:26 -0500
Message-ID: <43CCE8C6.4010103@pobox.com>
References: <200601170526.k0H5QpuM026968@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:37802 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932468AbWAQMxd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2006 07:53:33 -0500
In-Reply-To: <200601170526.k0H5QpuM026968@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jason.d.gaston@intel.com
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

akpm@osdl.org wrote:
> From: Jason Gaston <jason.d.gaston@intel.com>
> 
> Add the Intel ICH8 DID's to the ata_piix.c and quirks.c file for IDE mode SATA
> support.
> 
> Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

NAK, adds a duplicate entry to the locally declared struct ata_port_info.

Otherwise, OK.

	Jeff



