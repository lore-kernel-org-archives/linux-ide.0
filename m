From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: duplicate variable sparse warning
Date: Tue, 09 Sep 2008 13:19:12 +0200
Message-ID: <48C65BB0.1080109@kernel.org>
References: <20080908093139.3909a3ac@extreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41652 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566AbYIILU7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Sep 2008 07:20:59 -0400
In-Reply-To: <20080908093139.3909a3ac@extreme>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Stephen Hemminger wrote:
> drivers/ata/ata_piix.c:1502:7: warning: symbol 'rc' shadows an earlier one
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
