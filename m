From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Tue, 10 Jan 2017 11:11:47 -0500
Message-ID: <20170110161147.GE6666@htj.duckdns.org>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Dec 30, 2016 at 03:01:15PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patchset adds m68k/Atari Falcon PATA support to libata.
> The major difference in the new libata's pata_falcon host
> driver when compared to legacy IDE's falconide host driver is
> that we are using polled PIO mode and thus avoiding the need
> for STDMA locking magic altogether.
> 
> Tested under ARAnyM emulator.

Applied 1-3 to libata/for-4.11.

Thanks.

-- 
tejun
