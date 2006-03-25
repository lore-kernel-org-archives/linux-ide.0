From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] libata: implement ata_dev_enabled and disabled()
Date: Sat, 25 Mar 2006 23:54:55 +0000
Message-ID: <1143330895.28134.14.camel@localhost.localdomain>
References: <11431815313764-git-send-email-htejun@gmail.com>
	 <44240A67.7030001@pobox.com>
	 <1143215493.18986.11.camel@localhost.localdomain>
	 <20060325011432.GE5288@htj.dyndns.org> <4424C12B.7070106@pobox.com>
	 <20060325054008.GG5288@htj.dyndns.org>
	 <20060325061215.GH5288@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52435 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751975AbWCYXsG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Mar 2006 18:48:06 -0500
In-Reply-To: <20060325061215.GH5288@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Sad, 2006-03-25 at 15:12 +0900, Tejun Heo wrote:
> This patch renames ata_dev_present() to ata_dev_enabled() and adds
> ata_dev_disabled().  This is to discern the state where a device is
> present but disabled from not-present state.  This disctinction is
> necessary when configuring transfer mode because device selection
> timing must not be violated even if a device fails to configure.

This breaks the expected behaviour of ata_dev_pair(). I'd rather kept
the existing behaviour of ata_dev_present for the moment until we can
figure out what we need to do for "present but not enabled". That should
also fit the scsi layer expectations so we can correctly "offline" a
device.

