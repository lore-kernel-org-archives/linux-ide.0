From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: 137 GB limit?
Date: Tue, 5 Oct 2004 09:44:35 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041005074435.GA22634@harddisk-recovery.com>
References: <4161BED1.7040401@tteng.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from users.linvision.com ([62.58.92.114]:426 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S268892AbUJEHog (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Oct 2004 03:44:36 -0400
Content-Disposition: inline
In-Reply-To: <4161BED1.7040401@tteng.com.br>
List-Id: linux-ide@vger.kernel.org
To: "Luciano A. Stertz" <luciano@tteng.com.br>
Cc: linux-ide@vger.kernel.org

On Mon, Oct 04, 2004 at 06:21:21PM -0300, Luciano A. Stertz wrote:
> 	Does Linux already support hard disks higher than 137 Gb? I guess 
> 	so.

Yes it does.

> In this case, can someone give me an idea of when was this feature 
> officially merged in the kernel? I'm running an old 2.4.20 kernel and 
> wonder whether it supports newer HDs.

IIRC support was merged in 2.4.19. I remember I needed to use Andre
Hedrick's IDE patch for 2.4.18 to address the 160GB Maxtor drives we
used at that time, but 2.4.19 ran out of the box.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
