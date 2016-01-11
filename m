From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/2] ata: Introduce the AHCI_HFLAG_EDGE_IRQ_BROKEN in
 libahci and enabling it for ahci_xgene driver.
Date: Mon, 11 Jan 2016 11:10:11 -0500
Message-ID: <20160111161011.GD1898@mtj.duckdns.org>
References: <1452506763-18649-1-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f196.google.com ([209.85.160.196]:32929 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760814AbcAKQKN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jan 2016 11:10:13 -0500
Content-Disposition: inline
In-Reply-To: <1452506763-18649-1-git-send-email-stripathi@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: olof@lixom.net, arnd@arndb.de, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com

On Mon, Jan 11, 2016 at 03:36:01PM +0530, Suman Tripathi wrote:
> This patch set implements a workaround for an errate in the APM
> X-Gene SATA host controller with edge interrupt. The HOST_IRQ_STAT
> misses the edge interrupt from the PORT_IRQ_STAT when clearing the
> HOST_IRQ_STAT and reporting the PORT_IRQ_STAT happens in same clock
> cycle.

Heh, I don't know why but I had to pull this posting out of spam too.
For some reason, gmail thought these are spams.

-- 
tejun
