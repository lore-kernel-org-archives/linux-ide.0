From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] ahci: mtk: Change driver name to ahci-mtk
Date: Mon, 4 Dec 2017 12:35:52 -0800
Message-ID: <20171204203552.GI2421075@devbig577.frc2.facebook.com>
References: <20171201104722.17353-1-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201104722.17353-1-matthias.bgg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
List-Id: linux-ide@vger.kernel.org

On Fri, Dec 01, 2017 at 11:47:22AM +0100, Matthias Brugger wrote:
> The driver name "ahci" is already used by the ahci platform driver.
> This leads to the following error:
> Error: Driver 'ahci' is already registered, aborting...
> 
> Change the name to ahci-mtk to fix this.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Applied to libata/for-4.15-fixes.

Thanks.

-- 
tejun
