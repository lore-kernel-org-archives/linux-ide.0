From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] libata: make ata_dev_knobble() per-device
Date: Sun, 12 Feb 2006 14:29:34 -0500
Message-ID: <43EF8C9E.70602@pobox.com>
References: <11397547784183-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:37082 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751429AbWBLT3h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 14:29:37 -0500
In-Reply-To: <11397547784183-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_dev_knobble() unconditionally used the first device of the port to
> determine whether a device is bridged or not.  This causes bridge
> limit to be incorrectly applied or unapplied for hosts with slave
> devices (e.g. ata_piix).
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-2


