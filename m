From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: sata_highbank: remove superfluous cast
Date: Wed, 26 Mar 2014 11:42:30 -0400
Message-ID: <20140326154230.GG7171@htj.dyndns.org>
References: <11638294.fp3ZK6zVlg@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35082 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbaCZPmd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Mar 2014 11:42:33 -0400
Content-Disposition: inline
In-Reply-To: <11638294.fp3ZK6zVlg@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>, Rob Herring <robh@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, Mar 26, 2014 at 04:41:00PM +0100, Bartlomiej Zolnierkiewicz wrote:
> hpriv->plat_data is 'void *' so there is no need to cast it to
> 'struct ecx_plat_data *'.
> 
> Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15.  Thanks.

-- 
tejun
