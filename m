From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Fri, 01 Oct 2004 14:32:32 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <415DA2C0.3060600@pobox.com>
References: <20041001123951.A23006@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63926 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265900AbUJAScs
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Oct 2004 14:32:48 -0400
In-Reply-To: <20041001123951.A23006@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org

Andy Warner wrote:
> I've started looking at scsi device add/remove/rescan
> and libata. Anyone have any groundrules or observations
> that might save me wasting a bunch of cycles doing
> something daft/unacceptable ?

I don't see why rescan is needed, since SATA hardware supports hotplug.

	Jeff


