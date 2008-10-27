From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: ahci enclosure management led sync
Date: Mon, 27 Oct 2008 23:58:13 +0900
Message-ID: <4905D705.6060107@kernel.org>
References: <20081016142619.GA8282@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44830 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321AbYJ0O6b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 10:58:31 -0400
In-Reply-To: <20081016142619.GA8282@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, kristen.c.accardi@intel.com

David Milburn wrote:
> Synchronize ahci_sw_activity and ahci_sw_activity_blink with ata_port lock.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
