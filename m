From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.5.70-bk[56] breaks disk partitioning with multiple IDE disks
Date: Sun, 1 Jun 2003 23:05:46 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030602060546.GM8978@holomorphy.com>
References: <200306020045.h520j9v15291@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from holomorphy.com ([66.224.33.161]:45724 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261928AbTFBFxX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2003 01:53:23 -0400
Content-Disposition: inline
In-Reply-To: <200306020045.h520j9v15291@freya.yggdrasil.com>
List-Id: linux-ide@vger.kernel.org
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 05:45:09PM -0700, Adam J. Richter wrote:
> @@ -1436,6 +1437,9 @@
>  	spin_unlock(&drivers_lock);
>  	if(idedefault_driver.attach(drive) != 0)
>  		panic("ide: default attach failed");
> +	spin_lock(&drives_lock);
> +	list_add_tail(&drive->list, &ata_unused);
> +	spin_unlock(&drives_lock);
>  	return 1;
>  }

This looks dubious; check idedefault_driver.attach(). It was just put on
another list. I don't know what you're trying to do but list_move_tail()
would at least not be as oopsable.


-- wli
