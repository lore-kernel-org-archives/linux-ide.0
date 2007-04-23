From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCHSET] libata: improve ATA ACPI support
Date: Mon, 23 Apr 2007 18:05:03 -0400
Message-ID: <462D2D8F.5030200@rtr.ca>
References: <11772636651400-git-send-email-htejun@gmail.com> <20070422192500.2e1014fd@the-village.bc.nu> <462C690B.1090802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3183 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754317AbXDWWFG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Apr 2007 18:05:06 -0400
In-Reply-To: <462C690B.1090802@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> 
> of the time.  I think HDIO_GET_IDENTITY's meaning is something like
> "give me IDENTIFY page of the device as seen by the driver" and doesn't
> really matter as long as it can be used to get general idea about the
> device.

The correct/original meaning of that ioctl was "boot time IDENTIFY" data.
As Alan said, it later got bastardized by various people at some point.

Cheers

