From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Tue, 10 Jan 2017 11:09:31 -0500
Message-ID: <20170110160931.GD6666@htj.duckdns.org>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <CAMuHMdVpnhTNSRZ1h-q8+d0wjDKSHtev0eyVoVxYWhf0DCD+zg@mail.gmail.com>
 <3908219.8toGAOhnv9@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3908219.8toGAOhnv9@amdc3058>
Sender: linux-m68k-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello,

On Mon, Jan 09, 2017 at 05:11:12PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Disabling CONFIG_ATA_VERBOSE_ERROR saved 1380 bytes, which is less than the
> > value advertised by Kconfig (6KB).
> 
> If it is only ~1kB nowadays I would vote for making the error logging always
> verbose and just removing CONFIG_ATA_VERBOSE_ERROR, Tejun?

No objection from me.

Thanks.

-- 
tejun
