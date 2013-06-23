From: Marcus Overhagen <marcus.overhagen@gmail.com>
Subject: Re: SATA hdd refuses to reallocate a sector?
Date: Sun, 23 Jun 2013 15:16:33 +0200
Message-ID: <CAJBHPoj5hgp97=JH8UKX+Ty8TF9_ySQUYU6AnqcRjuLy5A-PcQ@mail.gmail.com>
References: <20130623101940.GA4448@amd.pavel.ucw.cz>
	<20130623112133.GA4837@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130623112133.GA4837@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, tj@kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Jun 23, 2013 at 1:21 PM, Pavel Machek <pavel@ucw.cz> wrote:

> ...Ok, lets try with dd.
>
> root@amd:~# dd if=/dev/sda4 of=/dev/zero bs=1 skip=8958947328
> dd: reading `/dev/sda4': Input/output error
> 0+0 records in
> 0+0 records out
> 0 bytes (0 B) copied, 5.05805 s, 0.0 kB/s

I once noticed a similar problem. The trouble is that the kernel
always seems to be doing a larger read access that failes for this
sector, and the write is never executed.

You can try: hdparam --write-sector 961237188 /dev/sda

Hope that helps,

Marcus
