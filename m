From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ATA: sata_mv: Remove unneeded forward declaration
Date: Mon, 29 Jul 2013 11:59:10 -0400
Message-ID: <20130729155910.GB22605@mtj.dyndns.org>
References: <1375111282-22624-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:34778 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364Ab3G2P7Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jul 2013 11:59:16 -0400
Content-Disposition: inline
In-Reply-To: <1375111282-22624-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>

On Mon, Jul 29, 2013 at 12:21:21PM -0300, Ezequiel Garcia wrote:
> These forward declarations are no longer needed, and are probably
> historical left-over.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Applied to libata/for-3.12.

Thanks.

-- 
tejun
