From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 05/15] libata: implement ata_dev_enabled and disabled()
Date: Sat, 01 Apr 2006 12:29:28 -0500
Message-ID: <442EB878.90201@pobox.com>
References: <11438230983412-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:5083 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751571AbWDAR3d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 12:29:33 -0500
In-Reply-To: <11438230983412-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> This patch renames ata_dev_present() to ata_dev_enabled() and adds
> ata_dev_disabled().  This is to discern the state where a device is
> present but disabled from not-present state.  This disctinction is
> necessary when configuring transfer mode because device selection
> timing must not be violated even if a device fails to configure.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Tangent thought:  perhaps instead of ata_dev_present() you could 
implement its antonym, ata_dev_absent().  It seems like a lot of the 
constructs are "!dev_present()" anyway.

	Jeff


