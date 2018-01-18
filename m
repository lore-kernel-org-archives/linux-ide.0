From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: remove pata_at32
Date: Thu, 18 Jan 2018 13:18:00 -0800
Message-ID: <20180118211800.GZ3460072@devbig577.frc2.facebook.com>
References: <20180118200534.12700-1-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180118200534.12700-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: b.zolnierkie@samsung.com, kngregertsen@norway.atmel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jan 18, 2018 at 09:05:34PM +0100, Corentin Labbe wrote:
> Since AVR32 was removed, pata_at32 is unselectable/uncompilable.
> Remove this driver.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Applied to libata/for-4.16.

Thanks.

-- 
tejun
