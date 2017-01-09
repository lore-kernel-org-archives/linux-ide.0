From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-eh: Use switch() instead of sparse array for
 protocol strings
Date: Mon, 9 Jan 2017 11:04:24 -0500
Message-ID: <20170109160424.GB12827@mtj.duckdns.org>
References: <1483973368-6828-1-git-send-email-geert@linux-m68k.org>
 <20170109152319.GA12827@mtj.duckdns.org>
 <CAMuHMdW6KPq6-7vmpTTv_M30zbqkdVbewgaOaCqYT+UzXpGU9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdW6KPq6-7vmpTTv_M30zbqkdVbewgaOaCqYT+UzXpGU9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello,

On Mon, Jan 09, 2017 at 04:40:19PM +0100, Geert Uytterhoeven wrote:
> There are two more that annoy me, but I don't know how to fix them:
> 
> ata_scsi_rbuf                                  -    4096   +4096
> ata_force_param_buf                            -    4096   +4096

ata_force_param_buf is __initdata and shouldn't really matter.
ata_scsi_rbuf, hmmm, idk.  Maybe we can allocate it dynamically when
registering the first ATA device so that systems w/o them can avoid
the wastage.

Thanks.

-- 
tejun
