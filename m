From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] ahci: make ahci_fill_cmd_slot() take *pp instead
 of *ap
Date: Sat, 11 Feb 2006 17:53:51 -0500
Message-ID: <43EE6AFF.5070205@pobox.com>
References: <11396427621762-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:56784 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750805AbWBKWx6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Feb 2006 17:53:58 -0500
In-Reply-To: <11396427621762-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Make ahci_fill_cmd_slot() take struct ahci_port_priv *pp instead of
> struct ata_port *ap as suggested by Jeff Garzik.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-2


